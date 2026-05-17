-- MockVault migration for existing database
-- Run once on newdb after switching from AWS:
--   psql -U postgres -d newdb -f database/migrate.sql

-- 1. Ensure vaultcore schema exists
CREATE SCHEMA IF NOT EXISTS vaultcore;

-- 2. Drop the single-admin constraint (was preventing more than one admin user)
DROP INDEX IF EXISTS vaultcore.idx_users_single_admin;

-- 3. Fix exams column types: TEXT -> INTEGER
--    Safe only if existing values are numeric strings; otherwise seed data after truncation.
ALTER TABLE vaultcore.exams
  ALTER COLUMN total_questions TYPE INTEGER USING CAST(NULLIF(TRIM(total_questions), '') AS INTEGER),
  ALTER COLUMN papers           TYPE INTEGER USING CAST(NULLIF(TRIM(papers), '')           AS INTEGER),
  ALTER COLUMN mocks            TYPE INTEGER USING CAST(NULLIF(TRIM(mocks), '')            AS INTEGER);

ALTER TABLE vaultcore.exams
  ALTER COLUMN total_questions SET DEFAULT 0,
  ALTER COLUMN papers           SET DEFAULT 0,
  ALTER COLUMN mocks            SET DEFAULT 0;

-- 4. Add user_attempts table for server-side attempt tracking
CREATE TABLE IF NOT EXISTS vaultcore.user_attempts (
  id                  TEXT PRIMARY KEY,
  user_id             TEXT NOT NULL REFERENCES vaultcore.users(id) ON DELETE CASCADE,
  mock_slug           TEXT NOT NULL REFERENCES vaultcore.mocks(slug) ON DELETE CASCADE,
  exam_slug           TEXT NOT NULL,
  score               INTEGER NOT NULL DEFAULT 0,
  total_questions     INTEGER NOT NULL DEFAULT 0,
  correct_answers     INTEGER NOT NULL DEFAULT 0,
  wrong_answers       INTEGER NOT NULL DEFAULT 0,
  skipped_answers     INTEGER NOT NULL DEFAULT 0,
  time_taken_seconds  INTEGER NOT NULL DEFAULT 0,
  answers             JSONB NOT NULL DEFAULT '{}',
  completed_at        TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_user_attempts_user_id     ON vaultcore.user_attempts(user_id);
CREATE INDEX IF NOT EXISTS idx_user_attempts_mock_slug   ON vaultcore.user_attempts(mock_slug);
CREATE INDEX IF NOT EXISTS idx_user_attempts_completed_at ON vaultcore.user_attempts(completed_at DESC);
