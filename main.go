package main

import (
	"log"

	"mock-vault-webservice/internal/app"
)

func main() {
	if err := app.Run(); err != nil {
		log.Fatal(err)
	}
}

