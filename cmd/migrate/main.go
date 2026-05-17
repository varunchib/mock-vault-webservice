package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"path/filepath"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
)

func main() {
	_ = godotenv.Load()

	databaseURL := os.Getenv("DATABASE_URL")
	if databaseURL == "" {
		log.Fatal("DATABASE_URL is required")
	}

	db, err := sql.Open("postgres", databaseURL)
	if err != nil {
		log.Fatalf("open database: %v", err)
	}
	defer db.Close()

	if err := db.Ping(); err != nil {
		log.Fatalf("ping database: %v", err)
	}

	for _, file := range []string{
		filepath.Join("database", "schema.sql"),
		filepath.Join("database", "seed.sql"),
	} {
		if err := execSQLFile(db, file); err != nil {
			log.Fatal(err)
		}
	}

	fmt.Println("database migration completed")
}

func execSQLFile(db *sql.DB, path string) error {
	data, err := os.ReadFile(path)
	if err != nil {
		return fmt.Errorf("read sql file %s: %w", path, err)
	}
	if _, err := db.Exec(string(data)); err != nil {
		return fmt.Errorf("execute sql file %s: %w", path, err)
	}
	return nil
}
