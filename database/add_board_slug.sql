-- ─────────────────────────────────────────────────────────────
-- Per-post architecture migration
-- Adds board_slug to exams, seeds JKSSB posts, re-tags papers
-- Run once: psql -f database/add_board_slug.sql
-- ─────────────────────────────────────────────────────────────

-- 1. Add board_slug column (self-referencing FK)
ALTER TABLE vaultcore.exams
  ADD COLUMN IF NOT EXISTS board_slug TEXT REFERENCES vaultcore.exams(slug) ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_exams_board_slug ON vaultcore.exams(board_slug);

-- 2. Seed JKSSB post exam rows
INSERT INTO vaultcore.exams
  (slug, name, short_name, category, icon, total_questions, papers, mocks,
   description, popular_years, subjects, board_slug)
VALUES
  ('jkssb-junior-assistant',
   'JKSSB Junior Assistant', 'JKSSB Junior Asst.', 'J&K', '📜', 0, 0, 0,
   'JKSSB Junior Assistant previous year papers with solved answers, detailed explanations, and free practice mocks.',
   '["2024","2023","2022","2021"]'::jsonb,
   '["General Knowledge","Quantitative Aptitude","Reasoning","English"]'::jsonb,
   'jkssb'),

  ('jkssb-patwari',
   'JKSSB Patwari', 'JKSSB Patwari', 'J&K', '📜', 0, 0, 0,
   'JKSSB Patwari previous year papers with Revenue Laws, GK, Arithmetic, and Reasoning questions fully solved.',
   '["2024","2023","2022","2021"]'::jsonb,
   '["Revenue Laws","General Knowledge","Arithmetic","Reasoning"]'::jsonb,
   'jkssb'),

  ('jkssb-finance-account-assistant',
   'JKSSB Finance Account Assistant', 'JKSSB FAA', 'J&K', '📊', 0, 0, 0,
   'JKSSB Finance Account Assistant previous year papers with Public Finance, Accounting, GK, and Reasoning solved.',
   '["2024","2023","2022"]'::jsonb,
   '["Finance","Accounts","General Knowledge","Reasoning"]'::jsonb,
   'jkssb'),

  ('jkssb-wildlife-guard',
   'JKSSB Wildlife Guard', 'JKSSB Wildlife Guard', 'J&K', '🌿', 0, 0, 0,
   'JKSSB Wildlife Guard previous year papers with Wildlife Science, GK, and Reasoning questions solved.',
   '["2022","2021"]'::jsonb,
   '["Wildlife Science","General Knowledge","Reasoning"]'::jsonb,
   'jkssb')
ON CONFLICT (slug) DO NOTHING;

-- 3. Preview which papers will be re-tagged (run SELECT first to verify)
-- SELECT slug, exam_slug, title, shift FROM vaultcore.papers WHERE exam_slug = 'jkssb' ORDER BY title;

-- 4. Re-tag existing papers from 'jkssb' to their specific post slug
-- Junior Assistant
UPDATE vaultcore.papers
SET exam_slug = 'jkssb-junior-assistant'
WHERE exam_slug = 'jkssb'
  AND (title ILIKE '%junior assistant%' OR shift ILIKE '%junior assistant%');

-- Patwari
UPDATE vaultcore.papers
SET exam_slug = 'jkssb-patwari'
WHERE exam_slug = 'jkssb'
  AND (title ILIKE '%patwari%' OR shift ILIKE '%patwari%');

-- Finance Account Assistant (FAA)
UPDATE vaultcore.papers
SET exam_slug = 'jkssb-finance-account-assistant'
WHERE exam_slug = 'jkssb'
  AND (
    title ILIKE '%finance account%' OR title ILIKE '%finance%account%'
    OR title ILIKE '%FAA%'
    OR shift ILIKE '%finance account%' OR shift ILIKE '%FAA%'
  );

-- Wildlife Guard
UPDATE vaultcore.papers
SET exam_slug = 'jkssb-wildlife-guard'
WHERE exam_slug = 'jkssb'
  AND (title ILIKE '%wildlife%' OR shift ILIKE '%wildlife%');

-- 5. Re-tag questions to match their paper's exam_slug (denormalized field kept in sync)
UPDATE vaultcore.questions q
SET exam_slug = p.exam_slug,
    exam_name = e.short_name
FROM vaultcore.papers p
JOIN vaultcore.exams e ON e.slug = p.exam_slug
WHERE q.paper_slug = p.slug
  AND q.exam_slug != p.exam_slug;

-- 6. Refresh paper/question counts on all post exams
UPDATE vaultcore.exams e
SET
  papers          = (SELECT COUNT(*) FROM vaultcore.papers  p WHERE p.exam_slug = e.slug),
  total_questions = (SELECT COUNT(*) FROM vaultcore.questions q WHERE q.exam_slug = e.slug),
  updated_at      = CURRENT_TIMESTAMP
WHERE e.board_slug = 'jkssb';

-- 7. Refresh the 'jkssb' board row counts (only papers still directly under it remain)
UPDATE vaultcore.exams
SET
  papers          = (SELECT COUNT(*) FROM vaultcore.papers  p WHERE p.exam_slug = 'jkssb'),
  total_questions = (SELECT COUNT(*) FROM vaultcore.questions q WHERE q.exam_slug = 'jkssb'),
  updated_at      = CURRENT_TIMESTAMP
WHERE slug = 'jkssb';

-- Done — verify with:
-- SELECT slug, board_slug, papers, total_questions FROM vaultcore.exams WHERE slug LIKE 'jkssb%' ORDER BY slug;
