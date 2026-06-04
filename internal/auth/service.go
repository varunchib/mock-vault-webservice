package auth

import (
	"context"
	"crypto/rand"
	"crypto/sha256"
	"database/sql"
	"encoding/base64"
	"encoding/hex"
	"errors"
	"fmt"
	"strings"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/redis/go-redis/v9"
	"google.golang.org/api/idtoken"

	"mock-vault-webservice/internal/config"
	"mock-vault-webservice/internal/models"
	"mock-vault-webservice/internal/repository"
)

const (
	SessionCachePrefix = "session:"
)

var ErrUnauthorized = errors.New("unauthorized")

type Service struct {
	cfg  config.Config
	repo *repository.PostgresRepository
	rdb  *redis.Client
}

type SessionMetadata struct {
	UserAgent string
	IPAddress string
	City      string
}

type AccessClaims struct {
	Email     string `json:"email"`
	Role      string `json:"role"`
	SessionID string `json:"sessionId"`
	jwt.RegisteredClaims
}

type AuthResult struct {
	User                  models.User `json:"user"`
	AccessToken           string      `json:"-"`
	RefreshToken          string      `json:"-"`
	AccessTokenExpiresAt  time.Time   `json:"accessTokenExpiresAt"`
	RefreshTokenExpiresAt time.Time   `json:"refreshTokenExpiresAt"`
}

func NewService(cfg config.Config, repo *repository.PostgresRepository, rdb *redis.Client) *Service {
	return &Service{cfg: cfg, repo: repo, rdb: rdb}
}

func (s *Service) AuthenticateGoogle(ctx context.Context, credential string, meta SessionMetadata) (AuthResult, error) {
	payload, err := idtoken.Validate(ctx, credential, s.cfg.GoogleClientID)
	if err != nil {
		return AuthResult{}, fmt.Errorf("%w: invalid google credential", ErrUnauthorized)
	}

	email := strings.ToLower(claimAsString(payload.Claims, "email"))
	name := claimAsString(payload.Claims, "name")
	avatarURL := claimAsString(payload.Claims, "picture")
	emailVerified := claimAsBool(payload.Claims, "email_verified")

	if payload.Subject == "" || email == "" || name == "" || !emailVerified {
		return AuthResult{}, fmt.Errorf("%w: incomplete google profile", ErrUnauthorized)
	}

	user, err := s.repo.UpsertGoogleUser(ctx, repository.GoogleUserInput{
		ID:        payload.Subject,
		Email:     email,
		Name:      name,
		AvatarURL: avatarURL,
		City:      meta.City,
	})
	if err != nil {
		return AuthResult{}, err
	}

	return s.issueSession(ctx, user, meta, "")
}

func (s *Service) RefreshSession(ctx context.Context, refreshToken string, meta SessionMetadata) (AuthResult, error) {
	if strings.TrimSpace(refreshToken) == "" {
		return AuthResult{}, fmt.Errorf("%w: missing refresh token", ErrUnauthorized)
	}

	tokenHash := hashToken(refreshToken)
	session, err := s.repo.GetSessionByHash(ctx, tokenHash)
	if err != nil {
		if errors.Is(err, repository.ErrNotFound) {
			return AuthResult{}, fmt.Errorf("%w: refresh session not found", ErrUnauthorized)
		}
		return AuthResult{}, err
	}

	if session.RevokedAt != nil || time.Now().After(session.ExpiresAt) {
		return AuthResult{}, fmt.Errorf("%w: refresh session expired", ErrUnauthorized)
	}

	user, err := s.repo.GetUserByID(ctx, session.UserID)
	if err != nil {
		if errors.Is(err, repository.ErrNotFound) {
			return AuthResult{}, fmt.Errorf("%w: user not found", ErrUnauthorized)
		}
		return AuthResult{}, err
	}

	return s.issueSession(ctx, user, meta, session.ID)
}

func (s *Service) Logout(ctx context.Context, sessionID string) error {
	if strings.TrimSpace(sessionID) == "" {
		return nil
	}

	if err := s.repo.RevokeSession(ctx, sessionID); err != nil && !errors.Is(err, sql.ErrNoRows) {
		return err
	}
	if s.rdb != nil {
		_ = s.rdb.Del(ctx, SessionCachePrefix+sessionID).Err()
	}
	return nil
}

func (s *Service) ParseAccessToken(tokenString string) (*AccessClaims, error) {
	claims := &AccessClaims{}
	token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (any, error) {
		if token.Method != jwt.SigningMethodHS256 {
			return nil, fmt.Errorf("unexpected jwt method")
		}
		return []byte(s.cfg.JWTSecret), nil
	})
	if err != nil || !token.Valid {
		return nil, fmt.Errorf("%w: invalid access token", ErrUnauthorized)
	}
	return claims, nil
}

func (s *Service) IsSessionActive(ctx context.Context, sessionID string) (bool, error) {
	if sessionID == "" {
		return false, nil
	}

	if s.rdb != nil {
		key := SessionCachePrefix + sessionID
		_, err := s.rdb.Get(ctx, key).Result()
		switch {
		case err == nil:
			return true, nil
		case errors.Is(err, redis.Nil):
		default:
			return false, err
		}
	}

	session, err := s.repo.GetSessionByID(ctx, sessionID)
	if err != nil {
		if errors.Is(err, repository.ErrNotFound) {
			return false, nil
		}
		return false, err
	}
	if session.RevokedAt != nil || time.Now().After(session.ExpiresAt) {
		return false, nil
	}

	if s.rdb != nil {
		ttl := time.Until(session.ExpiresAt)
		if ttl > 0 {
			_ = s.rdb.Set(ctx, SessionCachePrefix+session.ID, session.UserID, ttl).Err()
		}
	}

	return true, nil
}

func (s *Service) issueSession(ctx context.Context, user models.User, meta SessionMetadata, existingSessionID string) (AuthResult, error) {
	sessionID := existingSessionID
	if sessionID == "" {
		sessionID = randomToken(24)
	}

	refreshToken := randomToken(48)
	refreshHash := hashToken(refreshToken)
	accessExpiry := time.Now().Add(s.cfg.AccessTokenTTL)
	refreshExpiry := time.Now().Add(s.cfg.RefreshTokenTTL)

	if existingSessionID == "" {
		if err := s.repo.CreateSession(ctx, repository.SessionInput{
			ID:               sessionID,
			UserID:           user.ID,
			RefreshTokenHash: refreshHash,
			UserAgent:        meta.UserAgent,
			IPAddress:        meta.IPAddress,
			ExpiresAt:        refreshExpiry,
		}); err != nil {
			return AuthResult{}, err
		}
	} else {
		if err := s.repo.RotateSession(ctx, sessionID, refreshHash, meta.UserAgent, meta.IPAddress, refreshExpiry); err != nil {
			return AuthResult{}, err
		}
	}

	if s.rdb != nil {
		ttl := time.Until(refreshExpiry)
		if ttl > 0 {
			_ = s.rdb.Set(ctx, SessionCachePrefix+sessionID, user.ID, ttl).Err()
		}
	}

	accessToken, err := s.signAccessToken(user, sessionID, accessExpiry)
	if err != nil {
		return AuthResult{}, err
	}

	return AuthResult{
		User:                  user,
		AccessToken:           accessToken,
		RefreshToken:          refreshToken,
		AccessTokenExpiresAt:  accessExpiry,
		RefreshTokenExpiresAt: refreshExpiry,
	}, nil
}

func (s *Service) signAccessToken(user models.User, sessionID string, expiresAt time.Time) (string, error) {
	claims := AccessClaims{
		Email:     user.Email,
		Role:      user.Role,
		SessionID: sessionID,
		RegisteredClaims: jwt.RegisteredClaims{
			Subject:   user.ID,
			ExpiresAt: jwt.NewNumericDate(expiresAt),
			IssuedAt:  jwt.NewNumericDate(time.Now()),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	signed, err := token.SignedString([]byte(s.cfg.JWTSecret))
	if err != nil {
		return "", fmt.Errorf("sign access token: %w", err)
	}
	return signed, nil
}

func randomToken(size int) string {
	buf := make([]byte, size)
	if _, err := rand.Read(buf); err != nil {
		panic(err)
	}
	return base64.RawURLEncoding.EncodeToString(buf)
}

func hashToken(token string) string {
	sum := sha256.Sum256([]byte(token))
	return hex.EncodeToString(sum[:])
}

func claimAsString(claims map[string]any, key string) string {
	raw, ok := claims[key]
	if !ok || raw == nil {
		return ""
	}
	value, ok := raw.(string)
	if !ok {
		return ""
	}
	return strings.TrimSpace(value)
}

func claimAsBool(claims map[string]any, key string) bool {
	raw, ok := claims[key]
	if !ok || raw == nil {
		return false
	}
	switch value := raw.(type) {
	case bool:
		return value
	case string:
		return strings.EqualFold(value, "true")
	default:
		return false
	}
}
