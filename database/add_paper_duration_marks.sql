-- Add duration_minutes and max_marks to papers table
ALTER TABLE vaultcore.papers
  ADD COLUMN IF NOT EXISTS duration_minutes integer NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS max_marks integer NOT NULL DEFAULT 0;

-- Set UPSC CSE Prelims GS1: 3 hours, 200 marks, fix negative marking to 0.67 (1/3 of 2)
UPDATE vaultcore.papers
SET
  duration_minutes = 180,
  max_marks        = 200,
  negative_marking = 0.67
WHERE slug = 'upsc-cse-prelims-2025-gs1';
