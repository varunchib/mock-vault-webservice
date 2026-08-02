package models

import (
	"encoding/json"
	"time"
)

type Exam struct {
	Slug           string   `json:"slug"`
	Name           string   `json:"name"`
	ShortName      string   `json:"shortName"`
	Category       string   `json:"category"`
	Icon           string   `json:"icon"`
	TotalQuestions int      `json:"totalQuestions"`
	Papers         int      `json:"papers"`
	Mocks          int      `json:"mocks"`
	Description    string   `json:"description"`
	PopularYears   []string `json:"popularYears"`
	Subjects       []string `json:"subjects"`
	// BoardSlug is the parent board (e.g. "jkssb" for "jkssb-patwari"), empty
	// for a top-level exam. The column, its FK and its index already existed;
	// exposing it lets clients stop inferring the hierarchy from slug prefixes.
	BoardSlug string `json:"boardSlug,omitempty"`
	// ChildExamCount is how many exams name this one as their board_slug — i.e.
	// how many sub-exams sit under it. 0 = a standalone exam. Exactly 1 = a "thin"
	// board: its page aggregates a single sub-exam, so it is a near-duplicate of
	// that sub-exam's page and must stay out of the index (Worker serves it
	// noindex, sitemap skips it) until a second sub-exam is added and it becomes a
	// genuine hub. >= 2 = an indexable board hub.
	ChildExamCount int `json:"childExamCount"`
}

type QuestionOption struct {
	Key  string `json:"key"`
	Text string `json:"text"`
}

type QuestionTranslation struct {
	Passage  string   `json:"passage,omitempty"`
	Question string   `json:"question"`
	Options  []string `json:"options"`
}

type Question struct {
	Slug         string                         `json:"slug"`
	URLCode      string                         `json:"urlCode,omitempty"`
	ExamSlug     string                         `json:"examSlug"`
	PaperSlug    string                         `json:"paperSlug,omitempty"`
	ExamName     string                         `json:"examName"`
	Year         string                         `json:"year"`
	Paper        string                         `json:"paper"`
	Subject      string                         `json:"subject"`
	QuestionNo   string                         `json:"questionNo"`
	Question     string                         `json:"question"`
	Options      []QuestionOption               `json:"options"`
	AnswerKey    string                         `json:"answerKey"`
	Answer       string                         `json:"answer"`
	Explanation  string                         `json:"explanation"`
	Tags         []string                       `json:"tags"`
	Images       []string                       `json:"images,omitempty"`
	Translations map[string]QuestionTranslation `json:"translations,omitempty"`
}

type Paper struct {
	Slug            string   `json:"slug"`
	ExamSlug        string   `json:"examSlug"`
	ExamName        string   `json:"examName"`
	Title           string   `json:"title"`
	Year            string   `json:"year"`
	Shift           string   `json:"shift"`
	Description     string   `json:"description"`
	Questions       int      `json:"questions"`
	Subjects        []string `json:"subjects"`
	NegativeMarking float64  `json:"negativeMarking"`
	SourceURL       string   `json:"sourceUrl"`
	DurationMinutes int      `json:"durationMinutes"`
	MaxMarks        int      `json:"maxMarks"`
	HeldOn          *string  `json:"heldOn,omitempty"`
}

type MockItem struct {
	Slug            string   `json:"slug"`
	ExamSlug        string   `json:"examSlug"`
	ExamName        string   `json:"examName"`
	Title           string   `json:"title"`
	Description     string   `json:"description"`
	Questions       int      `json:"questions"`
	DurationMinutes int      `json:"durationMinutes"`
	Difficulty      string   `json:"difficulty"`
	IsFree          bool     `json:"isFree"`
	Subjects        []string `json:"subjects"`
	NegativeMarking float64  `json:"negativeMarking"`
}

// ExamCutoffSet groups all cutoff rows for one (exam, stage, year) combination.
type ExamCutoffSet struct {
	Stage      string                `json:"stage"`
	Year       string                `json:"year"`
	TotalMarks float64               `json:"totalMarks"`
	AvgScore   float64               `json:"avgScore"`
	StdDev     float64               `json:"stdDev"`
	Cutoffs    []CutoffCategoryEntry `json:"cutoffs"`
}

type CutoffCategoryEntry struct {
	Category string  `json:"category"`
	Marks    float64 `json:"marks"`
	Source   string  `json:"source"`
}

type AdminMockQuestionInput struct {
	Question    string           `json:"question"`
	Options     []QuestionOption `json:"options"`
	AnswerKey   string           `json:"answerKey"`
	Explanation string           `json:"explanation"`
	Subject     string           `json:"subject"`
}

type AdminCreateExamRequest struct {
	Slug        string   `json:"slug"`
	Name        string   `json:"name"`
	ShortName   string   `json:"shortName"`
	Category    string   `json:"category"`
	Icon        string   `json:"icon"`
	Description string   `json:"description"`
	Subjects    []string `json:"subjects"`
}

type AdminCreateMockRequest struct {
	Slug            string                   `json:"slug"`
	ExamSlug        string                   `json:"examSlug"`
	Title           string                   `json:"title"`
	Description     string                   `json:"description"`
	DurationMinutes int                      `json:"durationMinutes"`
	Difficulty      string                   `json:"difficulty"`
	IsFree          bool                     `json:"isFree"`
	NegativeMarking float64                  `json:"negativeMarking"`
	Subjects        []string                 `json:"subjects"`
	Questions       []AdminMockQuestionInput `json:"questions"`
}

type AdminPaperQuestionInput struct {
	QuestionNo  string           `json:"questionNo"`
	Question    string           `json:"question"`
	Options     []QuestionOption `json:"options"`
	AnswerKey   string           `json:"answerKey"`
	Explanation string           `json:"explanation"`
	Subject     string           `json:"subject"`
	Tags        []string         `json:"tags"`
}

type AdminUpdateQuestionRequest struct {
	Question    string           `json:"question"`
	Options     []QuestionOption `json:"options"`
	AnswerKey   string           `json:"answerKey"`
	Explanation string           `json:"explanation"`
	Subject     string           `json:"subject"`
	Tags        []string         `json:"tags"`
}

type AdminCreatePaperRequest struct {
	Slug            string                    `json:"slug"`
	ExamSlug        string                    `json:"examSlug"`
	Title           string                    `json:"title"`
	Year            string                    `json:"year"`
	Shift           string                    `json:"shift"`
	Description     string                    `json:"description"`
	NegativeMarking float64                   `json:"negativeMarking"`
	Subjects        []string                  `json:"subjects"`
	Questions       []AdminPaperQuestionInput `json:"questions"`
}

type User struct {
	ID        string    `json:"id"`
	Email     string    `json:"email"`
	Name      string    `json:"name"`
	AvatarURL string    `json:"avatarUrl,omitempty"`
	Role      string    `json:"role"`
	LastLogin time.Time `json:"lastLogin"`
}

type AdminUser struct {
	ID        string    `json:"id"`
	Email     string    `json:"email"`
	Name      string    `json:"name"`
	Role      string    `json:"role"`
	IsActive  bool      `json:"isActive"`
	CreatedAt time.Time `json:"createdAt"`
	LastLogin time.Time `json:"lastLogin"`
	City      string    `json:"city,omitempty"`
}

type AuditEntry struct {
	ID         int64           `json:"id"`
	ActorID    string          `json:"actorId"`
	ActorEmail string          `json:"actorEmail"`
	Action     string          `json:"action"`
	Target     string          `json:"target"`
	Details    json.RawMessage `json:"details"`
	IPAddress  string          `json:"ipAddress"`
	CreatedAt  time.Time       `json:"createdAt"`
}

// AdminUserAttempt is one scored attempt shown in the admin user-detail view.
type AdminUserAttempt struct {
	Type             string    `json:"type"` // "paper" | "mock"
	Slug             string    `json:"slug"`
	ExamSlug         string    `json:"examSlug"`
	ExamName         string    `json:"examName"`
	Title            string    `json:"title"`
	Correct          int       `json:"correct"`
	Total            int       `json:"total"`
	ScorePct         int       `json:"scorePct"`
	TimeTakenSeconds int       `json:"timeTakenSeconds"`
	CompletedAt      time.Time `json:"completedAt"`
}

// AdminUserExamRank is the user's leaderboard standing for one exam.
type AdminUserExamRank struct {
	ExamSlug    string `json:"examSlug"`
	ExamName    string `json:"examName"`
	ScorePct    int    `json:"scorePct"`
	Rank        int    `json:"rank"`
	TotalRanked int    `json:"totalRanked"`
}

// AdminUserDetail is the full profile an admin sees when opening a user.
// RecentVisit is one entry of a user's "recently visited" log (Redis-backed,
// newest first). Shown to the user on their dashboard and to admins on the
// user-detail view.
type RecentVisit struct {
	Type     string `json:"type"` // "paper" | "mock"
	Slug     string `json:"slug"`
	Title    string `json:"title"`
	ExamName string `json:"examName"`
	At       string `json:"at"`
}

// AdminActiveUser is one row of the live-users panel (opened from the green
// presence dot): who is online now and what they were just looking at.
type AdminActiveUser struct {
	ID           string        `json:"id"`
	Name         string        `json:"name"`
	Email        string        `json:"email"`
	City         string        `json:"city,omitempty"`
	LastSeen     string        `json:"lastSeen"`
	SecondsAgo   int64         `json:"secondsAgo"`
	RecentVisits []RecentVisit `json:"recentVisits"`
}

type AdminUserDetail struct {
	User         AdminUser           `json:"user"`
	Attempts     []AdminUserAttempt  `json:"attempts"`
	ExamRanks    []AdminUserExamRank `json:"examRanks"`
	RecentVisits []RecentVisit       `json:"recentVisits"`
}

// AdminAnalyticsSubject mirrors the frontend SubjectResult shape.
type AdminAnalyticsSubject struct {
	Subject string `json:"subject"`
	Total   int    `json:"total"`
	Correct int    `json:"correct"`
	Wrong   int    `json:"wrong"`
	Skipped int    `json:"skipped"`
}

// AdminAnalyticsResult mirrors the frontend CombinedResult shape so the admin
// analytics view can reuse the exact same UI the user sees.
type AdminAnalyticsResult struct {
	Type             string                  `json:"type"`
	Slug             string                  `json:"slug"`
	ExamSlug         string                  `json:"examSlug"`
	ExamName         string                  `json:"examName"`
	Title            string                  `json:"title"`
	TotalQuestions   int                     `json:"totalQuestions"`
	AttemptedAt      time.Time               `json:"attemptedAt"`
	Answered         int                     `json:"answered"`
	Correct          int                     `json:"correct"`
	Wrong            int                     `json:"wrong"`
	Skipped          int                     `json:"skipped"`
	MaxMarks         int                     `json:"maxMarks,omitempty"`
	NegativeMarking  float64                 `json:"negativeMarking,omitempty"`
	TimeTakenSeconds int                     `json:"timeTakenSeconds"`
	Subjects         []AdminAnalyticsSubject `json:"subjects"`
}

type AdminUserAnalytics struct {
	User    AdminUser              `json:"user"`
	Results []AdminAnalyticsResult `json:"results"`
}

type Session struct {
	ID               string
	UserID           string
	RefreshTokenHash string
	UserAgent        string
	IPAddress        string
	ExpiresAt        time.Time
	LastSeenAt       time.Time
	RevokedAt        *time.Time
}

type InboxMessage struct {
	ID        string    `json:"id"`
	From      string    `json:"from"` // "user" or "admin"
	Text      string    `json:"text"`
	CreatedAt time.Time `json:"createdAt"`
}

type InboxThread struct {
	ID         string         `json:"id"`
	UserID     string         `json:"userId"`
	UserName   string         `json:"userName"`
	UserEmail  string         `json:"userEmail"`
	ExamSlug   string         `json:"examSlug,omitempty"`
	ExamName   string         `json:"examName,omitempty"`
	SearchTerm string         `json:"searchTerm,omitempty"`
	Messages   []InboxMessage `json:"messages"`
	CreatedAt  time.Time      `json:"createdAt"`
	Status     string         `json:"status"` // "open" | "replied"
}

type RecentAttempt struct {
	Type        string    `json:"type"`
	Slug        string    `json:"slug"`
	ExamSlug    string    `json:"examSlug"`
	ExamName    string    `json:"examName"`
	Title       string    `json:"title"`
	Questions   int       `json:"questions"`
	AttemptedAt time.Time `json:"attemptedAt"`
}

type Dashboard struct {
	User           User            `json:"user"`
	Exams          []Exam          `json:"exams"`
	Mocks          []MockItem      `json:"mocks"`
	EnrolledExams  []Exam          `json:"enrolledExams"`
	RecentAttempts []RecentAttempt `json:"recentAttempts"`
	// Papers added to each enrolled exam after the user enrolled, keyed by
	// exam slug — powers the "N new" badge in the dashboard Enrolled section.
	NewPapersByExam map[string]int `json:"newPapersByExam"`
}
