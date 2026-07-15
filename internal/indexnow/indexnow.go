// Package indexnow submits changed URLs to the IndexNow API, which instantly
// notifies Bing, Yandex, Seznam and Naver instead of waiting for a crawl.
// https://www.indexnow.org/documentation
package indexnow

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"time"
)

const (
	endpoint  = "https://api.indexnow.org/indexnow"
	maxURLs   = 10000 // per IndexNow spec
	httpLimit = 10 * time.Second
)

// Client submits URLs to IndexNow. A nil *Client is a no-op, so callers can
// treat IndexNow as optional without nil checks at every call site.
type Client struct {
	key         string
	host        string
	keyLocation string
	http        *http.Client
}

// New returns nil when the key or host is unset (feature disabled).
func New(key, host string) *Client {
	if key == "" || host == "" {
		return nil
	}
	return &Client{
		key:         key,
		host:        host,
		keyLocation: fmt.Sprintf("https://%s/%s.txt", host, key),
		http:        &http.Client{Timeout: httpLimit},
	}
}

type payload struct {
	Host        string   `json:"host"`
	Key         string   `json:"key"`
	KeyLocation string   `json:"keyLocation"`
	URLList     []string `json:"urlList"`
}

// Submit notifies IndexNow that the given absolute URLs have changed.
func (c *Client) Submit(ctx context.Context, urls []string) error {
	if c == nil || len(urls) == 0 {
		return nil
	}
	if len(urls) > maxURLs {
		urls = urls[:maxURLs]
	}

	body, err := json.Marshal(payload{
		Host:        c.host,
		Key:         c.key,
		KeyLocation: c.keyLocation,
		URLList:     urls,
	})
	if err != nil {
		return fmt.Errorf("indexnow marshal: %w", err)
	}

	req, err := http.NewRequestWithContext(ctx, http.MethodPost, endpoint, bytes.NewReader(body))
	if err != nil {
		return fmt.Errorf("indexnow request: %w", err)
	}
	req.Header.Set("Content-Type", "application/json; charset=utf-8")

	resp, err := c.http.Do(req)
	if err != nil {
		return fmt.Errorf("indexnow post: %w", err)
	}
	defer resp.Body.Close()

	// 200 OK and 202 Accepted both mean the submission was received.
	if resp.StatusCode != http.StatusOK && resp.StatusCode != http.StatusAccepted {
		return fmt.Errorf("indexnow: unexpected status %d", resp.StatusCode)
	}
	return nil
}
