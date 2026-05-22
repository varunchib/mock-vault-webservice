package models

import "time"

type Exam struct {
	Slug           string   `json:"slug"`
	Name           string   `json:"name"`
	ShortName      string   `json:"shortName"`
	Category       string   `json:"category"`
	Icon           string   `json:"icon"`
	TotalQuestions string   `json:"totalQuestions"`
	Papers         string   `json:"papers"`
	Mocks          string   `json:"mocks"`
	Description    string   `json:"description"`
	PopularYears   []string `json:"popularYears"`
	Subjects       []string `json:"subjects"`
}

type QuestionOption struct {
	Key  string `json:"key"`
	Text string `json:"text"`
}

type Question struct {
	Slug        string           `json:"slug"`
	ExamSlug    string           `json:"examSlug"`
	PaperSlug   string           `json:"paperSlug,omitempty"`
	ExamName    string           `json:"examName"`
	Year        string           `json:"year"`
	Paper       string           `json:"paper"`
	Subject     string           `json:"subject"`
	QuestionNo  string           `json:"questionNo"`
	Question    string           `json:"question"`
	Options     []QuestionOption `json:"options"`
	AnswerKey   string           `json:"answerKey"`
	Answer      string           `json:"answer"`
	Explanation string           `json:"explanation"`
	Tags        []string         `json:"tags"`
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
}
