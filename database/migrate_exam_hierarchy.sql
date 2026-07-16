-- ============================================================================
-- Exam hierarchy: move papers off the BOARDS (jkssb, jkpsc) and onto the exam
-- each one actually belongs to.
--
-- WHY
--   All 8 JKSSB papers sit on exam_slug='jkssb' (the board), so every sub-exam
--   page shows "0 papers · 0 Qs". A candidate sits "JKSSB Patwari", not "JKSSB".
--
-- WHAT IT TOUCHES
--   1. exams      — INSERT 3 missing post-level exams (board_slug='jkssb')
--   2. papers     — UPDATE exam_slug (8 rows), explicit slug->exam mapping
--   3. questions  — UPDATE exam_slug (920 rows) to follow their paper
--   Counts are NOT written: examSelectSQL now COUNTs papers/questions instead of
--   reading the stored columns, so exams.papers / exams.total_questions are dead
--   weight. (They currently drift anyway: jkssb stored 6/680 vs a real 8/920,
--   and ssc-cgl stored 1 question against a real 100.)
--
-- SAFE TO RUN BEFORE THE BOARD PAGE IS THIN?  YES.
--   ListPapersByExam/ListQuestionsByExam now aggregate a board's sub-exams, so
--   /exam/jkssb keeps all 8 papers after this runs. Deploy the backend FIRST,
--   or the board page will show 0 papers until you do.
--
-- MAPPING IS EXPLICIT, NOT INFERRED
--   Slug-prefix matching does NOT work here: the FAA paper is slugged
--   `jkssb-finance-accounts-2024-paper`, which shares no prefix with `jkssb-faa`,
--   and the PSI papers are slugged `jkpsi-*`. Every row below is mapped by hand.
--
-- HOW TO RUN
--   Dry run (proves it, changes nothing):
--     sed 's/^COMMIT;$/ROLLBACK;/' migrate_jkssb_subexams.sql \
--       | docker exec -i mockvault-postgres-1 psql -U postgres -d mockvault -v ON_ERROR_STOP=1
--   For real:
--     docker exec -i mockvault-postgres-1 psql -U postgres -d mockvault -v ON_ERROR_STOP=1 \
--       < migrate_jkssb_subexams.sql
--   Then flush the API cache (raw SQL bypasses invalidatePublicCache).
--   NOTE: use KEYS, not `--scan --pattern` — the latter returned 0 keys while
--   KEYS returned 6, i.e. it silently flushes NOTHING and you will think the
--   migration failed. Only cache:* — never session:*, that logs everyone out:
--     docker exec mockvault-redis-1 sh -c 'redis-cli KEYS "cache:*" | while read k; do redis-cli DEL "$k"; done'
--
-- J&K POLICE — RESOLVED
--   JKPSC runs the Civil Services exam; it is NOT the police authority. Police
--   recruitment sits under the JKSSB board.
--
--   One exam PER POST, not one per department: `jkpsi` is Sub Inspector, and a
--   future Constable paper gets its own exam alongside it. SI and Constable have
--   different syllabi, patterns and papers, so a single `jkp` exam could not
--   describe both — its guide would advertise the wrong pattern to half its
--   visitors. This also matches every other entry under the board (Patwari, FAA,
--   Wildlife Guard are all posts) and matches how candidates search.
--   jkpsc is left untouched.
--
--   Note `jkpsi` deliberately does NOT start with "jkssb-". It doesn't need to:
--   the hierarchy lives in board_slug, not in the slug string. This row is in
--   fact the clearest example of why slug-prefix guessing had to go — no prefix
--   rule would ever place `jkpsi` under `jkssb`.
-- ============================================================================

BEGIN;

-- ── 1. The three exams that do not exist yet ────────────────────────────────
-- Modelled on the existing jkssb-patwari row (category 'J&K', board_slug 'jkssb').
INSERT INTO vaultcore.exams
  (slug, name, short_name, category, icon, description, popular_years, subjects, board_slug)
VALUES
  ('jkssb-lab-attendant',
   'JKSSB Laboratory Attendant', 'JKSSB Lab Attendant', 'J&K', '🧪',
   'JKSSB Laboratory Attendant previous year papers with Quantitative Aptitude, Reasoning, General Knowledge, Current Affairs, General Science and English — fully solved with answer keys.',
   '["2026"]'::jsonb, '[]'::jsonb, 'jkssb'),
  ('jkssb-veterinary-pharmacist',
   'JKSSB Veterinary Pharmacist', 'JKSSB Vet Pharmacist', 'J&K', '💊',
   'JKSSB Veterinary Pharmacist previous year papers with English, General Knowledge, Current Affairs, Reasoning and Computer Knowledge — fully solved with answer keys.',
   '["2025"]'::jsonb, '[]'::jsonb, 'jkssb'),
  ('jkpsi',
   'JKSSB Sub Inspector of Police (JKPSI)', 'JKSSB JKPSI', 'J&K', '🛡️',
   'JKSSB Sub Inspector of Police (JKPSI) previous year papers — J&K Police SI recruitment, with General Knowledge, English, Reasoning and Mathematics, fully solved with answer keys.',
   '["2022", "2017"]'::jsonb, '[]'::jsonb, 'jkssb')
ON CONFLICT (slug) DO NOTHING;

-- JKPSC is a board too: it runs the Combined Competitive Examination (JKCCE, the
-- Civil Services exam), plus Teachers and others. Only JKCCE is created here —
-- it is the only one with a paper. Creating "Teachers" with nothing under it
-- would just add another empty shell, which is the very problem this fixes.
INSERT INTO vaultcore.exams
  (slug, name, short_name, category, icon, description, popular_years, subjects, board_slug)
VALUES
  ('jkcce',
   'JKPSC Combined Competitive Examination (JKCCE)', 'JKCCE', 'State', '🏔️',
   'JKPSC Combined Competitive Examination (JKCCE) previous year papers — General Studies Paper I and CSAT, fully solved with answer keys, for J&K Gazetted Officer recruitment.',
   '["2025"]'::jsonb, '[]'::jsonb, 'jkpsc')
ON CONFLICT (slug) DO NOTHING;

-- ── 2. Papers: re-point each to the exam it belongs to ──────────────────────
UPDATE vaultcore.papers p
   SET exam_slug = m.exam_slug,
       exam_name = e.name,
       updated_at = now()
  FROM (VALUES
    ('jkssb-wildlife-guard-2026-may-10',  'jkssb-wildlife-guard'),
    ('jkssb-patwari-2024-sep1-set-a',     'jkssb-patwari'),
    ('jkssb-junior-assistant-pyq',        'jkssb-junior-assistant'),
    ('jkssb-finance-accounts-2024-paper', 'jkssb-faa'),
    ('jkssb-lab-attendant-2026-may-10',   'jkssb-lab-attendant'),
    ('jkssb-veterinary-pharmacist-2025',  'jkssb-veterinary-pharmacist'),
    -- SI papers. A future Constable paper gets its OWN exam, not this one.
    ('jkpsi-2022',                        'jkpsi'),
    ('jkpsi-2017',                        'jkpsi'),
    ('jkpsc-jkcce-prelims-2025-gs1-set-b','jkcce')
  ) AS m(paper_slug, exam_slug)
  JOIN vaultcore.exams e ON e.slug = m.exam_slug
 WHERE p.slug = m.paper_slug
   AND p.exam_slug IN ('jkssb', 'jkpsc');

-- ── 3. Questions follow their paper ─────────────────────────────────────────
-- questions carries its OWN exam_slug; moving papers alone would leave ~920
-- questions pointing at the board, so sub-exam pages would list papers but no
-- questions.
UPDATE vaultcore.questions q
   SET exam_slug = p.exam_slug,
       exam_name = p.exam_name,
       updated_at = now()
  FROM vaultcore.papers p
 WHERE q.paper_slug = p.slug
   AND q.exam_slug IN ('jkssb', 'jkpsc')
   AND p.exam_slug <> q.exam_slug;

-- ── 4. Verification — read this before COMMIT ───────────────────────────────
\echo
\echo 'Expect: jkssb owns 0 papers directly, but still aggregates 8 / 920.'
SELECT e.slug,
       (SELECT count(*) FROM vaultcore.papers p WHERE p.exam_slug = e.slug) AS own_papers,
       (SELECT count(*) FROM vaultcore.questions q WHERE q.exam_slug = e.slug) AS own_questions,
       (SELECT count(*) FROM vaultcore.papers p
          WHERE p.exam_slug = e.slug
             OR p.exam_slug IN (SELECT s.slug FROM vaultcore.exams s WHERE s.board_slug = e.slug)) AS shown_papers,
       (SELECT count(*) FROM vaultcore.questions q
          WHERE q.exam_slug = e.slug
             OR q.exam_slug IN (SELECT s.slug FROM vaultcore.exams s WHERE s.board_slug = e.slug)) AS shown_questions
FROM vaultcore.exams e
WHERE e.slug IN ('jkssb','jkpsc') OR e.board_slug IN ('jkssb','jkpsc')
ORDER BY COALESCE(e.board_slug, e.slug), e.board_slug NULLS FIRST, e.slug;

\echo
\echo 'Expect: 0 rows. Any row here is a paper or question left behind on the board.'
SELECT 'orphan paper' AS kind, slug FROM vaultcore.papers WHERE exam_slug IN ('jkssb','jkpsc')
UNION ALL
SELECT 'orphan question', slug FROM vaultcore.questions WHERE exam_slug IN ('jkssb','jkpsc') LIMIT 20;

COMMIT;
