package httpapi

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"mock-vault-webservice/internal/models"
)

func q(slug, answerKey string) models.Question {
	return models.Question{Slug: slug, AnswerKey: answerKey, Subject: "General"}
}

// The scores stored server-side must match what the candidate saw on screen,
// which is computeResults() in src/pages/PaperAttemptPage.tsx. If that function
// changes, this test is the thing that should fail.
func TestScoreAttempt(t *testing.T) {
	questions := []models.Question{q("q1", "A"), q("q2", "B"), q("q3", "C"), q("q4", "D")}

	tests := []struct {
		name                    string
		answers                 map[string]string
		correct, wrong, skipped int
	}{
		{
			name:    "all correct",
			answers: map[string]string{"q1": "A", "q2": "B", "q3": "C", "q4": "D"},
			correct: 4,
		},
		{
			name:    "mixed sheet",
			answers: map[string]string{"q1": "A", "q2": "C", "q3": ""},
			correct: 1, wrong: 1, skipped: 2,
		},
		{
			name:    "empty sheet is all skipped",
			answers: map[string]string{},
			skipped: 4,
		},
		{
			name:    "nil sheet is all skipped",
			answers: nil,
			skipped: 4,
		},
		{
			// Answers for questions outside this paper must not inflate anything —
			// only the paper's own question list drives the counts.
			name:    "stray answers are ignored",
			answers: map[string]string{"q1": "A", "not-in-paper": "A", "another": "B"},
			correct: 1, skipped: 3,
		},
		{
			// The option key is compared exactly, as the UI does.
			name:    "wrong case is not a match",
			answers: map[string]string{"q1": "a"},
			wrong:   1, skipped: 3,
		},
	}

	for _, tc := range tests {
		t.Run(tc.name, func(t *testing.T) {
			correct, wrong, skipped := scoreAttempt(questions, tc.answers)
			if correct != tc.correct || wrong != tc.wrong || skipped != tc.skipped {
				t.Errorf("got correct=%d wrong=%d skipped=%d, want correct=%d wrong=%d skipped=%d",
					correct, wrong, skipped, tc.correct, tc.wrong, tc.skipped)
			}
			if total := correct + wrong + skipped; total != 4 {
				t.Errorf("counts must cover every scorable question: got total %d, want 4", total)
			}
		})
	}
}

// Questions the board dropped after the paper was held carry answer key
// "Deleted" and are excluded from every count — matching the UI, which skips
// them too. A candidate must not be marked wrong on a cancelled question.
func TestScoreAttemptExcludesDeletedQuestions(t *testing.T) {
	questions := []models.Question{
		q("q1", "A"),
		q("q2", "Deleted"),
		q("q3", "C"),
	}
	answers := map[string]string{"q1": "A", "q2": "B", "q3": "B"}

	correct, wrong, skipped := scoreAttempt(questions, answers)
	if correct != 1 || wrong != 1 || skipped != 0 {
		t.Fatalf("got correct=%d wrong=%d skipped=%d, want correct=1 wrong=1 skipped=0", correct, wrong, skipped)
	}
	if total := correct + wrong + skipped; total != 2 {
		t.Errorf("deleted question must not be counted: got total %d, want 2", total)
	}
}

func TestClampTimeTaken(t *testing.T) {
	tests := []struct{ in, want int }{
		{in: -1, want: 0},
		{in: 0, want: 0},
		{in: 7200, want: 7200},
		{in: maxAttemptSeconds + 1, want: maxAttemptSeconds},
		{in: 999999999, want: maxAttemptSeconds},
	}
	for _, tc := range tests {
		if got := clampTimeTaken(tc.in); got != tc.want {
			t.Errorf("clampTimeTaken(%d) = %d, want %d", tc.in, got, tc.want)
		}
	}
}

// trustedIP must never return an address the caller chose. nginx overwrites
// X-Real-IP with $remote_addr and appends $remote_addr to X-Forwarded-For, so
// injected entries always sit in front of the address our own edge observed.
func TestTrustedIPIgnoresSpoofedForwardedFor(t *testing.T) {
	tests := []struct {
		name       string
		headers    map[string]string
		remoteAddr string
		want       string
	}{
		{
			name: "X-Real-IP wins over a forged forwarded chain",
			headers: map[string]string{
				"X-Forwarded-For": "1.2.3.4",
				"X-Real-Ip":       "203.0.113.9",
			},
			want: "203.0.113.9",
		},
		{
			name:    "falls back to the last forwarded entry, which nginx appended",
			headers: map[string]string{"X-Forwarded-For": "1.2.3.4, 203.0.113.9"},
			want:    "203.0.113.9",
		},
		{
			name:    "a long injected chain still resolves to the observed hop",
			headers: map[string]string{"X-Forwarded-For": "9.9.9.9, 8.8.8.8, 7.7.7.7, 203.0.113.9"},
			want:    "203.0.113.9",
		},
		{
			name:    "a single entry is nginx's own",
			headers: map[string]string{"X-Forwarded-For": "203.0.113.9"},
			want:    "203.0.113.9",
		},
		{
			name:       "no forwarding headers falls back to the peer address",
			headers:    map[string]string{},
			remoteAddr: "203.0.113.9:54321",
			want:       "203.0.113.9",
		},
	}

	for _, tc := range tests {
		t.Run(tc.name, func(t *testing.T) {
			r := httptest.NewRequest(http.MethodPost, "/api/v1/auth/google", nil)
			for k, v := range tc.headers {
				r.Header.Set(k, v)
			}
			if tc.remoteAddr != "" {
				r.RemoteAddr = tc.remoteAddr
			}
			if got := trustedIP(r); got != tc.want {
				t.Errorf("trustedIP() = %q, want %q", got, tc.want)
			}
		})
	}
}

// realIP keeps reading the leftmost entry on purpose: the SSR Worker forwards
// the visitor's address there so crawler traffic buckets per visitor rather
// than collapsing onto one origin IP. This documents that the two functions
// disagree by design on a spoofed request.
func TestRealIPAndTrustedIPDivergeOnSpoof(t *testing.T) {
	r := httptest.NewRequest(http.MethodGet, "/api/v1/exams", nil)
	r.Header.Set("X-Forwarded-For", "1.2.3.4, 203.0.113.9")
	r.Header.Set("X-Real-Ip", "203.0.113.9")

	if got := realIP(r); got != "1.2.3.4" {
		t.Errorf("realIP() = %q, want the forwarded visitor address %q", got, "1.2.3.4")
	}
	if got := trustedIP(r); got != "203.0.113.9" {
		t.Errorf("trustedIP() = %q, want the observed address %q", got, "203.0.113.9")
	}
}
