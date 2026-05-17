# Database

This folder contains the PostgreSQL schema and seed data for the backend.

Files:

- `schema.sql` creates and upgrades the `vaultcore` schema.
- `seed.sql` upserts the baseline catalog, paper, question, and mock content.

Usage:

1. Set `DATABASE_URL` in `mock-vault-webservice/.env`.
2. Run `go run ./cmd/migrate`.
3. Start the API with `go run .`.

Core tables:

- `vaultcore.users`
- `vaultcore.auth_sessions`
- `vaultcore.exams`
- `vaultcore.papers`
- `vaultcore.questions`
- `vaultcore.mocks`
