CREATE SCHEMA IF NOT EXISTS vaultcore;

CREATE TABLE IF NOT EXISTS vaultcore.users (
  id TEXT PRIMARY KEY,
  email TEXT NOT NULL,
  name TEXT NOT NULL,
  avatar_url TEXT,
  role TEXT NOT NULL DEFAULT 'user' CHECK (role IN ('user', 'admin')),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_login TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE vaultcore.users ADD COLUMN IF NOT EXISTS avatar_url TEXT;
ALTER TABLE vaultcore.users ADD COLUMN IF NOT EXISTS role TEXT NOT NULL DEFAULT 'user';
ALTER TABLE vaultcore.users ADD COLUMN IF NOT EXISTS is_active BOOLEAN NOT NULL DEFAULT TRUE;
ALTER TABLE vaultcore.users ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE vaultcore.users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE vaultcore.users ADD COLUMN IF NOT EXISTS last_login TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;

UPDATE vaultcore.users SET role = 'user' WHERE role IS NULL OR role = '';
UPDATE vaultcore.users SET is_active = TRUE WHERE is_active IS NULL;

CREATE UNIQUE INDEX IF NOT EXISTS idx_users_email_unique ON vaultcore.users (LOWER(email));

CREATE TABLE IF NOT EXISTS vaultcore.exams (
  slug TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  short_name TEXT NOT NULL,
  category TEXT NOT NULL,
  icon TEXT NOT NULL,
  total_questions INTEGER NOT NULL DEFAULT 0,
  papers INTEGER NOT NULL DEFAULT 0,
  mocks INTEGER NOT NULL DEFAULT 0,
  description TEXT NOT NULL,
  popular_years JSONB NOT NULL,
  subjects JSONB NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE vaultcore.exams ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE vaultcore.exams ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;

CREATE TABLE IF NOT EXISTS vaultcore.papers (
  slug TEXT PRIMARY KEY,
  exam_slug TEXT NOT NULL REFERENCES vaultcore.exams(slug) ON DELETE CASCADE,
  exam_name TEXT NOT NULL,
  title TEXT NOT NULL,
  year TEXT NOT NULL,
  shift TEXT NOT NULL,
  description TEXT NOT NULL,
  questions INTEGER NOT NULL,
  subjects JSONB NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE vaultcore.papers ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE vaultcore.papers ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;

CREATE TABLE IF NOT EXISTS vaultcore.questions (
  slug TEXT PRIMARY KEY,
  exam_slug TEXT NOT NULL REFERENCES vaultcore.exams(slug) ON DELETE CASCADE,
  paper_slug TEXT REFERENCES vaultcore.papers(slug) ON DELETE SET NULL,
  exam_name TEXT NOT NULL,
  year TEXT NOT NULL,
  paper TEXT NOT NULL,
  subject TEXT NOT NULL,
  question_no TEXT NOT NULL,
  question TEXT NOT NULL,
  options JSONB NOT NULL,
  answer_key TEXT NOT NULL,
  answer TEXT NOT NULL,
  explanation TEXT NOT NULL,
  tags JSONB NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE vaultcore.questions ADD COLUMN IF NOT EXISTS paper_slug TEXT;
ALTER TABLE vaultcore.questions ADD COLUMN IF NOT EXISTS mock_slug TEXT;
ALTER TABLE vaultcore.questions ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE vaultcore.questions ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'questions_paper_slug_fkey'
      AND connamespace = 'vaultcore'::regnamespace
  ) THEN
    ALTER TABLE vaultcore.questions
      ADD CONSTRAINT questions_paper_slug_fkey
      FOREIGN KEY (paper_slug) REFERENCES vaultcore.papers(slug) ON DELETE SET NULL;
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS vaultcore.mocks (
  slug TEXT PRIMARY KEY,
  exam_slug TEXT NOT NULL REFERENCES vaultcore.exams(slug) ON DELETE CASCADE,
  exam_name TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  questions INTEGER NOT NULL,
  duration_minutes INTEGER NOT NULL,
  difficulty TEXT NOT NULL,
  is_free BOOLEAN NOT NULL,
  subjects JSONB NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE vaultcore.mocks ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE vaultcore.mocks ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'questions_mock_slug_fkey'
      AND connamespace = 'vaultcore'::regnamespace
  ) THEN
    ALTER TABLE vaultcore.questions
      ADD CONSTRAINT questions_mock_slug_fkey
      FOREIGN KEY (mock_slug) REFERENCES vaultcore.mocks(slug) ON DELETE CASCADE;
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS vaultcore.user_enrollments (
  user_id     TEXT NOT NULL REFERENCES vaultcore.users(id) ON DELETE CASCADE,
  exam_slug   TEXT NOT NULL REFERENCES vaultcore.exams(slug) ON DELETE CASCADE,
  enrolled_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, exam_slug)
);

CREATE INDEX IF NOT EXISTS idx_user_enrollments_user_id   ON vaultcore.user_enrollments(user_id);
CREATE INDEX IF NOT EXISTS idx_user_enrollments_exam_slug ON vaultcore.user_enrollments(exam_slug);

CREATE TABLE IF NOT EXISTS vaultcore.auth_sessions (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES vaultcore.users(id) ON DELETE CASCADE,
  refresh_token_hash TEXT NOT NULL UNIQUE,
  user_agent TEXT,
  ip_address TEXT,
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_seen_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  revoked_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS vaultcore.user_attempts (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL REFERENCES vaultcore.users(id) ON DELETE CASCADE,
  mock_slug TEXT REFERENCES vaultcore.mocks(slug) ON DELETE SET NULL,
  paper_slug TEXT REFERENCES vaultcore.papers(slug) ON DELETE SET NULL,
  exam_slug TEXT NOT NULL,
  score INTEGER NOT NULL DEFAULT 0,
  total_questions INTEGER NOT NULL DEFAULT 0,
  correct_answers INTEGER NOT NULL DEFAULT 0,
  wrong_answers INTEGER NOT NULL DEFAULT 0,
  skipped_answers INTEGER NOT NULL DEFAULT 0,
  time_taken_seconds INTEGER NOT NULL DEFAULT 0,
  answers JSONB NOT NULL DEFAULT '{}',
  completed_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_questions_exam_slug ON vaultcore.questions(exam_slug);
CREATE INDEX IF NOT EXISTS idx_questions_paper_slug ON vaultcore.questions(paper_slug);
CREATE INDEX IF NOT EXISTS idx_questions_mock_slug ON vaultcore.questions(mock_slug);
CREATE INDEX IF NOT EXISTS idx_papers_exam_slug ON vaultcore.papers(exam_slug);
CREATE INDEX IF NOT EXISTS idx_mocks_exam_slug ON vaultcore.mocks(exam_slug);
CREATE INDEX IF NOT EXISTS idx_auth_sessions_user_id ON vaultcore.auth_sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_auth_sessions_expires_at ON vaultcore.auth_sessions(expires_at);
ALTER TABLE vaultcore.user_attempts ADD COLUMN IF NOT EXISTS paper_slug       TEXT     REFERENCES vaultcore.papers(slug) ON DELETE SET NULL;
ALTER TABLE vaultcore.user_attempts ADD COLUMN IF NOT EXISTS attempt_number   INTEGER  NOT NULL DEFAULT 1;
ALTER TABLE vaultcore.user_attempts ADD COLUMN IF NOT EXISTS is_official       BOOLEAN  NOT NULL DEFAULT TRUE;

ALTER TABLE vaultcore.papers ADD COLUMN IF NOT EXISTS negative_marking NUMERIC(4,2) NOT NULL DEFAULT 0;
ALTER TABLE vaultcore.mocks  ADD COLUMN IF NOT EXISTS negative_marking NUMERIC(4,2) NOT NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS vaultcore.exam_cutoffs (
  id          SERIAL       PRIMARY KEY,
  exam_slug   TEXT         NOT NULL REFERENCES vaultcore.exams(slug) ON DELETE CASCADE,
  stage       TEXT         NOT NULL,
  year        TEXT         NOT NULL,
  category    TEXT         NOT NULL,
  marks       NUMERIC(8,2) NOT NULL,
  total_marks NUMERIC(8,2) NOT NULL DEFAULT 0,
  avg_score   NUMERIC(8,2) NOT NULL DEFAULT 0,
  std_dev     NUMERIC(8,2) NOT NULL DEFAULT 0,
  source      TEXT         NOT NULL DEFAULT 'official',
  created_at  TIMESTAMPTZ  NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMPTZ  NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (exam_slug, stage, year, category)
);

CREATE INDEX IF NOT EXISTS idx_user_attempts_user_id    ON vaultcore.user_attempts(user_id);
CREATE INDEX IF NOT EXISTS idx_user_attempts_mock_slug  ON vaultcore.user_attempts(mock_slug);
CREATE INDEX IF NOT EXISTS idx_user_attempts_paper_slug ON vaultcore.user_attempts(paper_slug);
CREATE INDEX IF NOT EXISTS idx_user_attempts_exam_slug  ON vaultcore.user_attempts(exam_slug);
CREATE INDEX IF NOT EXISTS idx_user_attempts_completed_at ON vaultcore.user_attempts(completed_at DESC);
CREATE INDEX IF NOT EXISTS idx_exam_cutoffs_exam_slug   ON vaultcore.exam_cutoffs(exam_slug);
