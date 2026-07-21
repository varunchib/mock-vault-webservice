package httpapi

import (
	"bytes"
	"context"
	cryptorand "crypto/rand"
	"encoding/hex"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net"
	"net/http"
	"regexp"
	"strconv"
	"strings"
	"sync"
	"time"

	"github.com/redis/go-redis/v9"
	"golang.org/x/sync/singleflight"

	"mock-vault-webservice/internal/auth"
	"mock-vault-webservice/internal/config"
	"mock-vault-webservice/internal/indexnow"
	"mock-vault-webservice/internal/models"
	"mock-vault-webservice/internal/repository" //nolint:depguard
)

const (
	accessCookieName  = "pyqv_access"
	refreshCookieName = "pyqv_refresh"
)

type ctxKey string

const authUserKey ctxKey = "auth_user"

type Server struct {
	cfg    config.Config
	repo   *repository.PostgresRepository
	auth   *auth.Service
	rdb    *redis.Client
	idx    *indexnow.Client // nil when INDEXNOW_KEY is unset
	mux    *http.ServeMux
	sfg    singleflight.Group // cache stampede protection
	stopCh chan struct{}
}

// discardWriter absorbs writes inside singleflight closures (data-only handlers)
type discardWriter struct{ h http.Header }

func newDiscardWriter() *discardWriter               { return &discardWriter{h: make(http.Header)} }
func (d *discardWriter) Header() http.Header         { return d.h }
func (d *discardWriter) Write(b []byte) (int, error) { return len(b), nil }
func (d *discardWriter) WriteHeader(int)             {}

type errorResponse struct {
	Message string `json:"message"`
}

type authResponse struct {
	User models.User `json:"user"`
}

// liveAttemptState is the per-user per-paper state stored in Redis during an active attempt.
// ExpiresAt is the authoritative deadline — set once at creation, never updated by sync calls.
// RemainingSeconds is NOT stored; it is computed as max(0, ExpiresAt - now) on every read.
type liveAttemptState struct {
	AttemptID      string            `json:"attemptId"`
	PaperSlug      string            `json:"paperSlug"`
	ExamSlug       string            `json:"examSlug"`
	PaperTitle     string            `json:"paperTitle"`
	ExamName       string            `json:"examName"`
	TotalQuestions int               `json:"totalQuestions"`
	Answers        map[string]string `json:"answers"`
	Marked         map[string]bool   `json:"marked"`
	CurrentIndex   int               `json:"currentIndex"`
	ExpiresAt      time.Time         `json:"expiresAt"`
	StartedAt      time.Time         `json:"startedAt"`
	Resumed        bool              `json:"resumed"`
}

type activeAttemptInfo struct {
	PaperSlug        string    `json:"paperSlug"`
	ExamSlug         string    `json:"examSlug"`
	PaperTitle       string    `json:"paperTitle"`
	ExamName         string    `json:"examName"`
	TotalQuestions   int       `json:"totalQuestions"`
	AnsweredCount    int       `json:"answeredCount"`
	CurrentIndex     int       `json:"currentIndex"`
	RemainingSeconds int       `json:"remainingSeconds"`
	StartedAt        time.Time `json:"startedAt"`
}

const liveAttemptTTL = 24 * time.Hour

// Secondary indexes so active-attempt lookups never need a full Redis SCAN:
//
//	liveIndexKey(user)  → SET of the user's active paperSlugs (per-user reads)
//	liveGlobalZKey      → ZSET member "userID:paperSlug", score = ExpiresAt unix
//	                      (background expiry sweep + admin active-user count)
const (
	liveIndexPrefix = "live:index:"
	liveGlobalZKey  = "live:attempts"
)

// Visit tracking (all Redis, no Postgres writes):
//
//	presenceZKey            → ZSET member userID, score = last-seen unix; the
//	                          admin "live users" count = members seen <5 min ago
//	visitsRecentPrefix + id → LIST of JSON {type, slug, at}, newest first,
//	                          trimmed to 15, 7-day TTL — "recently visited"
//	visitsTopPrefix + month → ZSET member "type:slug", score = visit count for
//	                          that calendar month, ~40-day TTL — top-visited graph
const (
	presenceZKey   = "presence:users"
	presenceWindow = 5 * time.Minute
	// adminActiveUsersMax caps the live-users panel opened from the green dot.
	adminActiveUsersMax = 20
	visitsRecentPrefix  = "visits:recent:"
	// 7 days, not 24h: the TTL is refreshed on every visit, so this means "kept
	// for 7 days after the user's last activity". Admins inspecting a user need
	// multi-day recall — with 24h, clicking anyone idle since yesterday showed an
	// empty list and read as a broken feature. ~15 entries x ~70B = ~1KB/user.
	visitsRecentTTL = 7 * 24 * time.Hour
	visitsRecentMax = 15
	visitsTopPrefix    = "visits:top:"
	visitsTopTTL       = 40 * 24 * time.Hour
)

func visitsTopKey(t time.Time) string { return visitsTopPrefix + t.UTC().Format("2006-01") }

func liveAttemptRedisKey(userID, paperSlug string) string {
	return "live:attempt:" + userID + ":" + paperSlug
}

func liveIndexKey(userID string) string          { return liveIndexPrefix + userID }
func liveMember(userID, paperSlug string) string { return userID + ":" + paperSlug }

// splitLiveMember parses "userID:paperSlug". Neither field ever contains a colon
// (Google subject IDs are numeric, slugs are hyphenated), so the first colon splits.
func splitLiveMember(member string) (userID, paperSlug string, ok bool) {
	i := strings.Index(member, ":")
	if i < 0 {
		return "", "", false
	}
	return member[:i], member[i+1:], true
}

// trackLiveAttempt records an active attempt in both secondary indexes.
func (s *Server) trackLiveAttempt(ctx context.Context, userID, paperSlug string, expiresAt time.Time) {
	if s.rdb == nil {
		return
	}
	pipe := s.rdb.Pipeline()
	pipe.SAdd(ctx, liveIndexKey(userID), paperSlug)
	pipe.Expire(ctx, liveIndexKey(userID), liveAttemptTTL)
	pipe.ZAdd(ctx, liveGlobalZKey, redis.Z{Score: float64(expiresAt.Unix()), Member: liveMember(userID, paperSlug)})
	_, _ = pipe.Exec(ctx)
}

// clearLiveAttempt removes the attempt state and both index entries.
func (s *Server) clearLiveAttempt(ctx context.Context, userID, paperSlug string) {
	if s.rdb == nil {
		return
	}
	pipe := s.rdb.Pipeline()
	pipe.Del(ctx, liveAttemptRedisKey(userID, paperSlug))
	pipe.SRem(ctx, liveIndexKey(userID), paperSlug)
	pipe.ZRem(ctx, liveGlobalZKey, liveMember(userID, paperSlug))
	_, _ = pipe.Exec(ctx)
}

func NewServer(cfg config.Config, repo *repository.PostgresRepository, authService *auth.Service, rdb *redis.Client) *Server {
	server := &Server{
		cfg:    cfg,
		repo:   repo,
		auth:   authService,
		rdb:    rdb,
		idx:    indexnow.New(cfg.IndexNowKey, cfg.SiteHost),
		mux:    http.NewServeMux(),
		stopCh: make(chan struct{}),
	}
	server.registerRoutes()
	server.startLiveAttemptExpiry()
	return server
}

// Shutdown signals background goroutines to stop. Call before http.Server.Shutdown.
func (s *Server) Shutdown() {
	close(s.stopCh)
}

func (s *Server) Handler() http.Handler {
	return s.securityHeaders(s.cors(s.withRateLimit("global", 300, time.Minute, s.limitRequestBody(s.mux))))
}

// limitRequestBody caps non-GET/HEAD/OPTIONS request bodies at 32 MB to prevent OOM attacks.
func (s *Server) limitRequestBody(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet, http.MethodHead, http.MethodOptions:
		default:
			r.Body = http.MaxBytesReader(w, r.Body, 32<<20)
		}
		next.ServeHTTP(w, r)
	})
}

// realIP extracts the leftmost non-proxy IP from forwarding headers.
func realIP(r *http.Request) string {
	if xff := r.Header.Get("X-Forwarded-For"); xff != "" {
		if i := strings.Index(xff, ","); i != -1 {
			return strings.TrimSpace(xff[:i])
		}
		return strings.TrimSpace(xff)
	}
	if xri := r.Header.Get("X-Real-Ip"); xri != "" {
		return strings.TrimSpace(xri)
	}
	host, _, err := net.SplitHostPort(r.RemoteAddr)
	if err != nil {
		return r.RemoteAddr
	}
	return host
}

// checkRateLimit uses a Redis fixed-window counter.
// Returns (allowed, remaining). Fails open when Redis is unavailable.
func (s *Server) checkRateLimit(ctx context.Context, key string, limit int, window time.Duration) (bool, int64) {
	if s.rdb == nil {
		return true, int64(limit)
	}
	pipe := s.rdb.Pipeline()
	incr := pipe.Incr(ctx, key)
	pipe.Expire(ctx, key, window)
	if _, err := pipe.Exec(ctx); err != nil {
		return true, int64(limit) // Redis down → fail open, never block traffic
	}
	count := incr.Val()
	if count <= int64(limit) {
		return true, int64(limit) - count
	}
	return false, 0
}

// withRateLimit wraps a handler with per-IP fixed-window rate limiting.
func (s *Server) withRateLimit(category string, limit int, window time.Duration, next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ip := realIP(r)
		key := fmt.Sprintf("rl:%s:%s", category, ip)
		allowed, remaining := s.checkRateLimit(r.Context(), key, limit, window)
		w.Header().Set("X-RateLimit-Limit", strconv.Itoa(limit))
		w.Header().Set("X-RateLimit-Remaining", strconv.FormatInt(remaining, 10))
		if !allowed {
			w.Header().Set("Retry-After", strconv.Itoa(int(window.Seconds())))
			s.respondError(w, http.StatusTooManyRequests, "Too many requests — please slow down")
			return
		}
		next.ServeHTTP(w, r)
	})
}

func (s *Server) securityHeaders(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		h := w.Header()
		h.Set("X-Content-Type-Options", "nosniff")
		h.Set("X-Frame-Options", "DENY")
		h.Set("Referrer-Policy", "strict-origin-when-cross-origin")
		h.Set("Permissions-Policy", "camera=(), microphone=(), geolocation=()")
		h.Set("X-XSS-Protection", "0")
		if s.cfg.CookieSecure {
			h.Set("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload")
		}
		next.ServeHTTP(w, r)
	})
}

func (s *Server) registerRoutes() {
	s.mux.HandleFunc("GET /", s.handleRoot)
	s.mux.HandleFunc("GET /robots.txt", s.handleRobotsTxt)
	s.mux.HandleFunc("GET /sitemap.xml", s.handleSitemap)
	s.mux.HandleFunc("GET /api/v1/health", s.handleHealth)

	// Auth endpoints: strict 15 req/min per IP — brute force protection
	// Login and refresh must NOT share a bucket: every authed page bootstrap
	// with an expired access token spends a refresh, so a few open tabs used to
	// drain the combined 15/min pool and 429 the actual LOGIN. Refresh is cheap
	// and useless to brute-force without a valid cookie, so it gets a wide
	// window; login stays tight enough to blunt credential stuffing. Both are
	// per-IP, and Indian mobile carriers CGNAT many users onto one IP — another
	// reason 15/min combined was far too low.
	s.mux.Handle("POST /api/v1/auth/google", s.withRateLimit("auth-login", 30, time.Minute, http.HandlerFunc(s.handleGoogleLogin)))
	s.mux.Handle("POST /api/v1/auth/refresh", s.withRateLimit("auth-refresh", 120, time.Minute, http.HandlerFunc(s.handleRefresh)))
	s.mux.Handle("GET /api/v1/auth/me", s.withAuth(http.HandlerFunc(s.handleMe), false))
	s.mux.Handle("POST /api/v1/auth/logout", s.withAuth(http.HandlerFunc(s.handleLogout), false))

	// Public catalog endpoints — per-IP rate limits to block scrapers/bots.
	// Global 300/min still applies on top of these.
	s.mux.Handle("GET /api/v1/exams", s.withRateLimit("catalog", 60, time.Minute,
		s.cachedPublic("catalog:exams", 5*time.Minute, s.handleListExams)))
	s.mux.Handle("GET /api/v1/exams/{slug}", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(5*time.Minute, func(r *http.Request) string {
			return "exam:" + r.PathValue("slug")
		}, s.handleGetExam)))
	s.mux.Handle("GET /api/v1/exams/{slug}/papers", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(5*time.Minute, func(r *http.Request) string {
			return "papers:exam:" + r.PathValue("slug")
		}, s.handleListExamPapers)))
	s.mux.Handle("GET /api/v1/exams/{slug}/questions", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(5*time.Minute, func(r *http.Request) string {
			return "questions:exam:" + r.PathValue("slug")
		}, s.handleListExamQuestions)))
	s.mux.Handle("GET /api/v1/questions/{slug}", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(5*time.Minute, func(r *http.Request) string {
			return "question:" + r.PathValue("slug")
		}, s.handleGetQuestion)))
	s.mux.Handle("GET /api/v1/papers", s.withRateLimit("catalog", 60, time.Minute,
		s.cachedPublic("papers:all", 5*time.Minute, s.handleListPapers)))
	s.mux.Handle("GET /api/v1/papers/{slug}", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(5*time.Minute, func(r *http.Request) string {
			return "paper:" + r.PathValue("slug")
		}, s.handleGetPaper)))
	s.mux.Handle("GET /api/v1/papers/{slug}/questions", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(5*time.Minute, func(r *http.Request) string {
			return "paper:questions:" + r.PathValue("slug")
		}, s.handleListPaperQuestions)))
	s.mux.Handle("GET /api/v1/mocks", s.withRateLimit("catalog", 60, time.Minute,
		s.cachedPublic("mocks:all", 5*time.Minute, s.handleListMocks)))
	s.mux.Handle("GET /api/v1/mocks/{slug}", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(5*time.Minute, func(r *http.Request) string {
			return "mock:" + r.PathValue("slug")
		}, s.handleGetMock)))
	s.mux.Handle("GET /api/v1/mocks/{slug}/questions", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(5*time.Minute, func(r *http.Request) string {
			return "mock:questions:" + r.PathValue("slug")
		}, s.handleListMockQuestions)))
	s.mux.Handle("GET /api/v1/exams/{slug}/cutoffs", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(5*time.Minute, func(r *http.Request) string {
			return "cutoffs:exam:" + r.PathValue("slug")
		}, s.handleGetExamCutoffs)))

	s.mux.Handle("GET /api/v1/dashboard", s.withAuth(http.HandlerFunc(s.handleDashboard), false))
	s.mux.Handle("POST /api/v1/activity/enroll", s.withAuth(http.HandlerFunc(s.handleEnroll), false))
	s.mux.Handle("DELETE /api/v1/activity/enroll", s.withAuth(http.HandlerFunc(s.handleUnenroll), false))
	s.mux.Handle("GET /api/v1/user/enrolled-slugs", s.withAuth(http.HandlerFunc(s.handleEnrolledSlugs), false))
	s.mux.Handle("POST /api/v1/activity/attempt", s.withAuth(http.HandlerFunc(s.handleRecordAttempt), false))
	s.mux.Handle("POST /api/v1/activity/attempt/start", s.withAuth(http.HandlerFunc(s.handleStartLiveAttempt), false))
	s.mux.Handle("PUT /api/v1/activity/attempt/sync", s.withAuth(http.HandlerFunc(s.handleSyncLiveAttempt), false))
	s.mux.Handle("GET /api/v1/activity/attempt/active", s.withAuth(http.HandlerFunc(s.handleGetActiveLiveAttempts), false))
	s.mux.Handle("POST /api/v1/activity/attempt/submit", s.withAuth(http.HandlerFunc(s.handleSubmitLiveAttempt), false))
	s.mux.Handle("GET /api/v1/analytics/leaderboard", s.withAuth(http.HandlerFunc(s.handleExamLeaderboard), false))
	s.mux.Handle("POST /api/v1/activity/visit", s.withAuth(http.HandlerFunc(s.handleRecordVisit), false))
	s.mux.Handle("GET /api/v1/activity/recent-visits", s.withAuth(http.HandlerFunc(s.handleRecentVisits), false))
	s.mux.Handle("GET /api/v1/admin/top-visited", s.withAuth(http.HandlerFunc(s.handleAdminTopVisited), true))
	s.mux.Handle("GET /api/v1/analytics/score-distribution",
		s.cachedPublicKey(60*time.Second, func(r *http.Request) string {
			return "scoredist:" + strings.TrimSpace(r.URL.Query().Get("examSlug"))
		}, s.handleScoreDistribution))
	s.mux.Handle("GET /api/v1/admin/summary", s.withAuth(http.HandlerFunc(s.handleAdminSummary), true))
	s.mux.Handle("POST /api/v1/admin/exams", s.withAuth(http.HandlerFunc(s.handleCreateExam), true))
	s.mux.Handle("DELETE /api/v1/admin/exams/{slug}", s.withAuth(http.HandlerFunc(s.handleDeleteExam), true))
	s.mux.Handle("POST /api/v1/admin/mocks", s.withAuth(http.HandlerFunc(s.handleCreateMock), true))
	s.mux.Handle("DELETE /api/v1/admin/mocks/{slug}", s.withAuth(http.HandlerFunc(s.handleDeleteMock), true))
	s.mux.Handle("DELETE /api/v1/admin/questions/{slug}", s.withAuth(http.HandlerFunc(s.handleDeleteQuestion), true))
	s.mux.Handle("PUT /api/v1/admin/questions/{slug}", s.withAuth(http.HandlerFunc(s.handleUpdateQuestion), true))
	s.mux.Handle("POST /api/v1/admin/papers", s.withAuth(http.HandlerFunc(s.handleCreatePaper), true))
	s.mux.Handle("DELETE /api/v1/admin/papers/{slug}", s.withAuth(http.HandlerFunc(s.handleDeletePaper), true))
	s.mux.Handle("POST /api/v1/admin/cache-flush", s.withAuth(http.HandlerFunc(s.handleFlushCache), true))
	s.mux.Handle("POST /api/v1/admin/cutoffs", s.withAuth(http.HandlerFunc(s.handleUpsertCutoff), true))
	s.mux.Handle("GET /api/v1/admin/users", s.withAuth(http.HandlerFunc(s.handleAdminListUsers), true))
	s.mux.Handle("PATCH /api/v1/admin/users/{id}/status", s.withAuth(http.HandlerFunc(s.handleAdminUpdateUserStatus), true))
	s.mux.Handle("GET /api/v1/admin/users/{id}/detail", s.withAuth(http.HandlerFunc(s.handleAdminUserDetail), true))
	s.mux.Handle("GET /api/v1/admin/users/{id}/analytics", s.withAuth(http.HandlerFunc(s.handleAdminUserAnalytics), true))
	s.mux.Handle("GET /api/v1/admin/active-count", s.withAuth(http.HandlerFunc(s.handleAdminActiveCount), true))
	s.mux.Handle("GET /api/v1/admin/active-users", s.withAuth(http.HandlerFunc(s.handleAdminActiveUsers), true))
	s.mux.Handle("GET /api/v1/admin/audit", s.withAuth(http.HandlerFunc(s.handleListAudit), true))
	s.mux.Handle("POST /api/v1/admin/indexnow/submit-all", s.withAuth(http.HandlerFunc(s.handleIndexNowSubmitAll), true))

	// Inbox
	s.mux.Handle("POST /api/v1/inbox", s.withAuth(http.HandlerFunc(s.handleInboxCreate), false))
	s.mux.Handle("GET /api/v1/inbox/me", s.withAuth(http.HandlerFunc(s.handleInboxMe), false))
	s.mux.Handle("POST /api/v1/inbox/{threadId}/message", s.withAuth(http.HandlerFunc(s.handleInboxUserMessage), false))
	s.mux.Handle("GET /api/v1/admin/inbox", s.withAuth(http.HandlerFunc(s.handleAdminInboxList), true))
	s.mux.Handle("POST /api/v1/admin/inbox/{threadId}/reply", s.withAuth(http.HandlerFunc(s.handleAdminInboxReply), true))
	s.mux.Handle("DELETE /api/v1/admin/inbox/{threadId}", s.withAuth(http.HandlerFunc(s.handleAdminInboxDelete), true))

	// Reports
	s.mux.Handle("POST /api/v1/reports", s.withAuth(http.HandlerFunc(s.handleSubmitReport), false))
	s.mux.Handle("GET /api/v1/admin/reports", s.withAuth(http.HandlerFunc(s.handleListReports), true))
	s.mux.Handle("DELETE /api/v1/admin/reports", s.withAuth(http.HandlerFunc(s.handleClearReports), true))
}

func (s *Server) handleRoot(w http.ResponseWriter, r *http.Request) {
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "mock-vault-webservice is running"})
}

func (s *Server) handleRobotsTxt(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/plain; charset=utf-8")
	w.Header().Set("Cache-Control", "public, max-age=86400")
	fmt.Fprintln(w, "User-agent: *\nDisallow: /")
}

func (s *Server) handleSitemap(w http.ResponseWriter, r *http.Request) {
	const sfKey = "sitemap:xml"
	const cacheKey = "cache:sitemap:xml"
	const ttl = time.Hour

	if s.rdb != nil {
		if raw, err := s.rdb.Get(r.Context(), cacheKey).Bytes(); err == nil && len(raw) > 0 {
			writeSitemapResponse(w, raw)
			return
		}
	}

	val, err, _ := s.sfg.Do(sfKey, func() (interface{}, error) {
		ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
		defer cancel()
		entries, err := s.repo.ListSitemapEntries(ctx)
		if err != nil {
			return nil, err
		}
		data := buildSitemapXML(entries)
		if s.rdb != nil {
			_ = s.rdb.Set(context.Background(), cacheKey, data, ttl).Err()
		}
		return data, nil
	})
	if err != nil {
		http.Error(w, "internal error", http.StatusInternalServerError)
		return
	}
	writeSitemapResponse(w, val.([]byte))
}

func writeSitemapResponse(w http.ResponseWriter, data []byte) {
	w.Header().Set("Content-Type", "application/xml; charset=UTF-8")
	w.Header().Set("Cache-Control", "public, max-age=3600")
	_, _ = w.Write(data)
}

// paperCanonicalSlug maps a DB paper slug to the SEO canonical slug used in URLs.
// The paper page 301-redirects the raw slug to the canonical one, so the sitemap
// MUST emit the canonical form or Google flags "Page with redirect".
// Keep in sync with PAPER_SEO_OVERRIDES in mock-vault-webapp/src/lib/paperSeo.ts.
var paperCanonicalSlug = map[string]string{
	"jkssb-junior-assistant-pyq":        "jkssb-junior-assistant-question-paper-2026",
	"jkssb-lab-attendant-2026-may-10":   "jkssb-laboratory-attendant-question-paper-2026",
	"jkssb-wildlife-guard-2026-may-10":  "jkssb-wildlife-guard-question-paper-2026",
	"jkssb-patwari-2024-sep1-set-a":     "jkssb-patwari-question-paper-2024",
	"jkssb-veterinary-pharmacist-2025":  "jkssb-veterinary-pharmacist-question-paper-2025",
	"jkssb-finance-accounts-2024-paper": "jkssb-finance-accounts-assistant-question-paper-2024",
}

// sitemapGuideSlugs are the editorial /guide/:slug pages (rendered by the Worker).
// Keep in sync with the keys of postGuides in mock-vault-webapp/src/data/postGuides.ts.
var sitemapGuideSlugs = []string{
	"jkpsi", "jkpsi-telecom", "upsc-cse", "ssc-cgl", "bpsc", "ibps-po", "jkpsc", "rssb", "jkssb", "neet-ug",
	"jkssb-patwari", "jkssb-junior-assistant", "jkssb-faa", "jkssb-wildlife-guard", "jkssb-veterinary-pharmacist",
}

// canonicalPyqSlug maps a DB paper slug to the SEO slug actually used in URLs.
func canonicalPyqSlug(slug string) string {
	if c, ok := paperCanonicalSlug[slug]; ok {
		return c
	}
	return slug
}

// submitIndexNowPaths converts site paths to absolute URLs and submits them.
func (s *Server) submitIndexNowPaths(ctx context.Context, paths []string) {
	if s.idx == nil || len(paths) == 0 {
		return
	}
	urls := make([]string, 0, len(paths))
	for _, p := range paths {
		if p != "" {
			urls = append(urls, "https://"+s.cfg.SiteHost+p)
		}
	}
	if err := s.idx.Submit(ctx, urls); err != nil {
		log.Printf("indexnow submit: %v", err)
	}
}

// pingIndexNow notifies IndexNow about changed paths in the background.
func (s *Server) pingIndexNow(paths ...string) {
	if s.idx == nil {
		return
	}
	queued := append([]string(nil), paths...)
	go func() {
		ctx, cancel := context.WithTimeout(context.Background(), 20*time.Second)
		defer cancel()
		s.submitIndexNowPaths(ctx, queued)
	}()
}

// pingIndexNowPaper submits a paper page, its exam hub, and all of its question
// pages — the set of URLs that change when a paper is added or edited.
func (s *Server) pingIndexNowPaper(paperSlug, examSlug string) {
	if s.idx == nil {
		return
	}
	go func() {
		ctx, cancel := context.WithTimeout(context.Background(), 45*time.Second)
		defer cancel()
		paths := []string{"/pyq/" + canonicalPyqSlug(paperSlug)}
		if examSlug != "" {
			paths = append(paths, "/exam/"+examSlug)
		}
		if questions, err := s.repo.ListQuestionsByPaper(ctx, paperSlug); err == nil {
			for _, q := range questions {
				paths = append(paths, "/question/"+q.Slug)
			}
		}
		s.submitIndexNowPaths(ctx, paths)
	}()
}

func buildSitemapXML(entries []repository.SitemapEntry) []byte {
	const base = "https://ministryofpapers.com"
	// Exams that have a real /overview page (examInfo content). jkpsi is intentionally
	// excluded: it has no exam row and no overview content, so its URL would redirect.
	overviewSlugs := map[string]bool{
		"jkssb":    true,
		"ssc-cgl":  true,
		"upsc-cse": true,
		"ibps-po":  true,
		"bpsc":     true,
		"rssb":     true,
		"jkpsc":    true,
	}
	var buf bytes.Buffer
	buf.WriteString("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
	buf.WriteString("<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n")

	for _, p := range []struct {
		loc, freq string
		pri       float64
	}{
		{"/", "weekly", 1.0},
		{"/exams", "daily", 0.9},
		{"/about", "monthly", 0.5},
		{"/privacy", "yearly", 0.3},
		{"/terms", "yearly", 0.3},
	} {
		fmt.Fprintf(&buf,
			"  <url>\n    <loc>%s%s</loc>\n    <changefreq>%s</changefreq>\n    <priority>%.1f</priority>\n  </url>\n",
			base, p.loc, p.freq, p.pri)
	}

	for _, e := range entries {
		var loc, freq string
		var pri float64
		switch e.Kind {
		case "exam":
			loc = "/exam/" + e.Slug
			freq = "weekly"
			pri = 0.9
		case "paper":
			slug := e.Slug
			if canon, ok := paperCanonicalSlug[slug]; ok {
				slug = canon
			}
			loc = "/pyq/" + slug
			freq = "monthly"
			pri = 0.8
		case "mock_exam":
			loc = "/mock-test/" + e.Slug
			freq = "monthly"
			pri = 0.8
		case "question":
			loc = "/question/" + e.Slug
			freq = "monthly"
			pri = 0.6
		default:
			continue
		}
		fmt.Fprintf(&buf,
			"  <url>\n    <loc>%s%s</loc>\n    <lastmod>%s</lastmod>\n    <changefreq>%s</changefreq>\n    <priority>%.1f</priority>\n  </url>\n",
			base, loc, e.UpdatedAt.UTC().Format("2006-01-02"), freq, pri)
		if e.Kind == "exam" && overviewSlugs[e.Slug] {
			fmt.Fprintf(&buf,
				"  <url>\n    <loc>%s/exam/%s/overview</loc>\n    <lastmod>%s</lastmod>\n    <changefreq>monthly</changefreq>\n    <priority>0.9</priority>\n  </url>\n",
				base, e.Slug, e.UpdatedAt.UTC().Format("2006-01-02"))
		}
	}

	// Editorial guide pages (not in the DB — rendered by the Worker).
	for _, slug := range sitemapGuideSlugs {
		fmt.Fprintf(&buf,
			"  <url>\n    <loc>%s/guide/%s</loc>\n    <changefreq>monthly</changefreq>\n    <priority>0.7</priority>\n  </url>\n",
			base, slug)
	}

	buf.WriteString("</urlset>")
	return buf.Bytes()
}

func (s *Server) handleHealth(w http.ResponseWriter, r *http.Request) {
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "ok"})
}

func (s *Server) handleGoogleLogin(w http.ResponseWriter, r *http.Request) {
	var req struct {
		Credential string `json:"credential"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	if strings.TrimSpace(req.Credential) == "" {
		s.respondError(w, http.StatusBadRequest, "Credential is required")
		return
	}

	result, err := s.auth.AuthenticateGoogle(r.Context(), req.Credential, sessionMetadataFromRequest(r))
	if err != nil {
		s.handleAuthError(w, err)
		return
	}

	s.setSessionCookies(w, result)
	s.respondJSON(w, http.StatusOK, authResponse{User: result.User})
}

func (s *Server) handleRefresh(w http.ResponseWriter, r *http.Request) {
	refreshCookie, err := r.Cookie(refreshCookieName)
	if err != nil || strings.TrimSpace(refreshCookie.Value) == "" {
		s.respondError(w, http.StatusUnauthorized, "Refresh session not found")
		return
	}

	result, err := s.auth.RefreshSession(r.Context(), refreshCookie.Value, sessionMetadataFromRequest(r))
	if err != nil {
		s.clearSessionCookies(w)
		s.handleAuthError(w, err)
		return
	}

	s.setSessionCookies(w, result)
	s.respondJSON(w, http.StatusOK, authResponse{User: result.User})
}

func (s *Server) handleMe(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}
	s.respondJSON(w, http.StatusOK, authResponse{User: user})
}

func (s *Server) handleLogout(w http.ResponseWriter, r *http.Request) {
	tokenString := s.readAccessToken(r)
	if tokenString != "" {
		claims, err := s.auth.ParseAccessToken(tokenString)
		if err == nil {
			_ = s.auth.Logout(r.Context(), claims.SessionID)
		}
	}
	s.clearSessionCookies(w)
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "Logged out"})
}

func (s *Server) handleListExams(w http.ResponseWriter, r *http.Request) (any, error) {
	return s.repo.ListExams(r.Context())
}

func (s *Server) handleGetExam(w http.ResponseWriter, r *http.Request) (any, error) {
	return s.repo.GetExamBySlug(r.Context(), r.PathValue("slug"))
}

func (s *Server) handleListExamPapers(w http.ResponseWriter, r *http.Request) (any, error) {
	return s.repo.ListPapersByExam(r.Context(), r.PathValue("slug"))
}

func (s *Server) handleListExamQuestions(w http.ResponseWriter, r *http.Request) (any, error) {
	return s.repo.ListQuestionsByExam(r.Context(), r.PathValue("slug"))
}

func (s *Server) handleGetQuestion(w http.ResponseWriter, r *http.Request) (any, error) {
	return s.repo.GetQuestionBySlug(r.Context(), r.PathValue("slug"))
}

func (s *Server) handleListPapers(w http.ResponseWriter, r *http.Request) (any, error) {
	return s.repo.ListPapers(r.Context())
}

func (s *Server) handleGetPaper(w http.ResponseWriter, r *http.Request) (any, error) {
	return s.repo.GetPaperBySlug(r.Context(), r.PathValue("slug"))
}

func (s *Server) handleListPaperQuestions(w http.ResponseWriter, r *http.Request) (any, error) {
	return s.repo.ListQuestionsByPaper(r.Context(), r.PathValue("slug"))
}

func (s *Server) handleListMocks(w http.ResponseWriter, r *http.Request) (any, error) {
	return s.repo.ListMocks(r.Context())
}

func (s *Server) handleGetMock(w http.ResponseWriter, r *http.Request) (any, error) {
	return s.repo.GetMockBySlug(r.Context(), r.PathValue("slug"))
}

func (s *Server) handleListMockQuestions(w http.ResponseWriter, r *http.Request) (any, error) {
	return s.repo.ListQuestionsByMock(r.Context(), r.PathValue("slug"))
}

func (s *Server) handleGetExamCutoffs(w http.ResponseWriter, r *http.Request) (any, error) {
	return s.repo.GetExamCutoffs(r.Context(), r.PathValue("slug"))
}

func (s *Server) handleUpsertCutoff(w http.ResponseWriter, r *http.Request) {
	var req struct {
		ExamSlug   string  `json:"examSlug"`
		Stage      string  `json:"stage"`
		Year       string  `json:"year"`
		Category   string  `json:"category"`
		Marks      float64 `json:"marks"`
		TotalMarks float64 `json:"totalMarks"`
		AvgScore   float64 `json:"avgScore"`
		StdDev     float64 `json:"stdDev"`
		Source     string  `json:"source"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	req.ExamSlug = strings.TrimSpace(req.ExamSlug)
	req.Stage = strings.TrimSpace(req.Stage)
	req.Year = strings.TrimSpace(req.Year)
	req.Category = strings.TrimSpace(req.Category)
	if req.Source == "" {
		req.Source = "official"
	}
	switch {
	case req.ExamSlug == "":
		s.respondError(w, http.StatusBadRequest, "examSlug is required")
		return
	case req.Stage == "":
		s.respondError(w, http.StatusBadRequest, "stage is required")
		return
	case req.Year == "":
		s.respondError(w, http.StatusBadRequest, "year is required")
		return
	case req.Category == "":
		s.respondError(w, http.StatusBadRequest, "category is required")
		return
	case req.Marks <= 0:
		s.respondError(w, http.StatusBadRequest, "marks must be greater than zero")
		return
	case req.TotalMarks <= 0:
		s.respondError(w, http.StatusBadRequest, "totalMarks must be greater than zero")
		return
	}
	if err := s.repo.UpsertExamCutoff(r.Context(),
		req.ExamSlug, req.Stage, req.Year, req.Category, req.Source,
		req.Marks, req.TotalMarks, req.AvgScore, req.StdDev,
	); err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	// Invalidate the cached cutoffs for this exam
	if s.rdb != nil {
		key := "pub:cutoffs:exam:" + req.ExamSlug
		s.rdb.Del(r.Context(), key)
	}
	s.audit(r, "cutoff.upsert", req.ExamSlug, map[string]any{"stage": req.Stage, "year": req.Year, "category": req.Category})
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "cutoff saved"})
}

func (s *Server) handleDashboard(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	var (
		exams          []models.Exam
		mocks          []models.MockItem
		enrolledExams  []models.Exam
		recentAttempts []models.RecentAttempt
		newPapers      map[string]int
		errs           [5]error
	)
	var wg sync.WaitGroup
	wg.Add(5)
	go func() { defer wg.Done(); exams, errs[0] = s.repo.ListExams(r.Context()) }()
	go func() { defer wg.Done(); mocks, errs[1] = s.repo.ListMocks(r.Context()) }()
	go func() { defer wg.Done(); enrolledExams, errs[2] = s.repo.ListUserEnrollments(r.Context(), user.ID) }()
	go func() {
		defer wg.Done()
		recentAttempts, errs[3] = s.repo.ListUserRecentAttempts(r.Context(), user.ID, 8)
	}()
	go func() {
		defer wg.Done()
		newPapers, errs[4] = s.repo.CountNewPapersForEnrollments(r.Context(), user.ID)
	}()
	wg.Wait()

	for _, err := range errs {
		if err != nil {
			s.respondRepositoryError(w, err)
			return
		}
	}
	if exams == nil {
		exams = []models.Exam{}
	}
	if mocks == nil {
		mocks = []models.MockItem{}
	}
	if enrolledExams == nil {
		enrolledExams = []models.Exam{}
	}
	if recentAttempts == nil {
		recentAttempts = []models.RecentAttempt{}
	}
	if newPapers == nil {
		newPapers = map[string]int{}
	}
	s.respondJSON(w, http.StatusOK, models.Dashboard{
		User:            user,
		Exams:           exams,
		Mocks:           mocks,
		EnrolledExams:   enrolledExams,
		RecentAttempts:  recentAttempts,
		NewPapersByExam: newPapers,
	})
}

func (s *Server) handleEnroll(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	var req struct {
		ExamSlug string `json:"examSlug"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	req.ExamSlug = strings.TrimSpace(req.ExamSlug)
	if req.ExamSlug == "" {
		s.respondError(w, http.StatusBadRequest, "examSlug is required")
		return
	}

	if err := s.repo.UpsertEnrollment(r.Context(), user.ID, req.ExamSlug); err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "enrolled"})
}

func (s *Server) handleUnenroll(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	var req struct {
		ExamSlug string `json:"examSlug"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	req.ExamSlug = strings.TrimSpace(req.ExamSlug)
	if req.ExamSlug == "" {
		s.respondError(w, http.StatusBadRequest, "examSlug is required")
		return
	}

	if err := s.repo.DeleteEnrollment(r.Context(), user.ID, req.ExamSlug); err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "unenrolled"})
}

func (s *Server) handleEnrolledSlugs(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	slugs, err := s.repo.ListUserEnrollmentSlugs(r.Context(), user.ID)
	if err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	if slugs == nil {
		slugs = []string{}
	}
	s.respondJSON(w, http.StatusOK, map[string]interface{}{"slugs": slugs})
}

func (s *Server) handleRecordAttempt(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	var req struct {
		ExamSlug  string `json:"examSlug"`
		MockSlug  string `json:"mockSlug"`
		PaperSlug string `json:"paperSlug"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	req.ExamSlug = strings.TrimSpace(req.ExamSlug)
	req.MockSlug = strings.TrimSpace(req.MockSlug)
	req.PaperSlug = strings.TrimSpace(req.PaperSlug)

	if req.ExamSlug == "" {
		s.respondError(w, http.StatusBadRequest, "examSlug is required")
		return
	}
	if req.MockSlug == "" && req.PaperSlug == "" {
		s.respondError(w, http.StatusBadRequest, "mockSlug or paperSlug is required")
		return
	}

	id := newAttemptID()
	if err := s.repo.RecordAttempt(r.Context(), id, user.ID, req.ExamSlug, req.MockSlug, req.PaperSlug); err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "recorded"})
}

func (s *Server) handleAdminSummary(w http.ResponseWriter, r *http.Request) {
	var (
		exams         []models.Exam
		paperCount    int
		mockCount     int
		questionCount int
		userCount     int
		errs          [5]error
	)
	var wg sync.WaitGroup
	wg.Add(5)
	go func() { defer wg.Done(); exams, errs[0] = s.repo.ListExams(r.Context()) }()
	go func() { defer wg.Done(); paperCount, errs[1] = s.repo.CountPapers(r.Context()) }()
	go func() { defer wg.Done(); mockCount, errs[2] = s.repo.CountMocks(r.Context()) }()
	go func() { defer wg.Done(); questionCount, errs[3] = s.repo.CountQuestions(r.Context()) }()
	go func() { defer wg.Done(); userCount, errs[4] = s.repo.CountUsers(r.Context()) }()
	wg.Wait()

	for _, err := range errs {
		if err != nil {
			s.respondRepositoryError(w, err)
			return
		}
	}
	s.respondJSON(w, http.StatusOK, map[string]any{
		"exams":         exams,
		"paperCount":    paperCount,
		"mockCount":     mockCount,
		"questionCount": questionCount,
		"userCount":     userCount,
	})
}

func (s *Server) handleCreateMock(w http.ResponseWriter, r *http.Request) {
	var req models.AdminCreateMockRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	input, err := validateCreateMockRequest(req)
	if err != nil {
		s.respondError(w, http.StatusBadRequest, err.Error())
		return
	}

	if err := s.repo.UpsertMockWithQuestions(r.Context(), input); err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	s.invalidatePublicCache(r.Context())
	s.audit(r, "mock.upsert", input.Slug, nil)
	s.respondJSON(w, http.StatusCreated, map[string]string{"message": "Mock saved", "slug": input.Slug})
}

func (s *Server) handleDeleteMock(w http.ResponseWriter, r *http.Request) {
	slug := strings.TrimSpace(r.PathValue("slug"))
	if slug == "" {
		s.respondError(w, http.StatusBadRequest, "Mock slug is required")
		return
	}
	if err := s.repo.DeleteMockBySlug(r.Context(), slug); err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	s.invalidatePublicCache(r.Context())
	s.audit(r, "mock.delete", slug, nil)
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "Mock deleted"})
}

func (s *Server) handleDeleteQuestion(w http.ResponseWriter, r *http.Request) {
	slug := strings.TrimSpace(r.PathValue("slug"))
	if slug == "" {
		s.respondError(w, http.StatusBadRequest, "Question slug is required")
		return
	}
	if err := s.repo.DeleteQuestionBySlug(r.Context(), slug); err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	s.invalidatePublicCache(r.Context())
	s.audit(r, "question.delete", slug, nil)
	s.pingIndexNow("/question/" + slug)
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "Question deleted"})
}

func (s *Server) handleUpdateQuestion(w http.ResponseWriter, r *http.Request) {
	slug := strings.TrimSpace(r.PathValue("slug"))
	if slug == "" {
		s.respondError(w, http.StatusBadRequest, "Question slug is required")
		return
	}
	var req models.AdminUpdateQuestionRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	req.Question = strings.TrimSpace(req.Question)
	req.AnswerKey = strings.ToUpper(strings.TrimSpace(req.AnswerKey))
	req.Explanation = strings.TrimSpace(req.Explanation)
	req.Subject = strings.TrimSpace(req.Subject)
	if req.Question == "" {
		s.respondError(w, http.StatusBadRequest, "question text is required")
		return
	}
	opts := cleanOptions(req.Options)
	if len(opts) < 2 {
		s.respondError(w, http.StatusBadRequest, "at least two options are required")
		return
	}
	if req.AnswerKey == "" {
		s.respondError(w, http.StatusBadRequest, "answerKey is required")
		return
	}
	if req.Tags == nil {
		req.Tags = []string{}
	}
	input := repository.UpdateQuestionInput{
		Question:    req.Question,
		Options:     opts,
		AnswerKey:   req.AnswerKey,
		Explanation: req.Explanation,
		Subject:     req.Subject,
		Tags:        cleanStrings(req.Tags),
	}
	if err := s.repo.UpdateQuestionBySlug(r.Context(), slug, input); err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	s.invalidatePublicCache(r.Context())
	s.audit(r, "question.update", slug, nil)
	s.pingIndexNow("/question/" + slug)
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "Question updated", "slug": slug})
}

func (s *Server) handleCreateExam(w http.ResponseWriter, r *http.Request) {
	var req models.AdminCreateExamRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	req.Slug = strings.TrimSpace(req.Slug)
	req.Name = strings.TrimSpace(req.Name)
	req.ShortName = strings.TrimSpace(req.ShortName)
	if req.Slug == "" || req.Name == "" || req.ShortName == "" || req.Category == "" {
		s.respondError(w, http.StatusBadRequest, "slug, name, shortName, and category are required")
		return
	}
	if err := s.repo.UpsertExam(r.Context(), req); err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	s.invalidatePublicCache(r.Context())
	s.audit(r, "exam.upsert", req.Slug, nil)
	s.pingIndexNow("/exam/"+req.Slug, "/exams")
	s.respondJSON(w, http.StatusCreated, map[string]string{"message": "Exam saved", "slug": req.Slug})
}

func (s *Server) handleDeleteExam(w http.ResponseWriter, r *http.Request) {
	slug := strings.TrimSpace(r.PathValue("slug"))
	if slug == "" {
		s.respondError(w, http.StatusBadRequest, "Exam slug is required")
		return
	}
	if err := s.repo.DeleteExamBySlug(r.Context(), slug); err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	s.invalidatePublicCache(r.Context())
	s.audit(r, "exam.delete", slug, nil)
	s.pingIndexNow("/exam/"+slug, "/exams")
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "Exam deleted"})
}

func (s *Server) handleCreatePaper(w http.ResponseWriter, r *http.Request) {
	var req models.AdminCreatePaperRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	req.Slug = strings.TrimSpace(req.Slug)
	req.ExamSlug = strings.TrimSpace(req.ExamSlug)
	req.Title = strings.TrimSpace(req.Title)
	if req.Slug == "" || req.ExamSlug == "" || req.Title == "" {
		s.respondError(w, http.StatusBadRequest, "slug, examSlug, and title are required")
		return
	}
	if err := s.repo.UpsertPaperWithQuestions(r.Context(), req); err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	s.invalidatePublicCache(r.Context())
	s.audit(r, "paper.upsert", req.Slug, nil)
	s.pingIndexNowPaper(req.Slug, req.ExamSlug)
	s.respondJSON(w, http.StatusCreated, map[string]string{"message": "Paper saved", "slug": req.Slug})
}

func (s *Server) handleDeletePaper(w http.ResponseWriter, r *http.Request) {
	slug := strings.TrimSpace(r.PathValue("slug"))
	if slug == "" {
		s.respondError(w, http.StatusBadRequest, "Paper slug is required")
		return
	}
	if err := s.repo.DeletePaperBySlug(r.Context(), slug); err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	s.invalidatePublicCache(r.Context())
	s.audit(r, "paper.delete", slug, nil)
	// Ping so search engines re-crawl and pick up the 404.
	s.pingIndexNow("/pyq/" + canonicalPyqSlug(slug))
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "Paper deleted"})
}

func (s *Server) handleFlushCache(w http.ResponseWriter, r *http.Request) {
	s.invalidatePublicCache(r.Context())
	s.audit(r, "cache.flush", "", nil)
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "Cache cleared"})
}

const (
	userCachePrefix = "cache:user:"
	userCacheTTL    = 60 * time.Second
)

// cachedUserByID fetches the (active) user, caching it in Redis for a short window
// so authenticated requests don't hit Postgres on every call. Only active users are
// cached (GetUserByID returns ErrNotFound for deactivated ones); the cache is busted
// explicitly when an admin changes a user's status.
func (s *Server) cachedUserByID(ctx context.Context, id string) (models.User, error) {
	if s.rdb != nil {
		if raw, err := s.rdb.Get(ctx, userCachePrefix+id).Bytes(); err == nil {
			var u models.User
			if json.Unmarshal(raw, &u) == nil {
				return u, nil
			}
		}
	}
	user, err := s.repo.GetUserByID(ctx, id)
	if err != nil {
		return models.User{}, err
	}
	if s.rdb != nil {
		if data, merr := json.Marshal(user); merr == nil {
			_ = s.rdb.Set(ctx, userCachePrefix+id, data, userCacheTTL).Err()
		}
	}
	return user, nil
}

func (s *Server) withAuth(next http.Handler, adminOnly bool) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		tokenString := s.readAccessToken(r)
		if tokenString == "" {
			s.respondError(w, http.StatusUnauthorized, "Unauthorized")
			return
		}

		claims, err := s.auth.ParseAccessToken(tokenString)
		if err != nil {
			s.respondError(w, http.StatusUnauthorized, "Unauthorized")
			return
		}

		active, err := s.auth.IsSessionActive(r.Context(), claims.SessionID)
		if err != nil {
			log.Printf("session validation failed: %v", err)
			s.respondError(w, http.StatusUnauthorized, "Unauthorized")
			return
		}
		if !active {
			s.clearSessionCookies(w)
			s.respondError(w, http.StatusUnauthorized, "Unauthorized")
			return
		}

		user, err := s.cachedUserByID(r.Context(), claims.Subject)
		if err != nil {
			if errors.Is(err, repository.ErrNotFound) {
				s.respondError(w, http.StatusUnauthorized, "Unauthorized")
				return
			}
			s.respondRepositoryError(w, err)
			return
		}

		if adminOnly && user.Role != "admin" {
			s.respondError(w, http.StatusForbidden, "Forbidden")
			return
		}

		// Presence heartbeat: every authenticated request stamps the user in a
		// ZSET (score = unix now). The admin "live users" count reads users
		// seen in the last 5 minutes — actual activity, not just an open
		// attempt timer. Fire-and-forget; never blocks the request.
		if s.rdb != nil {
			go func(uid string) {
				ctx, cancel := context.WithTimeout(context.Background(), 2*time.Second)
				defer cancel()
				_ = s.rdb.ZAdd(ctx, presenceZKey, redis.Z{Score: float64(time.Now().Unix()), Member: uid}).Err()
			}(user.ID)
		}

		next.ServeHTTP(w, r.WithContext(context.WithValue(r.Context(), authUserKey, user)))
	})
}

type apiHandler func(http.ResponseWriter, *http.Request) (any, error)

func (s *Server) cachedPublic(cacheKey string, ttl time.Duration, handler apiHandler) http.HandlerFunc {
	return s.cachedPublicKey(ttl, func(_ *http.Request) string { return cacheKey }, handler)
}

func (s *Server) cachedPublicKey(ttl time.Duration, makeKey func(*http.Request) string, handler apiHandler) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		cacheKey := makeKey(r)

		// 1. Serve from Redis if available (cache hit)
		if s.rdb != nil {
			if raw, err := s.rdb.Get(r.Context(), "cache:"+cacheKey).Bytes(); err == nil {
				w.Header().Set("Content-Type", "application/json")
				w.Header().Set("X-Cache", "HIT")
				w.WriteHeader(http.StatusOK)
				_, _ = w.Write(raw)
				return
			}
		}

		// 2. Cache miss — use singleflight to prevent stampede:
		//    concurrent requests for the same key share a single DB call.
		val, err, _ := s.sfg.Do("fetch:"+cacheKey, func() (interface{}, error) {
			// Detached timeout context: not tied to any single request so a
			// cancellation from one caller doesn't abort work others are waiting on.
			fetchCtx, fetchCancel := context.WithTimeout(context.Background(), 10*time.Second)
			defer fetchCancel()
			payload, herr := handler(newDiscardWriter(), r.WithContext(fetchCtx))
			if herr != nil {
				return nil, herr
			}
			body, merr := json.Marshal(payload)
			if merr != nil {
				return nil, merr
			}
			if s.rdb != nil {
				_ = s.rdb.Set(context.Background(), "cache:"+cacheKey, body, ttl).Err()
			}
			return body, nil
		})

		if err != nil {
			s.respondRepositoryError(w, err)
			return
		}

		w.Header().Set("Content-Type", "application/json")
		w.Header().Set("X-Cache", "MISS")
		w.WriteHeader(http.StatusOK)
		_, _ = w.Write(val.([]byte))
	}
}

func validateCreateMockRequest(req models.AdminCreateMockRequest) (repository.CreateMockInput, error) {
	input := repository.CreateMockInput{
		Slug:            strings.TrimSpace(req.Slug),
		ExamSlug:        strings.TrimSpace(req.ExamSlug),
		Title:           strings.TrimSpace(req.Title),
		Description:     strings.TrimSpace(req.Description),
		DurationMinutes: req.DurationMinutes,
		Difficulty:      strings.TrimSpace(req.Difficulty),
		IsFree:          req.IsFree,
		NegativeMarking: req.NegativeMarking,
		Subjects:        cleanStrings(req.Subjects),
		Questions:       make([]repository.MockQuestionInput, 0, len(req.Questions)),
	}

	switch {
	case input.Slug == "":
		return repository.CreateMockInput{}, errors.New("Mock slug is required")
	case input.ExamSlug == "":
		return repository.CreateMockInput{}, errors.New("Exam is required")
	case input.Title == "":
		return repository.CreateMockInput{}, errors.New("Mock title is required")
	case input.Description == "":
		return repository.CreateMockInput{}, errors.New("Mock description is required")
	case input.DurationMinutes <= 0:
		return repository.CreateMockInput{}, errors.New("Duration must be greater than zero")
	case input.Difficulty == "":
		input.Difficulty = "Moderate"
	}

	for _, question := range req.Questions {
		cleanQuestion := repository.MockQuestionInput{
			Question:    strings.TrimSpace(question.Question),
			Options:     cleanOptions(question.Options),
			AnswerKey:   strings.ToUpper(strings.TrimSpace(question.AnswerKey)),
			Explanation: strings.TrimSpace(question.Explanation),
			Subject:     strings.TrimSpace(question.Subject),
		}
		if cleanQuestion.Question == "" {
			continue
		}
		if len(cleanQuestion.Options) < 2 {
			return repository.CreateMockInput{}, errors.New("Each question needs at least two options")
		}
		if cleanQuestion.AnswerKey == "" {
			return repository.CreateMockInput{}, errors.New("Each question needs an answer key")
		}
		input.Questions = append(input.Questions, cleanQuestion)
	}

	if len(input.Questions) == 0 {
		return repository.CreateMockInput{}, errors.New("Add at least one question")
	}

	return input, nil
}

func cleanOptions(options []models.QuestionOption) []models.QuestionOption {
	cleaned := make([]models.QuestionOption, 0, len(options))
	for _, option := range options {
		key := strings.ToUpper(strings.TrimSpace(option.Key))
		text := strings.TrimSpace(option.Text)
		if key == "" || text == "" {
			continue
		}
		cleaned = append(cleaned, models.QuestionOption{Key: key, Text: text})
	}
	return cleaned
}

func cleanStrings(values []string) []string {
	seen := map[string]bool{}
	cleaned := make([]string, 0, len(values))
	for _, value := range values {
		value = strings.TrimSpace(value)
		if value == "" || seen[value] {
			continue
		}
		seen[value] = true
		cleaned = append(cleaned, value)
	}
	return cleaned
}

func (s *Server) invalidatePublicCache(ctx context.Context) {
	if s.rdb == nil {
		return
	}
	// Use background context — admin writes shouldn't block on cache invalidation
	bgCtx := context.Background()
	var keys []string
	iter := s.rdb.Scan(bgCtx, 0, "cache:*", 500).Iterator()
	for iter.Next(bgCtx) {
		keys = append(keys, iter.Val())
	}
	if err := iter.Err(); err != nil {
		log.Printf("cache invalidation scan failed: %v", err)
		return
	}
	if len(keys) == 0 {
		return
	}
	// UNLINK is async (non-blocking), far better than DEL for large values.
	// Batch in chunks of 100 to avoid oversized Redis commands.
	const chunkSize = 100
	for i := 0; i < len(keys); i += chunkSize {
		end := min(i+chunkSize, len(keys))
		if err := s.rdb.Unlink(bgCtx, keys[i:end]...).Err(); err != nil {
			log.Printf("cache invalidation unlink failed: %v", err)
		}
	}
}

func (s *Server) respondRepositoryError(w http.ResponseWriter, err error) {
	switch {
	case errors.Is(err, repository.ErrNotFound):
		s.respondError(w, http.StatusNotFound, "Not found")
	default:
		log.Printf("server error: %v", err)
		s.respondError(w, http.StatusInternalServerError, "Internal server error")
	}
}

func (s *Server) handleAuthError(w http.ResponseWriter, err error) {
	if errors.Is(err, auth.ErrUnauthorized) {
		s.respondError(w, http.StatusUnauthorized, "Authentication failed")
		return
	}
	log.Printf("auth error: %v", err)
	s.respondError(w, http.StatusInternalServerError, "Internal server error")
}

func (s *Server) respondJSON(w http.ResponseWriter, status int, payload any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	if err := json.NewEncoder(w).Encode(payload); err != nil {
		log.Printf("encode response: %v", err)
	}
}

func (s *Server) respondError(w http.ResponseWriter, status int, message string) {
	s.respondJSON(w, status, errorResponse{Message: message})
}

func (s *Server) setSessionCookies(w http.ResponseWriter, result auth.AuthResult) {
	http.SetCookie(w, &http.Cookie{
		Name:     accessCookieName,
		Value:    result.AccessToken,
		Path:     "/",
		Domain:   s.cfg.CookieDomain,
		Expires:  result.AccessTokenExpiresAt,
		HttpOnly: true,
		Secure:   s.cfg.CookieSecure,
		SameSite: sameSiteMode(s.cfg.CookieSameSite),
	})
	http.SetCookie(w, &http.Cookie{
		Name:     refreshCookieName,
		Value:    result.RefreshToken,
		Path:     "/",
		Domain:   s.cfg.CookieDomain,
		Expires:  result.RefreshTokenExpiresAt,
		HttpOnly: true,
		Secure:   s.cfg.CookieSecure,
		SameSite: sameSiteMode(s.cfg.CookieSameSite),
	})
}

func (s *Server) clearSessionCookies(w http.ResponseWriter) {
	for _, name := range []string{accessCookieName, refreshCookieName} {
		http.SetCookie(w, &http.Cookie{
			Name:     name,
			Value:    "",
			Path:     "/",
			Domain:   s.cfg.CookieDomain,
			Expires:  time.Unix(0, 0),
			MaxAge:   -1,
			HttpOnly: true,
			Secure:   s.cfg.CookieSecure,
			SameSite: sameSiteMode(s.cfg.CookieSameSite),
		})
	}
}

func (s *Server) readAccessToken(r *http.Request) string {
	authHeader := strings.TrimSpace(r.Header.Get("Authorization"))
	if strings.HasPrefix(strings.ToLower(authHeader), "bearer ") {
		return strings.TrimSpace(authHeader[7:])
	}

	cookie, err := r.Cookie(accessCookieName)
	if err != nil {
		return ""
	}
	return strings.TrimSpace(cookie.Value)
}

func (s *Server) cors(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		origin := strings.TrimSpace(r.Header.Get("Origin"))
		if origin != "" {
			if !s.isAllowedOrigin(origin) {
				// Disallowed origin. Block preflight and any state-changing request
				// (CSRF defense — cookies would otherwise ride along on a cross-site
				// POST/PUT/DELETE). Safe methods fall through without CORS headers,
				// so the browser still hides the response body.
				switch r.Method {
				case http.MethodGet, http.MethodHead:
					next.ServeHTTP(w, r)
				default:
					w.WriteHeader(http.StatusForbidden)
				}
				return
			}

			w.Header().Set("Access-Control-Allow-Origin", origin)
			w.Header().Set("Access-Control-Allow-Credentials", "true")
			w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")
			w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
			w.Header().Add("Vary", "Origin")
		}

		if r.Method == http.MethodOptions {
			w.WriteHeader(http.StatusNoContent)
			return
		}

		next.ServeHTTP(w, r)
	})
}

func (s *Server) isAllowedOrigin(origin string) bool {
	for _, allowedOrigin := range s.cfg.AllowedOrigins {
		if origin == allowedOrigin {
			return true
		}
	}
	return false
}

func sessionMetadataFromRequest(r *http.Request) auth.SessionMetadata {
	ip := realIP(r)
	city := strings.TrimSpace(r.Header.Get("CF-IPCity"))
	if city == "" || city == "XX" || strings.EqualFold(city, "Unknown") {
		city = cityFromIP(r.Context(), ip)
	}
	return auth.SessionMetadata{
		UserAgent: strings.TrimSpace(r.UserAgent()),
		IPAddress: ip,
		City:      city,
	}
}

// cityFromIP calls ip-api.com (free, no key) with a 1s timeout.
// Returns empty string on any failure so login is never blocked.
func cityFromIP(ctx context.Context, ip string) string {
	if ip == "" || ip == "127.0.0.1" || ip == "::1" {
		return ""
	}
	ctx, cancel := context.WithTimeout(ctx, time.Second)
	defer cancel()

	req, err := http.NewRequestWithContext(ctx, http.MethodGet,
		"http://ip-api.com/json/"+ip+"?fields=city", nil)
	if err != nil {
		return ""
	}
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return ""
	}
	defer resp.Body.Close()

	var result struct {
		City string `json:"city"`
	}
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return ""
	}
	return strings.TrimSpace(result.City)
}

func newAttemptID() string {
	b := make([]byte, 16)
	if _, err := cryptorand.Read(b); err != nil {
		panic(fmt.Sprintf("crypto/rand unavailable: %v", err))
	}
	return hex.EncodeToString(b)
}

func sameSiteMode(value string) http.SameSite {
	switch strings.ToLower(value) {
	case "strict":
		return http.SameSiteStrictMode
	case "none":
		return http.SameSiteNoneMode
	default:
		return http.SameSiteLaxMode
	}
}

func userFromContext(ctx context.Context) (models.User, bool) {
	user, ok := ctx.Value(authUserKey).(models.User)
	return user, ok
}

// audit records a privileged admin action to the audit trail. It captures the
// actor/IP synchronously (before the request is recycled), then writes in the
// background so it never blocks or fails the response. details may be nil.
func (s *Server) audit(r *http.Request, action, target string, details map[string]any) {
	user, ok := userFromContext(r.Context())
	if !ok {
		return
	}
	actorID, actorEmail, ip := user.ID, user.Email, realIP(r)
	go func() {
		ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()
		if err := s.repo.InsertAuditLog(ctx, actorID, actorEmail, action, target, ip, details); err != nil {
			log.Printf("audit %s: %v", action, err)
		}
	}()
}

// handleIndexNowSubmitAll pushes every indexable URL to IndexNow in one go —
// used to seed search engines with the existing catalogue.
func (s *Server) handleIndexNowSubmitAll(w http.ResponseWriter, r *http.Request) {
	if s.idx == nil {
		s.respondError(w, http.StatusServiceUnavailable, "IndexNow is not configured (INDEXNOW_KEY unset)")
		return
	}
	entries, err := s.repo.ListSitemapEntries(r.Context())
	if err != nil {
		s.respondRepositoryError(w, err)
		return
	}

	paths := []string{"/", "/exams", "/about", "/privacy", "/terms"}
	for _, e := range entries {
		switch e.Kind {
		case "exam":
			paths = append(paths, "/exam/"+e.Slug)
		case "paper":
			paths = append(paths, "/pyq/"+canonicalPyqSlug(e.Slug))
		case "mock_exam":
			paths = append(paths, "/mock-test/"+e.Slug)
		}
	}
	for _, g := range sitemapGuideSlugs {
		paths = append(paths, "/guide/"+g)
	}

	// Question pages are only worth a crawl once they carry a real solution.
	// Inviting search engines to mass-crawl thin pages just earns "crawled —
	// currently not indexed". Gate on explanation depth; ?minExplanation=0
	// submits everything.
	minExplanation := 300
	if v := r.URL.Query().Get("minExplanation"); v != "" {
		if n, err := strconv.Atoi(v); err == nil && n >= 0 {
			minExplanation = n
		}
	}
	structural := len(paths)
	skipped := 0
	if questions, qerr := s.repo.ListQuestions(r.Context()); qerr == nil {
		for _, q := range questions {
			if len(strings.TrimSpace(q.Explanation)) >= minExplanation {
				paths = append(paths, "/question/"+q.Slug)
			} else {
				skipped++
			}
		}
	}

	s.audit(r, "indexnow.submit_all", "", map[string]any{"urls": len(paths), "skippedThin": skipped})
	s.pingIndexNow(paths...)
	s.respondJSON(w, http.StatusAccepted, map[string]any{
		"message":        "Submitted to IndexNow",
		"urls":           len(paths),
		"structural":     structural,
		"questions":      len(paths) - structural,
		"skippedThin":    skipped,
		"minExplanation": minExplanation,
	})
}

func (s *Server) handleListAudit(w http.ResponseWriter, r *http.Request) {
	limit := 100
	if l := r.URL.Query().Get("limit"); l != "" {
		if n, err := strconv.Atoi(l); err == nil && n > 0 && n <= 500 {
			limit = n
		}
	}
	entries, err := s.repo.ListAuditLog(r.Context(), limit)
	if err != nil {
		s.respondError(w, http.StatusInternalServerError, "Failed to fetch audit log")
		return
	}
	s.respondJSON(w, http.StatusOK, map[string]any{"entries": entries, "count": len(entries)})
}

// ── Reports ──────────────────────────────────────────────────────────────────

const reportListKey = "admin:reports"

func (s *Server) handleSubmitReport(w http.ResponseWriter, r *http.Request) {
	user, _ := userFromContext(r.Context())
	var req struct {
		QuestionSlug string `json:"questionSlug"`
		QuestionNo   string `json:"questionNo"`
		PaperSlug    string `json:"paperSlug"`
		ReportType   string `json:"reportType"`
		Details      string `json:"details"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	if req.QuestionSlug == "" || req.ReportType == "" {
		s.respondError(w, http.StatusBadRequest, "questionSlug and reportType are required")
		return
	}
	entry := map[string]interface{}{
		"questionSlug": req.QuestionSlug,
		"questionNo":   req.QuestionNo,
		"paperSlug":    req.PaperSlug,
		"reportType":   req.ReportType,
		"details":      strings.TrimSpace(req.Details),
		"userId":       user.ID,
		"userEmail":    user.Email,
		"timestamp":    time.Now().UTC().Format(time.RFC3339),
	}
	data, _ := json.Marshal(entry)
	if err := s.rdb.RPush(r.Context(), reportListKey, string(data)).Err(); err != nil {
		log.Printf("submit report: rpush: %v", err)
		s.respondError(w, http.StatusInternalServerError, "Failed to submit report")
		return
	}
	// Cap the list so it can't grow unbounded (keep the newest 1000 reports).
	s.rdb.LTrim(r.Context(), reportListKey, -1000, -1)
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "Report submitted"})
}

func (s *Server) handleListReports(w http.ResponseWriter, r *http.Request) {
	raw, err := s.rdb.LRange(r.Context(), reportListKey, 0, -1).Result()
	if err != nil {
		s.respondError(w, http.StatusInternalServerError, "Failed to fetch reports")
		return
	}
	result := make([]json.RawMessage, 0, len(raw))
	for _, item := range raw {
		result = append(result, json.RawMessage(item))
	}
	s.respondJSON(w, http.StatusOK, map[string]interface{}{"reports": result, "count": len(result)})
}

func (s *Server) handleClearReports(w http.ResponseWriter, r *http.Request) {
	if err := s.rdb.Del(r.Context(), reportListKey).Err(); err != nil {
		log.Printf("clear reports: del: %v", err)
		s.respondError(w, http.StatusInternalServerError, "Failed to clear reports")
		return
	}
	s.audit(r, "reports.clear", "", nil)
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "Reports cleared"})
}

// ── Live attempt handlers ──────────────────────────────────────────────────────

func (s *Server) handleStartLiveAttempt(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	var req struct {
		PaperSlug       string `json:"paperSlug"`
		ExamSlug        string `json:"examSlug"`
		PaperTitle      string `json:"paperTitle"`
		ExamName        string `json:"examName"`
		TotalQuestions  int    `json:"totalQuestions"`
		DurationSeconds int    `json:"durationSeconds"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	req.PaperSlug = strings.TrimSpace(req.PaperSlug)
	req.ExamSlug = strings.TrimSpace(req.ExamSlug)
	if req.PaperSlug == "" || req.ExamSlug == "" {
		s.respondError(w, http.StatusBadRequest, "paperSlug and examSlug are required")
		return
	}
	if req.DurationSeconds <= 0 {
		req.DurationSeconds = 120 * 60
	}

	// Resume if Redis has an existing state for this user+paper
	if s.rdb != nil {
		key := liveAttemptRedisKey(user.ID, req.PaperSlug)
		raw, err := s.rdb.Get(r.Context(), key).Bytes()
		if err == nil {
			var state liveAttemptState
			if json.Unmarshal(raw, &state) == nil {
				s.rdb.Expire(r.Context(), key, liveAttemptTTL)
				s.trackLiveAttempt(r.Context(), user.ID, req.PaperSlug, state.ExpiresAt)
				state.Resumed = true
				remaining := 0
				if !state.ExpiresAt.IsZero() {
					remaining = int(time.Until(state.ExpiresAt).Seconds())
					if remaining < 0 {
						remaining = 0
					}
				}
				s.respondJSON(w, http.StatusOK, struct {
					liveAttemptState
					RemainingSeconds int `json:"remainingSeconds"`
				}{state, remaining})
				return
			}
		}
	}

	// New attempt: create DB record
	id := newAttemptID()
	if err := s.repo.RecordAttempt(r.Context(), id, user.ID, req.ExamSlug, "", req.PaperSlug); err != nil {
		s.respondRepositoryError(w, err)
		return
	}

	now := time.Now().UTC()
	state := liveAttemptState{
		AttemptID:      id,
		PaperSlug:      req.PaperSlug,
		ExamSlug:       req.ExamSlug,
		PaperTitle:     req.PaperTitle,
		ExamName:       req.ExamName,
		TotalQuestions: req.TotalQuestions,
		Answers:        map[string]string{},
		Marked:         map[string]bool{},
		CurrentIndex:   0,
		ExpiresAt:      now.Add(time.Duration(req.DurationSeconds) * time.Second),
		StartedAt:      now,
		Resumed:        false,
	}

	if s.rdb != nil {
		data, _ := json.Marshal(state)
		s.rdb.Set(r.Context(), liveAttemptRedisKey(user.ID, req.PaperSlug), data, liveAttemptTTL)
		s.trackLiveAttempt(r.Context(), user.ID, req.PaperSlug, state.ExpiresAt)
	}

	s.respondJSON(w, http.StatusOK, struct {
		liveAttemptState
		RemainingSeconds int `json:"remainingSeconds"`
	}{state, req.DurationSeconds})
}

func (s *Server) handleSyncLiveAttempt(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	var req struct {
		PaperSlug    string            `json:"paperSlug"`
		Answers      map[string]string `json:"answers"`
		Marked       map[string]bool   `json:"marked"`
		CurrentIndex int               `json:"currentIndex"`
		// RemainingSeconds is accepted for backward compat but ignored — ExpiresAt is authoritative.
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	if req.PaperSlug == "" {
		s.respondError(w, http.StatusBadRequest, "paperSlug is required")
		return
	}

	if s.rdb != nil {
		key := liveAttemptRedisKey(user.ID, req.PaperSlug)
		raw, err := s.rdb.Get(r.Context(), key).Bytes()
		if err == nil {
			var state liveAttemptState
			if json.Unmarshal(raw, &state) == nil {
				state.Answers = req.Answers
				state.Marked = req.Marked
				state.CurrentIndex = req.CurrentIndex
				if data, merr := json.Marshal(state); merr == nil {
					s.rdb.Set(r.Context(), key, data, liveAttemptTTL)
				}
			}
		}
	}

	s.respondJSON(w, http.StatusOK, map[string]bool{"ok": true})
}

func (s *Server) handleGetActiveLiveAttempts(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	attempts := make([]activeAttemptInfo, 0)
	if s.rdb == nil {
		s.respondJSON(w, http.StatusOK, attempts)
		return
	}

	ctx := r.Context()
	// O(active-attempts-for-this-user) via the per-user SET index — no keyspace SCAN.
	slugs, err := s.rdb.SMembers(ctx, liveIndexKey(user.ID)).Result()
	if err != nil {
		s.respondJSON(w, http.StatusOK, attempts)
		return
	}
	for _, slug := range slugs {
		raw, err := s.rdb.Get(ctx, liveAttemptRedisKey(user.ID, slug)).Bytes()
		if err != nil {
			// State expired/submitted but index entry lingered — prune it.
			s.rdb.SRem(ctx, liveIndexKey(user.ID), slug)
			s.rdb.ZRem(ctx, liveGlobalZKey, liveMember(user.ID, slug))
			continue
		}
		var state liveAttemptState
		if json.Unmarshal(raw, &state) != nil {
			continue
		}
		remaining := 0
		if !state.ExpiresAt.IsZero() {
			remaining = int(time.Until(state.ExpiresAt).Seconds())
			if remaining < 0 {
				remaining = 0
			}
		}
		// Skip attempts that have already expired (background worker will submit them)
		if !state.ExpiresAt.IsZero() && time.Now().After(state.ExpiresAt) {
			continue
		}
		answered := 0
		for _, v := range state.Answers {
			if v != "" {
				answered++
			}
		}
		attempts = append(attempts, activeAttemptInfo{
			PaperSlug:        state.PaperSlug,
			ExamSlug:         state.ExamSlug,
			PaperTitle:       state.PaperTitle,
			ExamName:         state.ExamName,
			TotalQuestions:   state.TotalQuestions,
			AnsweredCount:    answered,
			CurrentIndex:     state.CurrentIndex,
			RemainingSeconds: remaining,
			StartedAt:        state.StartedAt,
		})
	}

	s.respondJSON(w, http.StatusOK, attempts)
}

func (s *Server) handleSubmitLiveAttempt(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	var req struct {
		AttemptID        string            `json:"attemptId"`
		PaperSlug        string            `json:"paperSlug"`
		Correct          int               `json:"correct"`
		Wrong            int               `json:"wrong"`
		Skipped          int               `json:"skipped"`
		TimeTakenSeconds int               `json:"timeTakenSeconds"`
		Answers          map[string]string `json:"answers"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	if req.AttemptID != "" {
		if err := s.repo.UpdateAttemptResult(r.Context(), req.AttemptID, req.Correct, req.Wrong, req.Skipped, req.TimeTakenSeconds, req.Answers); err != nil {
			log.Printf("submit attempt: save result for %s: %v", req.AttemptID, err)
			s.respondError(w, http.StatusInternalServerError, "Failed to save attempt result")
			return
		}
	}

	if req.PaperSlug != "" {
		s.clearLiveAttempt(r.Context(), user.ID, req.PaperSlug)
	}

	s.respondJSON(w, http.StatusOK, map[string]bool{"ok": true})
}

// ── Live attempt expiry worker ─────────────────────────────────────────────────

// startLiveAttemptExpiry launches a background goroutine that auto-submits
// any live attempt whose ExpiresAt has passed.
func (s *Server) startLiveAttemptExpiry() {
	if s.rdb == nil {
		return
	}
	go func() {
		ticker := time.NewTicker(60 * time.Second)
		defer ticker.Stop()
		for {
			select {
			case <-ticker.C:
				s.expireOverdueLiveAttempts()
			case <-s.stopCh:
				return
			}
		}
	}()
}

func (s *Server) expireOverdueLiveAttempts() {
	ctx := context.Background()
	now := time.Now().Unix()
	// Only the overdue members, pulled by score — O(log N + overdue) instead of
	// scanning the whole keyspace every tick.
	members, err := s.rdb.ZRangeByScore(ctx, liveGlobalZKey, &redis.ZRangeBy{
		Min: "0",
		Max: strconv.FormatInt(now, 10),
	}).Result()
	if err != nil {
		return
	}
	for _, m := range members {
		userID, paperSlug, ok := splitLiveMember(m)
		if !ok {
			s.rdb.ZRem(ctx, liveGlobalZKey, m)
			continue
		}
		raw, err := s.rdb.Get(ctx, liveAttemptRedisKey(userID, paperSlug)).Bytes()
		if err != nil {
			// State already gone — drop the stale index entries.
			s.rdb.ZRem(ctx, liveGlobalZKey, m)
			s.rdb.SRem(ctx, liveIndexKey(userID), paperSlug)
			continue
		}
		var state liveAttemptState
		if json.Unmarshal(raw, &state) != nil {
			s.clearLiveAttempt(ctx, userID, paperSlug)
			continue
		}
		if !state.ExpiresAt.IsZero() && time.Now().After(state.ExpiresAt) {
			s.autoSubmitLiveAttempt(ctx, userID, paperSlug, &state)
		}
	}
}

func (s *Server) autoSubmitLiveAttempt(ctx context.Context, userID, paperSlug string, state *liveAttemptState) {
	questions, err := s.repo.ListQuestionsByPaper(ctx, state.PaperSlug)
	if err != nil || len(questions) == 0 {
		s.clearLiveAttempt(ctx, userID, paperSlug)
		return
	}
	correct, wrong, skipped := 0, 0, 0
	for _, q := range questions {
		ans := state.Answers[q.Slug]
		if ans == "" {
			skipped++
		} else if ans == q.AnswerKey {
			correct++
		} else {
			wrong++
		}
	}
	timeTaken := int(time.Since(state.StartedAt).Seconds())
	if state.AttemptID != "" {
		_ = s.repo.UpdateAttemptResult(ctx, state.AttemptID, correct, wrong, skipped, timeTaken, state.Answers)
	}
	s.clearLiveAttempt(ctx, userID, paperSlug)
}

// ── Analytics leaderboard ──────────────────────────────────────────────────

// handleScoreDistribution powers the "Score position" chart: how all platform
// users scored on an exam, bucketed by 10%, plus the system-estimated cutoff.
// Public and cached — the distribution is identical for every viewer.
func (s *Server) handleScoreDistribution(_ http.ResponseWriter, r *http.Request) (any, error) {
	examSlug := strings.TrimSpace(r.URL.Query().Get("examSlug"))
	if examSlug == "" {
		return nil, fmt.Errorf("examSlug is required")
	}
	return s.repo.GetExamScoreDistribution(r.Context(), examSlug)
}

func (s *Server) handleExamLeaderboard(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}
	examSlug := strings.TrimSpace(r.URL.Query().Get("examSlug"))
	if examSlug == "" {
		s.respondError(w, http.StatusBadRequest, "examSlug is required")
		return
	}
	// Admins can view the board as another user (for the admin analytics view).
	targetID := user.ID
	if au := strings.TrimSpace(r.URL.Query().Get("asUser")); au != "" && strings.EqualFold(user.Role, "admin") {
		targetID = au
	}

	// Top-10 is identical for every viewer → cache once per exam (60s) and share.
	top10, err := s.cachedLeaderboardTop(r.Context(), examSlug)
	if err != nil {
		s.respondError(w, http.StatusInternalServerError, "Failed to fetch leaderboard")
		return
	}
	// isMe is per-viewer; set it on the (freshly-decoded) slice — cheap, no DB.
	for i := range top10 {
		top10[i].IsMe = top10[i].UserID == targetID
	}
	userRank := s.cachedUserRank(r.Context(), examSlug, targetID)
	s.respondJSON(w, http.StatusOK, map[string]any{
		"top10":    top10,
		"userRank": userRank,
	})
}

// cachedLeaderboardTop returns the shared top-10 for an exam, cached 60s in Redis.
func (s *Server) cachedLeaderboardTop(ctx context.Context, examSlug string) ([]repository.LeaderboardEntry, error) {
	cacheKey := "cache:lb:top:" + examSlug
	if s.rdb != nil {
		if raw, err := s.rdb.Get(ctx, cacheKey).Bytes(); err == nil {
			var entries []repository.LeaderboardEntry
			if json.Unmarshal(raw, &entries) == nil {
				return entries, nil
			}
		}
	}
	entries, err := s.repo.GetExamLeaderboardTop(ctx, examSlug)
	if err != nil {
		return nil, err
	}
	if entries == nil {
		entries = []repository.LeaderboardEntry{}
	}
	if s.rdb != nil {
		if data, merr := json.Marshal(entries); merr == nil {
			_ = s.rdb.Set(ctx, cacheKey, data, time.Minute).Err()
		}
	}
	return entries, nil
}

// cachedUserRank returns the viewer's rank for an exam, cached 60s per user.
func (s *Server) cachedUserRank(ctx context.Context, examSlug, userID string) int {
	cacheKey := "cache:lb:rank:" + examSlug + ":" + userID
	if s.rdb != nil {
		if v, err := s.rdb.Get(ctx, cacheKey).Int(); err == nil {
			return v
		}
	}
	rank, err := s.repo.GetUserExamRank(ctx, examSlug, userID)
	if err != nil {
		return -1
	}
	if s.rdb != nil {
		_ = s.rdb.Set(ctx, cacheKey, rank, time.Minute).Err()
	}
	return rank
}

func (s *Server) handleAdminListUsers(w http.ResponseWriter, r *http.Request) {
	limit := 10
	offset := 0
	query := r.URL.Query().Get("q")
	if l := r.URL.Query().Get("limit"); l != "" {
		if n, err := strconv.Atoi(l); err == nil && n > 0 && n <= 50 {
			limit = n
		}
	}
	if o := r.URL.Query().Get("offset"); o != "" {
		if n, err := strconv.Atoi(o); err == nil && n >= 0 {
			offset = n
		}
	}
	users, total, err := s.repo.ListAdminUsers(r.Context(), limit, offset, query)
	if err != nil {
		s.respondError(w, http.StatusInternalServerError, "Failed to fetch users")
		return
	}
	s.respondJSON(w, http.StatusOK, map[string]any{
		"users":  users,
		"total":  total,
		"limit":  limit,
		"offset": offset,
	})
}

// handleAdminActiveCount reports users active in the last 5 minutes, based on
// the presence heartbeat every authenticated request writes. The old logic
// counted users with a non-expired timed attempt — invisible browsers and
// abandoned-but-unexpired attempts made that number wrong in both directions.
func (s *Server) handleAdminActiveCount(w http.ResponseWriter, r *http.Request) {
	count := 0
	onlineIds := []string{}
	if s.rdb != nil {
		cutoff := strconv.FormatInt(time.Now().Add(-presenceWindow).Unix(), 10)
		// Prune stale members so the ZSET stays tiny, then read the rest. The
		// IDs power the per-user online dots in the Registered Users table —
		// same data as the count, so one poll serves both.
		_ = s.rdb.ZRemRangeByScore(r.Context(), presenceZKey, "-inf", "("+cutoff).Err()
		if ids, err := s.rdb.ZRangeByScore(r.Context(), presenceZKey, &redis.ZRangeBy{Min: cutoff, Max: "+inf"}).Result(); err == nil {
			onlineIds = ids
			count = len(ids)
		}
	}
	s.respondJSON(w, http.StatusOK, map[string]any{"count": count, "onlineIds": onlineIds})
}

// ── Content visit tracking (papers & mocks) ──────────────────────────────

type visitEntry struct {
	Type string `json:"type"`
	Slug string `json:"slug"`
	At   string `json:"at"`
}

func (s *Server) handleRecordVisit(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}
	if s.rdb == nil {
		s.respondJSON(w, http.StatusOK, map[string]string{"message": "ok"})
		return
	}
	var req struct {
		Type string `json:"type"`
		Slug string `json:"slug"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	req.Slug = strings.TrimSpace(req.Slug)
	if (req.Type != "paper" && req.Type != "mock") || req.Slug == "" || len(req.Slug) > 200 {
		s.respondError(w, http.StatusBadRequest, "type must be paper|mock and slug is required")
		return
	}

	entry, _ := json.Marshal(visitEntry{Type: req.Type, Slug: req.Slug, At: time.Now().UTC().Format(time.RFC3339)})
	recentKey := visitsRecentPrefix + user.ID
	ctx := r.Context()
	pipe := s.rdb.TxPipeline()
	pipe.LPush(ctx, recentKey, entry)
	pipe.LTrim(ctx, recentKey, 0, visitsRecentMax-1)
	pipe.Expire(ctx, recentKey, visitsRecentTTL)
	topKey := visitsTopKey(time.Now())
	pipe.ZIncrBy(ctx, topKey, 1, req.Type+":"+req.Slug)
	pipe.Expire(ctx, topKey, visitsTopTTL)
	_, _ = pipe.Exec(ctx)

	s.respondJSON(w, http.StatusOK, map[string]string{"message": "ok"})
}

// resolveVisitTitles maps "type:slug" pairs to display titles via the DB.
func (s *Server) resolveVisitTitles(ctx context.Context, entries []visitEntry) map[string][2]string {
	paperSlugs := make([]string, 0, len(entries))
	mockSlugs := make([]string, 0, len(entries))
	for _, e := range entries {
		if e.Type == "paper" {
			paperSlugs = append(paperSlugs, e.Slug)
		} else {
			mockSlugs = append(mockSlugs, e.Slug)
		}
	}
	out := make(map[string][2]string)
	if len(paperSlugs) > 0 {
		if titles, err := s.repo.GetPaperTitlesBySlugs(ctx, paperSlugs); err == nil {
			for slug, t := range titles {
				out["paper:"+slug] = t
			}
		}
	}
	if len(mockSlugs) > 0 {
		if titles, err := s.repo.GetMockTitlesBySlugs(ctx, mockSlugs); err == nil {
			for slug, t := range titles {
				out["mock:"+slug] = t
			}
		}
	}
	return out
}

// recentVisitsForUser reads a user's "recently visited" log from Redis, newest
// first, de-duplicated by content, with display titles resolved from the DB.
// Shared by the user's own endpoint and the admin user-detail view so the two
// can never drift apart.
func (s *Server) recentVisitsForUser(ctx context.Context, userID string) []models.RecentVisit {
	visits := []models.RecentVisit{}
	if s.rdb == nil || userID == "" {
		return visits
	}
	raw, err := s.rdb.LRange(ctx, visitsRecentPrefix+userID, 0, visitsRecentMax-1).Result()
	if err != nil {
		return visits
	}
	entries := make([]visitEntry, 0, len(raw))
	seen := map[string]struct{}{}
	for _, item := range raw {
		var e visitEntry
		if json.Unmarshal([]byte(item), &e) != nil {
			continue
		}
		key := e.Type + ":" + e.Slug
		if _, dup := seen[key]; dup {
			continue
		}
		seen[key] = struct{}{}
		entries = append(entries, e)
	}
	titles := s.resolveVisitTitles(ctx, entries)
	for _, e := range entries {
		t := titles[e.Type+":"+e.Slug]
		if t[0] == "" {
			continue // content deleted since the visit
		}
		visits = append(visits, models.RecentVisit{Type: e.Type, Slug: e.Slug, Title: t[0], ExamName: t[1], At: e.At})
	}
	return visits
}

func (s *Server) handleRecentVisits(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}
	s.respondJSON(w, http.StatusOK, map[string]any{"visits": s.recentVisitsForUser(r.Context(), user.ID)})
}

// handleAdminActiveUsers backs the live-users panel opened from the green dot:
// who is online right now, most recently seen first, capped at 20.
func (s *Server) handleAdminActiveUsers(w http.ResponseWriter, r *http.Request) {
	users := []models.AdminActiveUser{}
	if s.rdb == nil {
		s.respondJSON(w, http.StatusOK, map[string]any{"users": users, "count": 0})
		return
	}
	ctx := r.Context()
	cutoff := strconv.FormatInt(time.Now().Add(-presenceWindow).Unix(), 10)
	_ = s.rdb.ZRemRangeByScore(ctx, presenceZKey, "-inf", "("+cutoff).Err()
	// Rev order = most recently seen first. Score is the last-seen unix stamp.
	members, err := s.rdb.ZRevRangeByScoreWithScores(ctx, presenceZKey, &redis.ZRangeBy{
		Min: cutoff, Max: "+inf", Offset: 0, Count: adminActiveUsersMax,
	}).Result()
	if err != nil {
		s.respondJSON(w, http.StatusOK, map[string]any{"users": users, "count": 0})
		return
	}
	ids := make([]string, 0, len(members))
	lastSeen := make(map[string]int64, len(members))
	for _, m := range members {
		id, _ := m.Member.(string)
		if id == "" {
			continue
		}
		ids = append(ids, id)
		lastSeen[id] = int64(m.Score)
	}
	if len(ids) == 0 {
		s.respondJSON(w, http.StatusOK, map[string]any{"users": users, "count": 0})
		return
	}
	// One batched query — not 20 round-trips.
	found, err := s.repo.GetAdminUsersByIDs(ctx, ids)
	if err != nil {
		s.respondError(w, http.StatusInternalServerError, "Failed to fetch active users")
		return
	}
	byID := make(map[string]models.AdminUser, len(found))
	for _, u := range found {
		byID[u.ID] = u
	}
	// Iterate ids (not the map) to preserve most-recently-seen ordering.
	for _, id := range ids {
		u, ok := byID[id]
		if !ok {
			continue // user deleted since their last request
		}
		users = append(users, models.AdminActiveUser{
			ID:           u.ID,
			Name:         u.Name,
			Email:        u.Email,
			City:         u.City,
			LastSeen:     time.Unix(lastSeen[id], 0).UTC().Format(time.RFC3339),
			SecondsAgo:   time.Now().Unix() - lastSeen[id],
			RecentVisits: s.recentVisitsForUser(ctx, id),
		})
	}
	s.respondJSON(w, http.StatusOK, map[string]any{"users": users, "count": len(users)})
}

func (s *Server) handleAdminTopVisited(w http.ResponseWriter, r *http.Request) {
	type topOut struct {
		Type     string `json:"type"`
		Slug     string `json:"slug"`
		Title    string `json:"title"`
		ExamName string `json:"examName"`
		Visits   int    `json:"visits"`
	}
	top := []topOut{}
	if s.rdb != nil {
		members, err := s.rdb.ZRevRangeWithScores(r.Context(), visitsTopKey(time.Now()), 0, 4).Result()
		if err == nil {
			entries := make([]visitEntry, 0, len(members))
			for _, m := range members {
				if str, ok := m.Member.(string); ok {
					if typ, slug, found := strings.Cut(str, ":"); found {
						entries = append(entries, visitEntry{Type: typ, Slug: slug})
					}
				}
			}
			titles := s.resolveVisitTitles(r.Context(), entries)
			for i, e := range entries {
				t := titles[e.Type+":"+e.Slug]
				if t[0] == "" {
					continue
				}
				top = append(top, topOut{Type: e.Type, Slug: e.Slug, Title: t[0], ExamName: t[1], Visits: int(members[i].Score)})
			}
		}
	}
	s.respondJSON(w, http.StatusOK, map[string]any{"month": time.Now().UTC().Format("2006-01"), "top": top})
}

func (s *Server) handleAdminUserDetail(w http.ResponseWriter, r *http.Request) {
	id := strings.TrimSpace(r.PathValue("id"))
	if id == "" {
		s.respondError(w, http.StatusBadRequest, "user id is required")
		return
	}
	user, err := s.repo.GetAdminUserByID(r.Context(), id)
	if err != nil {
		if errors.Is(err, repository.ErrNotFound) {
			s.respondError(w, http.StatusNotFound, "User not found")
			return
		}
		s.respondError(w, http.StatusInternalServerError, "Failed to fetch user")
		return
	}
	attempts, err := s.repo.ListUserAttemptsDetailed(r.Context(), id, 25)
	if err != nil {
		s.respondError(w, http.StatusInternalServerError, "Failed to fetch attempts")
		return
	}
	ranks, err := s.repo.GetUserExamRanks(r.Context(), id)
	if err != nil {
		s.respondError(w, http.StatusInternalServerError, "Failed to fetch rankings")
		return
	}
	s.respondJSON(w, http.StatusOK, models.AdminUserDetail{
		User:      user,
		Attempts:  attempts,
		ExamRanks: ranks,
		// Redis-backed, so this costs no extra Postgres work.
		RecentVisits: s.recentVisitsForUser(r.Context(), id),
	})
}

// computeAnalyticsSubjects rebuilds the per-subject breakdown from the attempt's
// answers (question slug → chosen key) and the paper/mock's questions.
func computeAnalyticsSubjects(questions []models.Question, answers map[string]string) []models.AdminAnalyticsSubject {
	order := make([]string, 0)
	byName := make(map[string]*models.AdminAnalyticsSubject)
	for _, q := range questions {
		subj := strings.TrimSpace(q.Subject)
		if subj == "" {
			subj = "General"
		}
		s, ok := byName[subj]
		if !ok {
			s = &models.AdminAnalyticsSubject{Subject: subj}
			byName[subj] = s
			order = append(order, subj)
		}
		s.Total++
		ans := strings.TrimSpace(answers[q.Slug])
		switch {
		case ans == "":
			s.Skipped++
		case strings.EqualFold(ans, q.AnswerKey):
			s.Correct++
		default:
			s.Wrong++
		}
	}
	out := make([]models.AdminAnalyticsSubject, 0, len(order))
	for _, name := range order {
		out = append(out, *byName[name])
	}
	return out
}

func (s *Server) handleAdminUserAnalytics(w http.ResponseWriter, r *http.Request) {
	id := strings.TrimSpace(r.PathValue("id"))
	if id == "" {
		s.respondError(w, http.StatusBadRequest, "user id is required")
		return
	}
	user, err := s.repo.GetAdminUserByID(r.Context(), id)
	if err != nil {
		if errors.Is(err, repository.ErrNotFound) {
			s.respondError(w, http.StatusNotFound, "User not found")
			return
		}
		s.respondError(w, http.StatusInternalServerError, "Failed to fetch user")
		return
	}
	rows, err := s.repo.ListUserAnalyticsRows(r.Context(), id)
	if err != nil {
		s.respondError(w, http.StatusInternalServerError, "Failed to fetch analytics")
		return
	}

	// Cache questions per paper/mock so repeated attempts don't re-query.
	qCache := make(map[string][]models.Question)
	results := make([]models.AdminAnalyticsResult, 0, len(rows))
	for _, row := range rows {
		cacheKey := row.Type + ":" + row.Slug
		questions, ok := qCache[cacheKey]
		if !ok {
			if row.Type == "paper" {
				questions, _ = s.repo.ListQuestionsByPaper(r.Context(), row.Slug)
			} else {
				questions, _ = s.repo.ListQuestionsByMock(r.Context(), row.Slug)
			}
			qCache[cacheKey] = questions
		}
		results = append(results, models.AdminAnalyticsResult{
			Type:             row.Type,
			Slug:             row.Slug,
			ExamSlug:         row.ExamSlug,
			ExamName:         row.ExamName,
			Title:            row.Title,
			TotalQuestions:   row.TotalQuestions,
			AttemptedAt:      row.CompletedAt,
			Answered:         row.Correct + row.Wrong,
			Correct:          row.Correct,
			Wrong:            row.Wrong,
			Skipped:          row.Skipped,
			MaxMarks:         row.MaxMarks,
			NegativeMarking:  row.NegativeMarking,
			TimeTakenSeconds: row.TimeTakenSeconds,
			Subjects:         computeAnalyticsSubjects(questions, row.Answers),
		})
	}

	s.respondJSON(w, http.StatusOK, models.AdminUserAnalytics{User: user, Results: results})
}

func (s *Server) handleAdminUpdateUserStatus(w http.ResponseWriter, r *http.Request) {
	id := r.PathValue("id")
	var req struct {
		IsActive bool `json:"isActive"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	if err := s.repo.UpdateUserStatus(r.Context(), id, req.IsActive); err != nil {
		s.respondError(w, http.StatusInternalServerError, "Failed to update user status")
		return
	}
	// Bust the auth cache so a deactivation takes effect on the user's next request.
	if s.rdb != nil {
		s.rdb.Del(r.Context(), userCachePrefix+id)
	}
	s.audit(r, "user.status", id, map[string]any{"isActive": req.IsActive})
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "updated"})
}

// ── Inbox ─────────────────────────────────────────────────────────────────────

const (
	inboxThreadPrefix = "inbox:thread:"
	inboxUserPrefix   = "inbox:user:"
	inboxIndexKey     = "inbox:index"
	inboxRLPrefix     = "inbox:rl:"
	inboxTTL          = 48 * time.Hour // 2 days, auto-deleted by Redis
	inboxMaxText      = 500
	inboxNewPerHour   = 3  // max new threads per user per hour
	inboxMsgPerHour   = 10 // max follow-up messages per user per hour
)

var threadIDRe = regexp.MustCompile(`^[0-9a-f]{32}$`)

func newInboxID() string {
	b := make([]byte, 16)
	if _, err := cryptorand.Read(b); err != nil {
		panic(err)
	}
	return hex.EncodeToString(b)
}

// sanitizeInbox strips control characters and enforces max length.
// No HTML is stored — plain text only — so XSS has no attack surface.
func sanitizeInbox(s string) string {
	s = strings.TrimSpace(s)
	var b strings.Builder
	for _, r := range s {
		if r == '\n' || (r >= 32 && r != 127) {
			b.WriteRune(r)
		}
	}
	out := []rune(b.String())
	if len(out) > inboxMaxText {
		out = out[:inboxMaxText]
	}
	return string(out)
}

func (s *Server) inboxLoad(ctx context.Context, id string) (*models.InboxThread, error) {
	raw, err := s.rdb.Get(ctx, inboxThreadPrefix+id).Bytes()
	if err != nil {
		return nil, err
	}
	var t models.InboxThread
	if err := json.Unmarshal(raw, &t); err != nil {
		return nil, err
	}
	return &t, nil
}

func (s *Server) inboxSave(ctx context.Context, t *models.InboxThread) error {
	data, err := json.Marshal(t)
	if err != nil {
		return err
	}
	pipe := s.rdb.Pipeline()
	pipe.Set(ctx, inboxThreadPrefix+t.ID, data, inboxTTL)
	pipe.ZAdd(ctx, inboxIndexKey, redis.Z{Score: float64(t.CreatedAt.Unix()), Member: t.ID})
	pipe.SAdd(ctx, inboxUserPrefix+t.UserID, t.ID)
	pipe.Expire(ctx, inboxUserPrefix+t.UserID, inboxTTL)
	_, err = pipe.Exec(ctx)
	return err
}

func (s *Server) handleInboxCreate(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	var req struct {
		Text       string `json:"text"`
		ExamSlug   string `json:"examSlug"`
		ExamName   string `json:"examName"`
		SearchTerm string `json:"searchTerm"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	text := sanitizeInbox(req.Text)
	if text == "" {
		s.respondError(w, http.StatusBadRequest, "Message cannot be empty")
		return
	}

	// Rate limit: 3 new threads per user per hour
	if allowed, _ := s.checkRateLimit(r.Context(), inboxRLPrefix+"new:"+user.ID, inboxNewPerHour, time.Hour); !allowed {
		s.respondError(w, http.StatusTooManyRequests, "Too many suggestions — try again later")
		return
	}

	now := time.Now().UTC()
	thread := &models.InboxThread{
		ID:         newInboxID(),
		UserID:     user.ID,
		UserName:   user.Name,
		UserEmail:  user.Email,
		ExamSlug:   sanitizeInbox(req.ExamSlug),
		ExamName:   sanitizeInbox(req.ExamName),
		SearchTerm: sanitizeInbox(req.SearchTerm),
		Messages: []models.InboxMessage{{
			ID: newInboxID(), From: "user", Text: text, CreatedAt: now,
		}},
		CreatedAt: now,
		Status:    "open",
	}

	if err := s.inboxSave(r.Context(), thread); err != nil {
		log.Printf("inbox create: %v", err)
		s.respondError(w, http.StatusInternalServerError, "Failed to send")
		return
	}
	s.respondJSON(w, http.StatusCreated, map[string]string{"threadId": thread.ID})
}

func (s *Server) handleInboxMe(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	ids, err := s.rdb.SMembers(r.Context(), inboxUserPrefix+user.ID).Result()
	if err != nil || len(ids) == 0 {
		s.respondJSON(w, http.StatusOK, []models.InboxThread{})
		return
	}

	threads := make([]models.InboxThread, 0, len(ids))
	for _, id := range ids {
		if !threadIDRe.MatchString(id) {
			continue
		}
		t, err := s.inboxLoad(r.Context(), id)
		if err != nil {
			s.rdb.SRem(r.Context(), inboxUserPrefix+user.ID, id)
			continue
		}
		if t.UserID != user.ID {
			continue // ownership check — never expose other users' threads
		}
		threads = append(threads, *t)
	}
	s.respondJSON(w, http.StatusOK, threads)
}

func (s *Server) handleInboxUserMessage(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	threadID := r.PathValue("threadId")
	if !threadIDRe.MatchString(threadID) {
		s.respondError(w, http.StatusBadRequest, "Invalid thread")
		return
	}

	t, err := s.inboxLoad(r.Context(), threadID)
	if err != nil {
		s.respondError(w, http.StatusNotFound, "Thread not found")
		return
	}
	if t.UserID != user.ID {
		s.respondError(w, http.StatusForbidden, "Forbidden")
		return
	}

	var req struct {
		Text string `json:"text"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	text := sanitizeInbox(req.Text)
	if text == "" {
		s.respondError(w, http.StatusBadRequest, "Message cannot be empty")
		return
	}

	if allowed, _ := s.checkRateLimit(r.Context(), inboxRLPrefix+"msg:"+user.ID, inboxMsgPerHour, time.Hour); !allowed {
		s.respondError(w, http.StatusTooManyRequests, "Sending too fast — please wait")
		return
	}

	t.Messages = append(t.Messages, models.InboxMessage{
		ID: newInboxID(), From: "user", Text: text, CreatedAt: time.Now().UTC(),
	})
	t.Status = "open"

	if err := s.inboxSave(r.Context(), t); err != nil {
		s.respondError(w, http.StatusInternalServerError, "Failed to send")
		return
	}
	s.respondJSON(w, http.StatusOK, map[string]bool{"ok": true})
}

func (s *Server) handleAdminInboxList(w http.ResponseWriter, r *http.Request) {
	ids, err := s.rdb.ZRevRange(r.Context(), inboxIndexKey, 0, 99).Result()
	if err != nil {
		s.respondJSON(w, http.StatusOK, []models.InboxThread{})
		return
	}

	threads := make([]models.InboxThread, 0, len(ids))
	var stale []interface{}
	for _, id := range ids {
		if !threadIDRe.MatchString(id) {
			stale = append(stale, id)
			continue
		}
		t, err := s.inboxLoad(r.Context(), id)
		if err != nil {
			stale = append(stale, id) // expired — clean index
			continue
		}
		threads = append(threads, *t)
	}
	if len(stale) > 0 {
		s.rdb.ZRem(r.Context(), inboxIndexKey, stale...)
	}
	s.respondJSON(w, http.StatusOK, threads)
}

func (s *Server) handleAdminInboxReply(w http.ResponseWriter, r *http.Request) {
	threadID := r.PathValue("threadId")
	if !threadIDRe.MatchString(threadID) {
		s.respondError(w, http.StatusBadRequest, "Invalid thread")
		return
	}

	t, err := s.inboxLoad(r.Context(), threadID)
	if err != nil {
		s.respondError(w, http.StatusNotFound, "Thread not found")
		return
	}

	var req struct {
		Text string `json:"text"`
	}
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		s.respondError(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	text := sanitizeInbox(req.Text)
	if text == "" {
		s.respondError(w, http.StatusBadRequest, "Reply cannot be empty")
		return
	}

	t.Messages = append(t.Messages, models.InboxMessage{
		ID: newInboxID(), From: "admin", Text: text, CreatedAt: time.Now().UTC(),
	})
	t.Status = "replied"

	if err := s.inboxSave(r.Context(), t); err != nil {
		s.respondError(w, http.StatusInternalServerError, "Failed to reply")
		return
	}
	s.respondJSON(w, http.StatusOK, map[string]bool{"ok": true})
}

func (s *Server) handleAdminInboxDelete(w http.ResponseWriter, r *http.Request) {
	threadID := r.PathValue("threadId")
	if !threadIDRe.MatchString(threadID) {
		s.respondError(w, http.StatusBadRequest, "Invalid thread")
		return
	}

	t, err := s.inboxLoad(r.Context(), threadID)
	if err != nil {
		s.respondError(w, http.StatusNotFound, "Thread not found")
		return
	}

	pipe := s.rdb.Pipeline()
	pipe.Del(r.Context(), inboxThreadPrefix+threadID)
	pipe.ZRem(r.Context(), inboxIndexKey, threadID)
	pipe.SRem(r.Context(), inboxUserPrefix+t.UserID, threadID)
	if _, err := pipe.Exec(r.Context()); err != nil {
		s.respondError(w, http.StatusInternalServerError, "Failed to delete")
		return
	}
	s.respondJSON(w, http.StatusOK, map[string]bool{"ok": true})
}
