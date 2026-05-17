package config

import (
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"

	"github.com/joho/godotenv"
)

type Config struct {
	HTTPAddr         string
	DatabaseURL      string
	RedisAddr        string
	JWTSecret        string
	GoogleClientID   string
	AllowedOrigins   []string
	AccessTokenTTL   time.Duration
	RefreshTokenTTL  time.Duration
	RedisDialTimeout time.Duration
	CookieDomain     string
	CookieSecure     bool
	CookieSameSite   string
}

func Load() (Config, error) {
	_ = godotenv.Load()

	cfg := Config{
		HTTPAddr:         envOrDefault("HTTP_ADDR", ":8080"),
		DatabaseURL:      strings.TrimSpace(os.Getenv("DATABASE_URL")),
		RedisAddr:        strings.TrimSpace(os.Getenv("REDIS_ADDR")),
		JWTSecret:        strings.TrimSpace(os.Getenv("JWT_SECRET")),
		GoogleClientID:   strings.TrimSpace(os.Getenv("GOOGLE_CLIENT_ID")),
		AllowedOrigins:   splitCSV(envOrDefault("ALLOWED_ORIGINS", "http://localhost:5173,http://localhost:3000")),
		AccessTokenTTL:   durationOrDefault("ACCESS_TOKEN_TTL", 15*time.Minute),
		RefreshTokenTTL:  durationOrDefault("REFRESH_TOKEN_TTL", 30*24*time.Hour),
		RedisDialTimeout: durationOrDefault("REDIS_DIAL_TIMEOUT", 3*time.Second),
		CookieDomain:     strings.TrimSpace(os.Getenv("COOKIE_DOMAIN")),
		CookieSecure:     boolOrDefault("COOKIE_SECURE", false),
		CookieSameSite:   strings.ToLower(envOrDefault("COOKIE_SAME_SITE", "lax")),
	}

	switch {
	case cfg.DatabaseURL == "":
		return Config{}, fmt.Errorf("DATABASE_URL is required")
	case cfg.JWTSecret == "":
		return Config{}, fmt.Errorf("JWT_SECRET is required")
	case len(cfg.JWTSecret) < 32:
		return Config{}, fmt.Errorf("JWT_SECRET must be at least 32 characters")
	case cfg.GoogleClientID == "":
		return Config{}, fmt.Errorf("GOOGLE_CLIENT_ID is required")
	}

	return cfg, nil
}

func envOrDefault(key, fallback string) string {
	value := strings.TrimSpace(os.Getenv(key))
	if value == "" {
		return fallback
	}
	return value
}

func splitCSV(value string) []string {
	rawParts := strings.Split(value, ",")
	parts := make([]string, 0, len(rawParts))
	for _, part := range rawParts {
		part = strings.TrimSpace(part)
		if part != "" {
			parts = append(parts, part)
		}
	}
	return parts
}

func durationOrDefault(key string, fallback time.Duration) time.Duration {
	value := strings.TrimSpace(os.Getenv(key))
	if value == "" {
		return fallback
	}
	parsed, err := time.ParseDuration(value)
	if err != nil {
		return fallback
	}
	return parsed
}

func boolOrDefault(key string, fallback bool) bool {
	value := strings.TrimSpace(os.Getenv(key))
	if value == "" {
		return fallback
	}
	parsed, err := strconv.ParseBool(value)
	if err != nil {
		return fallback
	}
	return parsed
}
