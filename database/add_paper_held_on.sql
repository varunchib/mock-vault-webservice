-- Add held_on date column to papers for date-based sorting

ALTER TABLE vaultcore.papers
  ADD COLUMN IF NOT EXISTS held_on date;

-- UPSC CSE Prelims 2025 GS1 — held 25 May 2025
UPDATE vaultcore.papers SET held_on = '2025-05-25' WHERE slug = 'upsc-cse-prelims-2025-gs1';

-- JKPSC JKCCE Prelims 2025 GS1 Set B — held 11 May 2025
UPDATE vaultcore.papers SET held_on = '2025-05-11' WHERE slug = 'jkpsc-jkcce-prelims-2025-gs1-set-b';
