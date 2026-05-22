package httpapi

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"math/rand"
	"net"
	"net/http"
	"strconv"
	"strings"
	"time"


	"github.com/redis/go-redis/v9"
	"golang.org/x/sync/singleflight"

	"mock-vault-webservice/internal/auth"
	"mock-vault-webservice/internal/config"
	"mock-vault-webservice/internal/models"
	"mock-vault-webservice/internal/repository"
)

const (
	accessCookieName  = "pyqv_access"
	refreshCookieName = "pyqv_refresh"
)

type ctxKey string

const authUserKey ctxKey = "auth_user"

type Server struct {
	cfg  config.Config
	repo *repository.PostgresRepository
	auth *auth.Service
	rdb  *redis.Client
	mux  *http.ServeMux
	sfg  singleflight.Group // cache stampede protection
}

// discardWriter absorbs writes inside singleflight closures (data-only handlers)
type discardWriter struct{ h http.Header }

func newDiscardWriter() *discardWriter    { return &discardWriter{h: make(http.Header)} }
func (d *discardWriter) Header() http.Header         { return d.h }
func (d *discardWriter) Write(b []byte) (int, error) { return len(b), nil }
func (d *discardWriter) WriteHeader(int)              {}

type errorResponse struct {
	Message string `json:"message"`
}

type authResponse struct {
	User models.User `json:"user"`
}

func NewServer(cfg config.Config, repo *repository.PostgresRepository, authService *auth.Service, rdb *redis.Client) *Server {
	server := &Server{
		cfg:  cfg,
		repo: repo,
		auth: authService,
		rdb:  rdb,
		mux:  http.NewServeMux(),
	}
	server.registerRoutes()
	return server
}

func (s *Server) Handler() http.Handler {
	// Global: 300 req/min per IP — protects DB and Redis from traffic spikes
	return s.securityHeaders(s.cors(s.withRateLimit("global", 300, time.Minute, s.mux)))
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
	s.mux.HandleFunc("GET /api/v1/health", s.handleHealth)

	// Auth endpoints: strict 15 req/min per IP — brute force protection
	s.mux.Handle("POST /api/v1/auth/google", s.withRateLimit("auth", 15, time.Minute, http.HandlerFunc(s.handleGoogleLogin)))
	s.mux.Handle("POST /api/v1/auth/refresh", s.withRateLimit("auth", 15, time.Minute, http.HandlerFunc(s.handleRefresh)))
	s.mux.Handle("GET /api/v1/auth/me", s.withAuth(http.HandlerFunc(s.handleMe), false))
	s.mux.Handle("POST /api/v1/auth/logout", s.withAuth(http.HandlerFunc(s.handleLogout), false))

	// Public catalog endpoints — per-IP rate limits to block scrapers/bots.
	// Global 300/min still applies on top of these.
	s.mux.Handle("GET /api/v1/exams", s.withRateLimit("catalog", 60, time.Minute,
		s.cachedPublic("catalog:exams", time.Hour, s.handleListExams)))
	s.mux.Handle("GET /api/v1/exams/{slug}", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(time.Hour, func(r *http.Request) string {
			return "exam:" + r.PathValue("slug")
		}, s.handleGetExam)))
	s.mux.Handle("GET /api/v1/exams/{slug}/papers", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(time.Hour, func(r *http.Request) string {
			return "papers:exam:" + r.PathValue("slug")
		}, s.handleListExamPapers)))
	s.mux.Handle("GET /api/v1/exams/{slug}/questions", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(30*time.Minute, func(r *http.Request) string {
			return "questions:exam:" + r.PathValue("slug")
		}, s.handleListExamQuestions)))
	s.mux.Handle("GET /api/v1/questions/{slug}", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(30*time.Minute, func(r *http.Request) string {
			return "question:" + r.PathValue("slug")
		}, s.handleGetQuestion)))
	s.mux.Handle("GET /api/v1/papers", s.withRateLimit("catalog", 60, time.Minute,
		s.cachedPublic("papers:all", time.Hour, s.handleListPapers)))
	s.mux.Handle("GET /api/v1/papers/{slug}", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(time.Hour, func(r *http.Request) string {
			return "paper:" + r.PathValue("slug")
		}, s.handleGetPaper)))
	s.mux.Handle("GET /api/v1/papers/{slug}/questions", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(30*time.Minute, func(r *http.Request) string {
			return "paper:questions:" + r.PathValue("slug")
		}, s.handleListPaperQuestions)))
	s.mux.Handle("GET /api/v1/mocks", s.withRateLimit("catalog", 60, time.Minute,
		s.cachedPublic("mocks:all", 30*time.Minute, s.handleListMocks)))
	s.mux.Handle("GET /api/v1/mocks/{slug}", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(30*time.Minute, func(r *http.Request) string {
			return "mock:" + r.PathValue("slug")
		}, s.handleGetMock)))
	s.mux.Handle("GET /api/v1/mocks/{slug}/questions", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(30*time.Minute, func(r *http.Request) string {
			return "mock:questions:" + r.PathValue("slug")
		}, s.handleListMockQuestions)))
	s.mux.Handle("GET /api/v1/exams/{slug}/cutoffs", s.withRateLimit("pub", 120, time.Minute,
		s.cachedPublicKey(24*time.Hour, func(r *http.Request) string {
			return "cutoffs:exam:" + r.PathValue("slug")
		}, s.handleGetExamCutoffs)))

	s.mux.Handle("GET /api/v1/dashboard", s.withAuth(http.HandlerFunc(s.handleDashboard), false))
	s.mux.Handle("POST /api/v1/activity/enroll", s.withAuth(http.HandlerFunc(s.handleEnroll), false))
	s.mux.Handle("DELETE /api/v1/activity/enroll", s.withAuth(http.HandlerFunc(s.handleUnenroll), false))
	s.mux.Handle("GET /api/v1/user/enrolled-slugs", s.withAuth(http.HandlerFunc(s.handleEnrolledSlugs), false))
	s.mux.Handle("POST /api/v1/activity/attempt", s.withAuth(http.HandlerFunc(s.handleRecordAttempt), false))
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

	// Reports
	s.mux.Handle("POST /api/v1/reports", s.withAuth(http.HandlerFunc(s.handleSubmitReport), false))
	s.mux.Handle("GET /api/v1/admin/reports", s.withAuth(http.HandlerFunc(s.handleListReports), true))
	s.mux.Handle("DELETE /api/v1/admin/reports", s.withAuth(http.HandlerFunc(s.handleClearReports), true))
}

func (s *Server) handleRoot(w http.ResponseWriter, r *http.Request) {
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "mock-vault-webservice is running"})
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
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "cutoff saved"})
}

func (s *Server) handleDashboard(w http.ResponseWriter, r *http.Request) {
	user, ok := userFromContext(r.Context())
	if !ok {
		s.respondError(w, http.StatusUnauthorized, "Unauthorized")
		return
	}

	exams, err := s.repo.ListExams(r.Context())
	if err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	mocks, err := s.repo.ListMocks(r.Context())
	if err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	enrolledExams, err := s.repo.ListUserEnrollments(r.Context(), user.ID)
	if err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	recentAttempts, err := s.repo.ListUserRecentAttempts(r.Context(), user.ID, 8)
	if err != nil {
		s.respondRepositoryError(w, err)
		return
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

	s.respondJSON(w, http.StatusOK, models.Dashboard{
		User:           user,
		Exams:          exams,
		Mocks:          mocks,
		EnrolledExams:  enrolledExams,
		RecentAttempts: recentAttempts,
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

	id := fmt.Sprintf("%d-%d", time.Now().UnixNano(), rand.Int63())
	if err := s.repo.RecordAttempt(r.Context(), id, user.ID, req.ExamSlug, req.MockSlug, req.PaperSlug); err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "recorded"})
}

func (s *Server) handleAdminSummary(w http.ResponseWriter, r *http.Request) {
	exams, err := s.repo.ListExams(r.Context())
	if err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	papers, err := s.repo.ListPapers(r.Context())
	if err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	mocks, err := s.repo.ListMocks(r.Context())
	if err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	questions, err := s.repo.ListQuestions(r.Context())
	if err != nil {
		s.respondRepositoryError(w, err)
		return
	}
	userCount, err := s.repo.CountUsers(r.Context())
	if err != nil {
		s.respondRepositoryError(w, err)
		return
	}

	s.respondJSON(w, http.StatusOK, map[string]any{
		"exams":         exams,
		"paperCount":    len(papers),
		"mockCount":     len(mocks),
		"questionCount": len(questions),
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
	if len(cleanOptions(req.Options)) < 2 {
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
		Options:     cleanOptions(req.Options),
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
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "Paper deleted"})
}

func (s *Server) handleFlushCache(w http.ResponseWriter, r *http.Request) {
	s.invalidatePublicCache(r.Context())
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "Cache cleared"})
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

		user, err := s.repo.GetUserByID(r.Context(), claims.Subject)
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
			// Use a background context so one cancelled request doesn't abort
			// in-flight work that other goroutines are waiting on.
			payload, herr := handler(newDiscardWriter(), r.WithContext(context.Background()))
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
				if r.Method == http.MethodOptions {
					w.WriteHeader(http.StatusForbidden)
					return
				}
				next.ServeHTTP(w, r)
				return
			}

			w.Header().Set("Access-Control-Allow-Origin", origin)
			w.Header().Set("Access-Control-Allow-Credentials", "true")
			w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")
			w.Header().Set("Access-Control-Allow-Methods", "GET, POST, DELETE, OPTIONS")
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
	return auth.SessionMetadata{
		UserAgent: strings.TrimSpace(r.UserAgent()),
		IPAddress: requestIP(r),
	}
}

func requestIP(r *http.Request) string {
	host, _, err := net.SplitHostPort(r.RemoteAddr)
	if err != nil {
		return r.RemoteAddr
	}
	return host
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
	s.rdb.RPush(r.Context(), reportListKey, string(data))
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
	s.rdb.Del(r.Context(), reportListKey)
	s.respondJSON(w, http.StatusOK, map[string]string{"message": "Reports cleared"})
}
