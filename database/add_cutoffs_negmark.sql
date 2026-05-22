-- Migration: exam_cutoffs table + negative marking + attempt tracking
-- Run once: psql -U $DB_USER -d $DB_NAME -f database/add_cutoffs_negmark.sql

-- ── 1. Exam cutoffs ──────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS vaultcore.exam_cutoffs (
  id          SERIAL PRIMARY KEY,
  exam_slug   TEXT        NOT NULL REFERENCES vaultcore.exams(slug) ON DELETE CASCADE,
  stage       TEXT        NOT NULL,             -- e.g. 'Prelims', 'Tier I', 'CBT 1'
  year        TEXT        NOT NULL,             -- e.g. '2024', '2023-24'
  category    TEXT        NOT NULL,             -- 'General', 'OBC', 'SC', 'ST', 'OBC/SC/ST'
  marks       NUMERIC(8,2) NOT NULL,            -- cutoff marks for this category
  total_marks NUMERIC(8,2) NOT NULL DEFAULT 0,  -- max marks for the paper
  avg_score   NUMERIC(8,2) NOT NULL DEFAULT 0,  -- population average (for percentile math)
  std_dev     NUMERIC(8,2) NOT NULL DEFAULT 0,  -- population std deviation
  source      TEXT        NOT NULL DEFAULT 'official',
  created_at  TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (exam_slug, stage, year, category)
);

CREATE INDEX IF NOT EXISTS idx_exam_cutoffs_exam_slug ON vaultcore.exam_cutoffs(exam_slug);

-- ── 2. Negative marking on papers and mocks ──────────────────────────────────
-- Stored as marks deducted per wrong answer (e.g. 0.25 means -0.25 per wrong)
ALTER TABLE vaultcore.papers ADD COLUMN IF NOT EXISTS negative_marking NUMERIC(4,2) NOT NULL DEFAULT 0;
ALTER TABLE vaultcore.mocks  ADD COLUMN IF NOT EXISTS negative_marking NUMERIC(4,2) NOT NULL DEFAULT 0;

-- ── 3. Attempt-number tracking for official vs revised attempts ───────────────
ALTER TABLE vaultcore.user_attempts ADD COLUMN IF NOT EXISTS attempt_number INTEGER  NOT NULL DEFAULT 1;
ALTER TABLE vaultcore.user_attempts ADD COLUMN IF NOT EXISTS is_official     BOOLEAN  NOT NULL DEFAULT TRUE;
-- paper_slug constraint was added in schema.sql but may reference the NOT NULL column; allow null
ALTER TABLE vaultcore.user_attempts ALTER COLUMN paper_slug DROP NOT NULL;

CREATE INDEX IF NOT EXISTS idx_user_attempts_exam_slug ON vaultcore.user_attempts(exam_slug);
CREATE INDEX IF NOT EXISTS idx_user_attempts_paper_slug ON vaultcore.user_attempts(paper_slug);

-- ── 4. Seed official cutoff data ─────────────────────────────────────────────

-- IBPS PO
INSERT INTO vaultcore.exam_cutoffs (exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source)
SELECT 'ibps-po', 'Prelims', '2024', 'General', 61.75, 100, 48, 12, 'official'
WHERE EXISTS (SELECT 1 FROM vaultcore.exams WHERE slug = 'ibps-po')
ON CONFLICT (exam_slug, stage, year, category) DO UPDATE
  SET marks=EXCLUDED.marks, total_marks=EXCLUDED.total_marks, avg_score=EXCLUDED.avg_score,
      std_dev=EXCLUDED.std_dev, updated_at=CURRENT_TIMESTAMP;

INSERT INTO vaultcore.exam_cutoffs (exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source)
SELECT 'ibps-po', 'Prelims', '2024', 'OBC', 58.75, 100, 48, 12, 'official'
WHERE EXISTS (SELECT 1 FROM vaultcore.exams WHERE slug = 'ibps-po')
ON CONFLICT (exam_slug, stage, year, category) DO UPDATE SET marks=EXCLUDED.marks, updated_at=CURRENT_TIMESTAMP;

INSERT INTO vaultcore.exam_cutoffs (exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source)
SELECT 'ibps-po', 'Prelims', '2024', 'SC', 51.75, 100, 48, 12, 'official'
WHERE EXISTS (SELECT 1 FROM vaultcore.exams WHERE slug = 'ibps-po')
ON CONFLICT (exam_slug, stage, year, category) DO UPDATE SET marks=EXCLUDED.marks, updated_at=CURRENT_TIMESTAMP;

INSERT INTO vaultcore.exam_cutoffs (exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source)
SELECT 'ibps-po', 'Prelims', '2024', 'ST', 42.75, 100, 48, 12, 'official'
WHERE EXISTS (SELECT 1 FROM vaultcore.exams WHERE slug = 'ibps-po')
ON CONFLICT (exam_slug, stage, year, category) DO UPDATE SET marks=EXCLUDED.marks, updated_at=CURRENT_TIMESTAMP;

-- SBI PO
INSERT INTO vaultcore.exam_cutoffs (exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source)
SELECT 'sbi-po', 'Prelims', '2024-25', c.category, c.marks, 100, 50, 12, 'official'
FROM (VALUES ('General',65.0),('OBC',62.0),('SC',55.0),('ST',48.0)) AS c(category,marks)
WHERE EXISTS (SELECT 1 FROM vaultcore.exams WHERE slug = 'sbi-po')
ON CONFLICT (exam_slug, stage, year, category) DO UPDATE SET marks=EXCLUDED.marks, updated_at=CURRENT_TIMESTAMP;

-- IBPS Clerk
INSERT INTO vaultcore.exam_cutoffs (exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source)
SELECT 'ibps-clerk', 'Prelims', '2023-24', c.category, c.marks, 100, 55, 13, 'official'
FROM (VALUES ('General',74.5),('OBC',71.5),('SC',64.0),('ST',54.0)) AS c(category,marks)
WHERE EXISTS (SELECT 1 FROM vaultcore.exams WHERE slug = 'ibps-clerk')
ON CONFLICT (exam_slug, stage, year, category) DO UPDATE SET marks=EXCLUDED.marks, updated_at=CURRENT_TIMESTAMP;

-- SBI Clerk
INSERT INTO vaultcore.exam_cutoffs (exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source)
SELECT 'sbi-clerk', 'Prelims', '2023-24', c.category, c.marks, 100, 55, 12, 'official'
FROM (VALUES ('General',72.0),('OBC',69.25),('SC',59.0),('ST',53.0)) AS c(category,marks)
WHERE EXISTS (SELECT 1 FROM vaultcore.exams WHERE slug = 'sbi-clerk')
ON CONFLICT (exam_slug, stage, year, category) DO UPDATE SET marks=EXCLUDED.marks, updated_at=CURRENT_TIMESTAMP;

-- SSC CGL
INSERT INTO vaultcore.exam_cutoffs (exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source)
SELECT 'ssc-cgl', 'Tier I', '2023-24', c.category, c.marks, 200, 118, 24, 'official'
FROM (VALUES ('General',148.0),('OBC',144.5),('SC',127.0),('ST',116.0)) AS c(category,marks)
WHERE EXISTS (SELECT 1 FROM vaultcore.exams WHERE slug = 'ssc-cgl')
ON CONFLICT (exam_slug, stage, year, category) DO UPDATE SET marks=EXCLUDED.marks, updated_at=CURRENT_TIMESTAMP;

-- SSC CHSL
INSERT INTO vaultcore.exam_cutoffs (exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source)
SELECT 'ssc-chsl', 'Tier I', '2023-24', c.category, c.marks, 200, 112, 22, 'official'
FROM (VALUES ('General',143.5),('OBC',139.25),('SC',120.75),('ST',110.5)) AS c(category,marks)
WHERE EXISTS (SELECT 1 FROM vaultcore.exams WHERE slug = 'ssc-chsl')
ON CONFLICT (exam_slug, stage, year, category) DO UPDATE SET marks=EXCLUDED.marks, updated_at=CURRENT_TIMESTAMP;

-- UPSC CSE
INSERT INTO vaultcore.exam_cutoffs (exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source)
SELECT 'upsc-cse', 'Prelims (GS Paper I)', '2024', c.category, c.marks, 200, 88, 20, 'official'
FROM (VALUES ('General',105.34),('OBC',105.34),('SC',93.51),('ST',89.41)) AS c(category,marks)
WHERE EXISTS (SELECT 1 FROM vaultcore.exams WHERE slug = 'upsc-cse')
ON CONFLICT (exam_slug, stage, year, category) DO UPDATE SET marks=EXCLUDED.marks, updated_at=CURRENT_TIMESTAMP;

-- RRB NTPC
INSERT INTO vaultcore.exam_cutoffs (exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source)
SELECT 'rrb-ntpc', 'CBT 1', '2024', c.category, c.marks, 100, 55, 12, 'official'
FROM (VALUES ('General',69.84),('OBC',66.62),('SC',60.0),('ST',55.0)) AS c(category,marks)
WHERE EXISTS (SELECT 1 FROM vaultcore.exams WHERE slug = 'rrb-ntpc')
ON CONFLICT (exam_slug, stage, year, category) DO UPDATE SET marks=EXCLUDED.marks, updated_at=CURRENT_TIMESTAMP;

-- NEET UG
INSERT INTO vaultcore.exam_cutoffs (exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source)
SELECT 'neet-ug', 'Cut-off (General)', '2024', c.category, c.marks, 720, 300, 100, 'official'
FROM (VALUES ('General',164.0),('OBC/SC/ST',129.0)) AS c(category,marks)
WHERE EXISTS (SELECT 1 FROM vaultcore.exams WHERE slug = 'neet-ug')
ON CONFLICT (exam_slug, stage, year, category) DO UPDATE SET marks=EXCLUDED.marks, updated_at=CURRENT_TIMESTAMP;
