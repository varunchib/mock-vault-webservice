-- Sub-topic tags for JKSSB Junior Assistant PYQ questions
-- Run once after jkssb_junior_assistant_pyq.sql

-- English sub-topics
UPDATE vaultcore.questions SET tags = '["Sentence Arrangement"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-1';
UPDATE vaultcore.questions SET tags = '["Error Spotting"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-2';
UPDATE vaultcore.questions SET tags = '["Narration"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-3';
UPDATE vaultcore.questions SET tags = '["Modals"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-4';
UPDATE vaultcore.questions SET tags = '["Articles"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-5';
UPDATE vaultcore.questions SET tags = '["Reading Comprehension","Idioms & Phrases"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-6';
UPDATE vaultcore.questions SET tags = '["Reading Comprehension"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-7';
UPDATE vaultcore.questions SET tags = '["Reading Comprehension"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-8';
UPDATE vaultcore.questions SET tags = '["Punctuation"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-9';
UPDATE vaultcore.questions SET tags = '["Synonyms & Antonyms"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-10';
UPDATE vaultcore.questions SET tags = '["Synonyms & Antonyms"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-11';
UPDATE vaultcore.questions SET tags = '["Idioms & Phrases"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-12';
UPDATE vaultcore.questions SET tags = '["Prepositions"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-13';
UPDATE vaultcore.questions SET tags = '["Prepositions"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-14';
UPDATE vaultcore.questions SET tags = '["Voice"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-15';

-- Quantitative Aptitude
UPDATE vaultcore.questions SET tags = '["Number Series"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-16';
UPDATE vaultcore.questions SET tags = '["Number Series"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-17';

-- Computer Awareness sub-topics
UPDATE vaultcore.questions SET tags = '["Computer Fundamentals"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-18';
UPDATE vaultcore.questions SET tags = '["Computer History"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-19';
UPDATE vaultcore.questions SET tags = '["Internet & E-Commerce"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-20';
UPDATE vaultcore.questions SET tags = '["Internet & E-Commerce"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-21';
UPDATE vaultcore.questions SET tags = '["Computer Generations"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-22';
UPDATE vaultcore.questions SET tags = '["Operating Systems"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-23';
UPDATE vaultcore.questions SET tags = '["Computer Hardware"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-24';
UPDATE vaultcore.questions SET tags = '["Computer Hardware"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-25';
UPDATE vaultcore.questions SET tags = '["Operating Systems"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-26';
UPDATE vaultcore.questions SET tags = '["MS Office"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-27';
UPDATE vaultcore.questions SET tags = '["MS Office"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-28';
UPDATE vaultcore.questions SET tags = '["MS Office"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-29';
UPDATE vaultcore.questions SET tags = '["MS Office"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-30';
UPDATE vaultcore.questions SET tags = '["Internet & Email"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-31';

-- English reading comprehension (Q32–36)
UPDATE vaultcore.questions SET tags = '["Reading Comprehension"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-32',
  'jkssb-junior-assistant-pyq-33',
  'jkssb-junior-assistant-pyq-34',
  'jkssb-junior-assistant-pyq-35',
  'jkssb-junior-assistant-pyq-36'
);

-- General Knowledge sub-topics
UPDATE vaultcore.questions SET tags = '["History"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-37';
UPDATE vaultcore.questions SET tags = '["Indian Tribes"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-38';
UPDATE vaultcore.questions SET tags = '["Indian Geography"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-41',
  'jkssb-junior-assistant-pyq-42',
  'jkssb-junior-assistant-pyq-43',
  'jkssb-junior-assistant-pyq-46'
);

-- J&K GK sub-topics
UPDATE vaultcore.questions SET tags = '["J&K Projects"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-39',
  'jkssb-junior-assistant-pyq-40'
);
UPDATE vaultcore.questions SET tags = '["J&K Geography"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-44',
  'jkssb-junior-assistant-pyq-45',
  'jkssb-junior-assistant-pyq-47',
  'jkssb-junior-assistant-pyq-51',
  'jkssb-junior-assistant-pyq-53'
);
UPDATE vaultcore.questions SET tags = '["J&K Arts & Culture"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-48',
  'jkssb-junior-assistant-pyq-49'
);
UPDATE vaultcore.questions SET tags = '["J&K Languages"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-50';
UPDATE vaultcore.questions SET tags = '["J&K History"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-52',
  'jkssb-junior-assistant-pyq-56'
);
UPDATE vaultcore.questions SET tags = '["J&K Infrastructure"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-54';
UPDATE vaultcore.questions SET tags = '["J&K Economy"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-55';

-- Mathematics sub-topics
UPDATE vaultcore.questions SET tags = '["Number System"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-57',
  'jkssb-junior-assistant-pyq-58'
);
UPDATE vaultcore.questions SET tags = '["Percentage"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-59',
  'jkssb-junior-assistant-pyq-60'
);
UPDATE vaultcore.questions SET tags = '["Averages"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-61',
  'jkssb-junior-assistant-pyq-62',
  'jkssb-junior-assistant-pyq-63'
);
UPDATE vaultcore.questions SET tags = '["Profit & Loss"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-64',
  'jkssb-junior-assistant-pyq-65',
  'jkssb-junior-assistant-pyq-66'
);

-- Reasoning sub-topics
UPDATE vaultcore.questions SET tags = '["Direction Sense"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-67',
  'jkssb-junior-assistant-pyq-68',
  'jkssb-junior-assistant-pyq-69'
);
UPDATE vaultcore.questions SET tags = '["Coding-Decoding"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-70',
  'jkssb-junior-assistant-pyq-71'
);
UPDATE vaultcore.questions SET tags = '["Blood Relations"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-72',
  'jkssb-junior-assistant-pyq-73',
  'jkssb-junior-assistant-pyq-74'
);

-- Computer Awareness (Q75–80)
UPDATE vaultcore.questions SET tags = '["Computer Hardware"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-75';
UPDATE vaultcore.questions SET tags = '["Internet & Email"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-76';
UPDATE vaultcore.questions SET tags = '["MS Office"]'::jsonb WHERE slug IN (
  'jkssb-junior-assistant-pyq-77',
  'jkssb-junior-assistant-pyq-78',
  'jkssb-junior-assistant-pyq-80'
);
UPDATE vaultcore.questions SET tags = '["Computer Networks"]'::jsonb WHERE slug = 'jkssb-junior-assistant-pyq-79';

-- Update JKSSB exam subjects to include all subjects present in its questions
UPDATE vaultcore.exams
SET subjects = '["English","Computer Awareness","Mathematics","Quantitative Aptitude","Reasoning","General Knowledge","J&K GK"]'::jsonb
WHERE slug = 'jkssb';
