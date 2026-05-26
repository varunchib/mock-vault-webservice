package app

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"log"
	"net/http"
	"os/signal"
	"syscall"
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
	db.SetMaxIdleConns(25)
	db.SetMaxOpenConns(100)

	pingCtx, pingCancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer pingCancel()
	if err := db.PingContext(pingCtx); err != nil {
		return fmt.Errorf("ping database: %w", err)
	}

	redisCtx, redisCancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer redisCancel()

	rdb, err := connectRedis(redisCtx, cfg)
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

	srv := &http.Server{
		Addr:              cfg.HTTPAddr,
		Handler:           apiServer.Handler(),
		ReadHeaderTimeout: 5 * time.Second,
		ReadTimeout:       10 * time.Second,
		WriteTimeout:      30 * time.Second,
		IdleTimeout:       60 * time.Second,
	}

	ctx, stop := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	defer stop()

	go func() {
		log.Printf("server listening on %s", cfg.HTTPAddr)
		if err := srv.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
			log.Printf("server error: %v", err)
		}
	}()

	<-ctx.Done()
	log.Println("shutdown signal received")

	apiServer.Shutdown()

	shutCtx, shutCancel := context.WithTimeout(context.Background(), 15*time.Second)
	defer shutCancel()
	if err := srv.Shutdown(shutCtx); err != nil {
		return fmt.Errorf("server shutdown: %w", err)
	}
	log.Println("server stopped cleanly")
	return nil
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
