-- All JKSSB exams use −0.25 negative marking per wrong answer.
-- This updates all existing JKSSB papers and mocks that were left at 0.

UPDATE vaultcore.papers
SET negative_marking = 0.25
WHERE exam_slug = 'jkssb' AND negative_marking = 0;

UPDATE vaultcore.mocks
SET negative_marking = 0.25
WHERE exam_slug = 'jkssb' AND negative_marking = 0;
