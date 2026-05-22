-- GS2 (CSAT): fix negative marking to 0.66, add 66-mark qualifying cutoff
UPDATE vaultcore.papers
SET negative_marking = 0.66
WHERE slug = 'upsc-cse-prelims-2025-gs2';

INSERT INTO vaultcore.exam_cutoffs
  (exam_slug, stage, year, category, marks, total_marks, avg_score, std_dev, source)
VALUES
  ('upsc-cse', 'CSAT Qualifying', '2025', 'General', 66, 200, 0, 0, 'UPSC official 33% qualifying threshold')
ON CONFLICT DO NOTHING;
