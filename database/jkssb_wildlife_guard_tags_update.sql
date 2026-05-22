-- Sub-topic tags for JKSSB Wildlife Guard 10 May 2026 questions

-- Maths sub-topics
UPDATE vaultcore.questions SET tags = '["Probability"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (1,2,20,21);
UPDATE vaultcore.questions SET tags = '["Ratio & Proportion"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (3,4,5,11);
UPDATE vaultcore.questions SET tags = '["Ages"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (6,16,17);
UPDATE vaultcore.questions SET tags = '["HCF & LCM"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (7,8,10);
UPDATE vaultcore.questions SET tags = '["Percentage"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (9);
UPDATE vaultcore.questions SET tags = '["Speed, Distance & Time"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (12,13,14,15);
UPDATE vaultcore.questions SET tags = '["Work & Time"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (18,19);
UPDATE vaultcore.questions SET tags = '["Averages"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (22,23,24);
UPDATE vaultcore.questions SET tags = '["Mensuration"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (25);

-- Reasoning sub-topics
UPDATE vaultcore.questions SET tags = '["Direction Sense"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (26,29,30,50);
UPDATE vaultcore.questions SET tags = '["Number Series"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (27,32,45,46,47,48,49);
UPDATE vaultcore.questions SET tags = '["Analogy"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (28,31);
UPDATE vaultcore.questions SET tags = '["Coding-Decoding"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (33,34,35,36,37,40);
UPDATE vaultcore.questions SET tags = '["Syllogism"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (38,39);
UPDATE vaultcore.questions SET tags = '["Blood Relations"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (41,42,43,44);

-- English sub-topics
UPDATE vaultcore.questions SET tags = '["Reading Comprehension"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (51,52,53);
UPDATE vaultcore.questions SET tags = '["Articles"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (54,55,56);
UPDATE vaultcore.questions SET tags = '["Synonyms & Antonyms"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (57,58,59,60,72);
UPDATE vaultcore.questions SET tags = '["Prepositions"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (61,62,63);
UPDATE vaultcore.questions SET tags = '["Grammar"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (64,65,66,67,68,69,74,75);
UPDATE vaultcore.questions SET tags = '["Spelling"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (70,71);
UPDATE vaultcore.questions SET tags = '["Sentence Arrangement"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (73);

-- General Knowledge sub-topics
UPDATE vaultcore.questions SET tags = '["Current Affairs"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (76,77);
UPDATE vaultcore.questions SET tags = '["History"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (78,80,81,82);
UPDATE vaultcore.questions SET tags = '["Literature"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (79);
UPDATE vaultcore.questions SET tags = '["Indian Geography"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (83,84);
UPDATE vaultcore.questions SET tags = '["Indian Polity"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (85,100);
UPDATE vaultcore.questions SET tags = '["Science"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (86,87,88,89,90);

-- J&K Studies sub-topics
UPDATE vaultcore.questions SET tags = '["J&K Geography"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (91,92,93);
UPDATE vaultcore.questions SET tags = '["J&K Arts & Culture"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (94);
UPDATE vaultcore.questions SET tags = '["J&K History"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (95,96,97,98,99);

-- Wildlife & Ecology sub-topics
UPDATE vaultcore.questions SET tags = '["Biodiversity"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (101,105,106,107,108);
UPDATE vaultcore.questions SET tags = '["Forest Types & Cover"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (102,103,104);
UPDATE vaultcore.questions SET tags = '["IUCN & Conservation Status"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (109,110,111);
UPDATE vaultcore.questions SET tags = '["Biosphere Reserves"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (112);
UPDATE vaultcore.questions SET tags = '["Wildlife Laws"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (113,114);
UPDATE vaultcore.questions SET tags = '["Tiger Conservation"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (115,116,117);
UPDATE vaultcore.questions SET tags = '["Environment & Ecology"]'::jsonb
WHERE paper_slug = 'jkssb-wildlife-guard-2026-may-10' AND question_no::INTEGER IN (118,119,120);

-- Fix JKSSB Junior Assistant PYQ date (taken April 19, 2026)
UPDATE vaultcore.papers
SET year = '2026', shift = 'April 19, 2026', updated_at = CURRENT_TIMESTAMP
WHERE slug = 'jkssb-junior-assistant-pyq';

UPDATE vaultcore.questions
SET year = '2026', updated_at = CURRENT_TIMESTAMP
WHERE paper_slug = 'jkssb-junior-assistant-pyq';
