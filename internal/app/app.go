package app

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"log"
	"net/http"
	"time"

	_ "github.com/lib/pq"
	"github.com/redis/go-redis/v9"

	"mock-vault-webservice/internal/auth"
	"mock-vault-webservice/internal/config"
	"mock-vault-webservice/internal/httpapi"
	"mock-vault-webservice/internal/repository"
)

func Run() error {
	cfg, err := config.Load()
	if err != nil {
		return err
	}

	db, err := sql.Open("postgres", cfg.DatabaseURL)
	if err != nil {
		return fmt.Errorf("open database: %w", err)
	}
	defer db.Close()

	db.SetConnMaxLifetime(30 * time.Minute)
	db.SetMaxIdleConns(5)
	db.SetMaxOpenConns(20)

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := db.PingContext(ctx); err != nil {
		return fmt.Errorf("ping database: %w", err)
	}

	rdb, err := connectRedis(ctx, cfg)
	if err != nil {
		log.Printf("redis unavailable, continuing without cache: %v", err)
		rdb = nil
	}
	if rdb != nil {
		defer rdb.Close()
	}

	repo := repository.NewPostgresRepository(db)
	authService := auth.NewService(cfg, repo, rdb)
	apiServer := httpapi.NewServer(cfg, repo, authService, rdb)

	server := &http.Server{
		Addr:              cfg.HTTPAddr,
		Handler:           apiServer.Handler(),
		ReadHeaderTimeout: 5 * time.Second,
		ReadTimeout:       10 * time.Second,
		WriteTimeout:      15 * time.Second,
		IdleTimeout:       60 * time.Second,
	}

	log.Printf("server listening on %s", cfg.HTTPAddr)
	return server.ListenAndServe()
}

func connectRedis(ctx context.Context, cfg config.Config) (*redis.Client, error) {
	if cfg.RedisAddr == "" {
		return nil, errors.New("REDIS_ADDR is not set")
	}

	rdb := redis.NewClient(&redis.Options{
		Addr:        cfg.RedisAddr,
		DialTimeout: cfg.RedisDialTimeout,
	})

	if err := rdb.Ping(ctx).Err(); err != nil {
		_ = rdb.Close()
		return nil, err
	}

	return rdb, nil
}
