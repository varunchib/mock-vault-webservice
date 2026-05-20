package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
)

func main() {
	_ = godotenv.Load()
	db, err := sql.Open("postgres", os.Getenv("DATABASE_URL"))
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	rows, err := db.Query(`
		SELECT question_no, answer_key, answer, LEFT(question, 60)
		FROM vaultcore.questions
		WHERE paper_slug = 'jkssb-social-forestry-worker-2026-may-17'
		ORDER BY question_no`)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	fmt.Printf("%-4s %-4s %-25s %s\n", "Q#", "Ans", "Answer text", "Question (60 chars)")
	fmt.Println("-------------------------------------------------------------------------------------")
	for rows.Next() {
		var qno int
		var key, ans, q string
		rows.Scan(&qno, &key, &ans, &q)
		fmt.Printf("%-4d %-4s %-25s %s\n", qno, key, ans, q)
	}
}
