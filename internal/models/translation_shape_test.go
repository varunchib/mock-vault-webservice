package models

import (
	"encoding/json"
	"testing"
)

// Translated options are texts only; the client supplies the keys positionally.
func TestQuestionTranslationDecodesToOptionTexts(t *testing.T) {
	cases := map[string]string{
		"bare strings": `{"question":"प्रश्न","options":["26","24","28","22"]}`,
		"key/text":     `{"question":"प्रश्न","options":[{"key":"A","text":"26"},{"key":"B","text":"24"},{"key":"C","text":"28"},{"key":"D","text":"22"}]}`,
	}
	want := []string{"26", "24", "28", "22"}
	for name, raw := range cases {
		var got QuestionTranslation
		if err := json.Unmarshal([]byte(raw), &got); err != nil {
			t.Fatalf("%s: unexpected error: %v", name, err)
		}
		if len(got.Options) != len(want) {
			t.Fatalf("%s: got %d options, want %d", name, len(got.Options), len(want))
		}
		for i := range want {
			if got.Options[i] != want[i] {
				t.Errorf("%s: option %d = %q, want %q", name, i, got.Options[i], want[i])
			}
		}
	}
}

func TestQuestionTranslationEmptyAndAbsentOptions(t *testing.T) {
	for _, raw := range []string{`{"question":"q"}`, `{"question":"q","options":null}`, `{"question":"q","options":[]}`} {
		var got QuestionTranslation
		if err := json.Unmarshal([]byte(raw), &got); err != nil {
			t.Fatalf("%s: unexpected error: %v", raw, err)
		}
		if len(got.Options) != 0 {
			t.Errorf("%s: got %d options, want 0", raw, len(got.Options))
		}
	}
}

func TestQuestionTranslationKeepsPassage(t *testing.T) {
	var got QuestionTranslation
	if err := json.Unmarshal([]byte(`{"passage":"p","question":"q","options":["x"]}`), &got); err != nil {
		t.Fatal(err)
	}
	if got.Passage != "p" {
		t.Errorf("passage = %q, want %q", got.Passage, "p")
	}
}
