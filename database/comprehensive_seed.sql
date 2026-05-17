-- ============================================================
--  MockVault / PYQVault  —  Comprehensive Seed
--  Run:  psql -U postgres -d superlord -f database/comprehensive_seed.sql
-- ============================================================

-- ── 1. EXAMS ─────────────────────────────────────────────────

INSERT INTO vaultcore.exams (slug, name, short_name, category, icon, total_questions, papers, mocks, description, popular_years, subjects)
VALUES
  ('upsc-cse',    'UPSC Civil Services Examination',              'UPSC CSE',    'Central',     '🏛️', 2400, 12, 8,  'India''s toughest exam — UPSC Prelims and Mains PYQs with full explanations, topic filters, and free mock tests.', '["2024","2023","2022","2021","2020"]', '["Polity","History","Geography","Economy","Environment","Science & Technology","CSAT"]'),
  ('ssc-cgl',     'SSC Combined Graduate Level',                  'SSC CGL',     'Central',     '📋', 3600, 18, 12, 'SSC CGL Tier 1 & 2 PYQs across all shifts — reasoning, quant, English, and GK with model answers.', '["2024","2023","2022","2021","2020"]', '["Quantitative Aptitude","General Intelligence & Reasoning","English Language","General Awareness"]'),
  ('ssc-chsl',    'SSC Combined Higher Secondary Level',          'SSC CHSL',    'Central',     '📄', 2400, 14, 8,  'SSC CHSL Tier 1 & 2 previous year papers with full solutions — English, reasoning, quant, and GK.', '["2024","2023","2022","2021"]', '["Quantitative Aptitude","General Intelligence & Reasoning","English Language","General Awareness"]'),
  ('ssc-mts',     'SSC Multi Tasking Staff',                      'SSC MTS',     'Central',     '📝', 1800, 10, 6,  'SSC MTS paper 1 and 2 PYQs with answer keys and explanations for all sections.', '["2024","2023","2022"]', '["Numerical & Mathematical Ability","Reasoning","General Awareness","English"]'),
  ('ibps-po',     'IBPS Probationary Officer',                    'IBPS PO',     'Banking',     '🏦', 2400, 12, 10, 'IBPS PO Prelims and Mains PYQs — reasoning, quant, English, and banking awareness with full solutions.', '["2024","2023","2022","2021"]', '["Reasoning Ability","Quantitative Aptitude","English Language","General Awareness","Computer Aptitude"]'),
  ('ibps-clerk',  'IBPS Clerk',                                   'IBPS Clerk',  'Banking',     '💳', 1800, 10, 8,  'IBPS Clerk Prelims and Mains solved papers with explanations and free mocks.', '["2024","2023","2022","2021"]', '["Reasoning Ability","Quantitative Aptitude","English Language","General Financial Awareness"]'),
  ('sbi-po',      'SBI Probationary Officer',                     'SBI PO',      'Banking',     '🏦', 2000, 10, 8,  'SBI PO Prelims and Mains PYQs with complete solutions, reasoning, DI, English, and GK.', '["2024","2023","2022","2021"]', '["Reasoning & Computer Aptitude","Data Analysis & Interpretation","English Language","General Awareness"]'),
  ('rrb-ntpc',    'RRB Non-Technical Popular Categories',         'RRB NTPC',    'Railways',    '🚂', 2800, 14, 10, 'RRB NTPC Stage 1 & 2 previous year papers — GK, mathematics, general intelligence, and reasoning.', '["2024","2023","2022","2021"]', '["Mathematics","General Intelligence & Reasoning","General Awareness"]'),
  ('rrb-group-d', 'RRB Group D',                                  'RRB Group D', 'Railways',    '🔧', 2000, 10, 8,  'RRB Group D PYQs with solved answers and explanations across all sections and shifts.', '["2024","2023","2022"]', '["Mathematics","General Intelligence & Reasoning","General Science","General Awareness"]'),
  ('ctet',        'Central Teacher Eligibility Test',             'CTET',        'Teaching',    '📚', 1600, 8,  6,  'CTET Paper 1 and Paper 2 previous year questions with explanations for Child Development, Pedagogy, and subject knowledge.', '["2024","2023","2022","2021"]', '["Child Development & Pedagogy","Language I","Language II","Mathematics","Environmental Studies"]'),
  ('jee-main',    'JEE Main',                                     'JEE Main',    'Engineering', '⚙️', 2400, 12, 8,  'JEE Main Physics, Chemistry, and Mathematics previous year questions with detailed solutions.', '["2024","2023","2022","2021"]', '["Physics","Chemistry","Mathematics"]'),
  ('jkssb',       'JKSSB Exams',                                  'JKSSB',       'States',      '📜', 1600, 10, 8,  'JKSSB Finance, Accounts, Patwari, VLW, and other departmental post PYQs with explanations.', '["2024","2023","2022","2021"]', '["Public Finance","Accountancy","J&K General Knowledge","General Intelligence & Reasoning","Quantitative Aptitude"]'),
  ('neet-ug',     'NEET UG',                                      'NEET UG',     'Medical',     '🧬', 2400, 12, 8,  'NEET UG Biology, Physics, and Chemistry previous year questions — chapter-wise and year-wise practice.', '["2024","2023","2022","2021","2020"]', '["Biology","Physics","Chemistry"]')
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, short_name = EXCLUDED.short_name, category = EXCLUDED.category,
  icon = EXCLUDED.icon, total_questions = EXCLUDED.total_questions, papers = EXCLUDED.papers,
  mocks = EXCLUDED.mocks, description = EXCLUDED.description,
  popular_years = EXCLUDED.popular_years, subjects = EXCLUDED.subjects,
  updated_at = CURRENT_TIMESTAMP;


-- ── 2. PAPERS ────────────────────────────────────────────────

INSERT INTO vaultcore.papers (slug, exam_slug, exam_name, title, year, shift, description, questions, subjects)
VALUES
  -- UPSC
  ('upsc-prelims-2023-gs1',      'upsc-cse',    'UPSC CSE',    'UPSC Prelims 2023 GS Paper 1',               '2023', 'GS Paper 1',         'UPSC Prelims 2023 GS Paper 1 with 100 solved questions covering polity, history, geography, economy, and environment.', 100, '["Polity","History","Geography","Economy","Environment"]'),
  ('upsc-prelims-2022-gs1',      'upsc-cse',    'UPSC CSE',    'UPSC Prelims 2022 GS Paper 1',               '2022', 'GS Paper 1',         'UPSC Prelims 2022 GS Paper 1 solved with topic-wise coverage.', 100, '["Polity","History","Geography","Economy","Environment","Science & Technology"]'),
  ('upsc-prelims-2024-gs1',      'upsc-cse',    'UPSC CSE',    'UPSC Prelims 2024 GS Paper 1',               '2024', 'GS Paper 1',         'UPSC Prelims 2024 GS Paper 1 solved with explanations.', 100, '["Polity","History","Geography","Economy","Environment"]'),
  -- SSC CGL
  ('ssc-cgl-2023-tier1',         'ssc-cgl',     'SSC CGL',     'SSC CGL 2023 Tier 1 Solved',                 '2023', 'Tier 1 All Shifts',  'SSC CGL 2023 Tier 1 all shifts solved papers with explanations.', 200, '["Quantitative Aptitude","General Intelligence & Reasoning","English Language","General Awareness"]'),
  ('ssc-cgl-2024-tier1',         'ssc-cgl',     'SSC CGL',     'SSC CGL 2024 Tier 1 Solved',                 '2024', 'Tier 1 All Shifts',  'SSC CGL 2024 Tier 1 all shifts solved papers with explanations.', 200, '["Quantitative Aptitude","General Intelligence & Reasoning","English Language","General Awareness"]'),
  ('ssc-cgl-2022-tier1',         'ssc-cgl',     'SSC CGL',     'SSC CGL 2022 Tier 1 Solved',                 '2022', 'Tier 1 All Shifts',  'SSC CGL 2022 Tier 1 solved papers.', 200, '["Quantitative Aptitude","General Intelligence & Reasoning","English Language","General Awareness"]'),
  -- SSC CHSL
  ('ssc-chsl-2024-tier1',        'ssc-chsl',    'SSC CHSL',    'SSC CHSL 2024 Tier 1 Solved',                '2024', 'Tier 1',             'SSC CHSL 2024 Tier 1 solved paper with all sections covered.', 100, '["Quantitative Aptitude","General Intelligence & Reasoning","English Language","General Awareness"]'),
  ('ssc-chsl-2023-tier1',        'ssc-chsl',    'SSC CHSL',    'SSC CHSL 2023 Tier 1 Solved',                '2023', 'Tier 1',             'SSC CHSL 2023 Tier 1 solved paper.', 100, '["Quantitative Aptitude","General Intelligence & Reasoning","English Language","General Awareness"]'),
  -- SSC MTS
  ('ssc-mts-2024-paper1',        'ssc-mts',     'SSC MTS',     'SSC MTS 2024 Paper 1 Solved',                '2024', 'Paper 1',            'SSC MTS 2024 Paper 1 with numerical ability, reasoning, and GK.', 90, '["Numerical & Mathematical Ability","Reasoning","General Awareness"]'),
  -- IBPS PO
  ('ibps-po-2024-prelims',       'ibps-po',     'IBPS PO',     'IBPS PO 2024 Prelims Solved',                '2024', 'Prelims',            'IBPS PO 2024 Prelims with reasoning, quantitative aptitude, and English solved.', 100, '["Reasoning Ability","Quantitative Aptitude","English Language"]'),
  ('ibps-po-2023-prelims',       'ibps-po',     'IBPS PO',     'IBPS PO 2023 Prelims Solved',                '2023', 'Prelims',            'IBPS PO 2023 Prelims solved paper.', 100, '["Reasoning Ability","Quantitative Aptitude","English Language"]'),
  ('ibps-po-2024-mains',         'ibps-po',     'IBPS PO',     'IBPS PO 2024 Mains Solved',                  '2024', 'Mains',              'IBPS PO 2024 Mains with banking awareness and data interpretation solved.', 200, '["Reasoning Ability","Quantitative Aptitude","English Language","General Awareness","Computer Aptitude"]'),
  -- IBPS Clerk
  ('ibps-clerk-2024-prelims',    'ibps-clerk',  'IBPS Clerk',  'IBPS Clerk 2024 Prelims Solved',             '2024', 'Prelims',            'IBPS Clerk 2024 Prelims solved paper.', 100, '["Reasoning Ability","Quantitative Aptitude","English Language"]'),
  -- SBI PO
  ('sbi-po-2024-prelims',        'sbi-po',      'SBI PO',      'SBI PO 2024 Prelims Solved',                 '2024', 'Prelims',            'SBI PO 2024 Prelims reasoning, quant, and English solved.', 100, '["Reasoning & Computer Aptitude","Quantitative Aptitude","English Language"]'),
  ('sbi-po-2023-mains',          'sbi-po',      'SBI PO',      'SBI PO 2023 Mains Solved',                   '2023', 'Mains',              'SBI PO 2023 Mains with data analysis and general awareness solved.', 155, '["Reasoning & Computer Aptitude","Data Analysis & Interpretation","English Language","General Awareness"]'),
  -- RRB NTPC
  ('rrb-ntpc-2024-stage1',       'rrb-ntpc',    'RRB NTPC',    'RRB NTPC 2024 Stage 1 Solved',               '2024', 'Stage 1',            'RRB NTPC 2024 Stage 1 GK, mathematics, and reasoning solved.', 100, '["Mathematics","General Intelligence & Reasoning","General Awareness"]'),
  ('rrb-ntpc-2023-stage1',       'rrb-ntpc',    'RRB NTPC',    'RRB NTPC 2023 Stage 1 Solved',               '2023', 'Stage 1',            'RRB NTPC 2023 Stage 1 solved paper.', 100, '["Mathematics","General Intelligence & Reasoning","General Awareness"]'),
  -- RRB Group D
  ('rrb-groupd-2024',            'rrb-group-d', 'RRB Group D', 'RRB Group D 2024 Solved Paper',              '2024', 'Phase I',            'RRB Group D 2024 Phase 1 solved paper.', 100, '["Mathematics","General Intelligence & Reasoning","General Science","General Awareness"]'),
  -- CTET
  ('ctet-2024-paper1',           'ctet',        'CTET',        'CTET December 2024 Paper 1 Solved',          '2024', 'Paper 1 (Class 1-5)','CTET 2024 Paper 1 solved — CDP, Language I, Language II, Mathematics, EVS.', 150, '["Child Development & Pedagogy","Language I","Language II","Mathematics","Environmental Studies"]'),
  ('ctet-2023-paper2',           'ctet',        'CTET',        'CTET July 2023 Paper 2 Solved',              '2023', 'Paper 2 (Class 6-8)','CTET 2023 Paper 2 solved — CDP, Language I & II, and Social Studies.', 150, '["Child Development & Pedagogy","Language I","Language II","Social Studies"]'),
  -- JEE Main
  ('jee-main-2024-jan-s1',       'jee-main',    'JEE Main',    'JEE Main January 2024 Session 1 Solved',     '2024', 'January Session 1',  'JEE Main January 2024 Physics, Chemistry, Mathematics solved.', 90, '["Physics","Chemistry","Mathematics"]'),
  ('jee-main-2024-apr-s1',       'jee-main',    'JEE Main',    'JEE Main April 2024 Session 1 Solved',       '2024', 'April Session 1',    'JEE Main April 2024 solved paper.', 90, '["Physics","Chemistry","Mathematics"]'),
  -- JKSSB
  ('jkssb-finance-2024',         'jkssb',       'JKSSB',       'JKSSB Finance Accounts 2024 Solved Paper',   '2024', 'Finance Accounts',   'JKSSB Finance Accounts 2024 paper with full solutions.', 150, '["Public Finance","Accountancy","Budget & Taxation","General Intelligence & Reasoning"]'),
  ('jkssb-patwari-2024',         'jkssb',       'JKSSB',       'JKSSB Patwari 2024 Solved Paper',            '2024', 'Patwari',            'JKSSB Patwari 2024 paper solved.', 100, '["Revenue Laws","Land Records","J&K General Knowledge","Quantitative Aptitude"]'),
  -- NEET
  ('neet-2024',                  'neet-ug',     'NEET UG',     'NEET UG 2024 Solved Paper',                  '2024', 'Phase 1',            'NEET UG 2024 Biology, Physics, and Chemistry full solved paper.', 200, '["Biology","Physics","Chemistry"]'),
  ('neet-2023',                  'neet-ug',     'NEET UG',     'NEET UG 2023 Solved Paper',                  '2023', 'Phase 1',            'NEET UG 2023 solved paper with explanations.', 200, '["Biology","Physics","Chemistry"]')
ON CONFLICT (slug) DO UPDATE SET
  exam_slug = EXCLUDED.exam_slug, exam_name = EXCLUDED.exam_name, title = EXCLUDED.title,
  year = EXCLUDED.year, shift = EXCLUDED.shift, description = EXCLUDED.description,
  questions = EXCLUDED.questions, subjects = EXCLUDED.subjects, updated_at = CURRENT_TIMESTAMP;


-- ── 3. QUESTIONS (Paper-linked) ───────────────────────────────

INSERT INTO vaultcore.questions (slug, exam_slug, paper_slug, mock_slug, exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags)
VALUES

-- UPSC 2023 GS1
('upsc-2023-gs1-q1','upsc-cse','upsc-prelims-2023-gs1',NULL,'UPSC CSE','2023','GS Paper 1','Polity','1',
 'Which of the following is a feature of the Parliamentary form of government?',
 '[{"key":"A","text":"Separation of powers between executive and legislature"},{"key":"B","text":"Dual executive with real power in the President"},{"key":"C","text":"Executive is responsible to the legislature"},{"key":"D","text":"Fixed tenure of the executive"}]',
 'C','Executive is responsible to the legislature',
 'In parliamentary form of government, the Council of Ministers (executive) is collectively responsible to the Lower House of Parliament. This is the cardinal principle distinguishing it from presidential systems.','["Polity","Parliamentary system","UPSC Prelims"]'),

('upsc-2023-gs1-q2','upsc-cse','upsc-prelims-2023-gs1',NULL,'UPSC CSE','2023','GS Paper 1','History','2',
 'The concept of "Basic Structure" of the Constitution was propounded in which landmark case?',
 '[{"key":"A","text":"A.K. Gopalan vs State of Madras"},{"key":"B","text":"Kesavananda Bharati vs State of Kerala"},{"key":"C","text":"Maneka Gandhi vs Union of India"},{"key":"D","text":"Minerva Mills vs Union of India"}]',
 'B','Kesavananda Bharati vs State of Kerala',
 'In the 1973 Kesavananda Bharati case, the Supreme Court by a 7-6 majority held that Parliament can amend any part of the Constitution but cannot alter its "basic structure". This doctrine limits Parliament''s amending power.','["Constitutional law","Basic structure","UPSC Prelims"]'),

('upsc-2023-gs1-q3','upsc-cse','upsc-prelims-2023-gs1',NULL,'UPSC CSE','2023','GS Paper 1','Geography','3',
 'Which river system drains the Deccan Plateau towards the east and empties into the Bay of Bengal?',
 '[{"key":"A","text":"Narmada and Tapi"},{"key":"B","text":"Krishna and Cauvery"},{"key":"C","text":"Luni and Sabarmati"},{"key":"D","text":"Mahanadi and Godavari"}]',
 'B','Krishna and Cauvery',
 'Krishna and Cauvery are east-flowing peninsular rivers draining the Deccan Plateau and emptying into the Bay of Bengal. Narmada and Tapi flow westwards into the Arabian Sea, while Luni drains into the Rann of Kutch.','["Indian geography","River systems","UPSC Prelims"]'),

('upsc-2023-gs1-q4','upsc-cse','upsc-prelims-2023-gs1',NULL,'UPSC CSE','2023','GS Paper 1','Economy','4',
 'Which of the following is NOT a component of India''s Gross Domestic Product (GDP)?',
 '[{"key":"A","text":"Government expenditure on goods and services"},{"key":"B","text":"Net exports of goods and services"},{"key":"C","text":"Remittances received from abroad"},{"key":"D","text":"Private final consumption expenditure"}]',
 'C','Remittances received from abroad',
 'GDP is calculated as C + I + G + (X-M). Remittances from abroad are counted in Gross National Income (GNI/GNP) not GDP, since GDP measures production within the domestic territory regardless of the nationality of the producer.','["Indian economy","National income","UPSC Prelims"]'),

('upsc-2023-gs1-q5','upsc-cse','upsc-prelims-2023-gs1',NULL,'UPSC CSE','2023','GS Paper 1','Environment','5',
 'Which greenhouse gas has the highest Global Warming Potential (GWP) over a 100-year period?',
 '[{"key":"A","text":"Carbon dioxide (CO₂)"},{"key":"B","text":"Methane (CH₄)"},{"key":"C","text":"Nitrous oxide (N₂O)"},{"key":"D","text":"Sulphur hexafluoride (SF₆)"}]',
 'D','Sulphur hexafluoride (SF₆)',
 'SF₆ has a GWP of about 23,500 over 100 years, making it the most potent greenhouse gas listed. CO₂ has GWP of 1, CH₄ around 25, and N₂O around 298. SF₆ is used in electrical equipment.','["Environment","Climate change","UPSC Prelims"]'),

-- SSC CGL 2023
('ssc-cgl-2023-q1','ssc-cgl','ssc-cgl-2023-tier1',NULL,'SSC CGL','2023','Tier 1 Reasoning','General Intelligence & Reasoning','1',
 'If FRIEND is coded as GSJFOE, how is CANDLE coded?',
 '[{"key":"A","text":"DBOELF"},{"key":"B","text":"DBOEMF"},{"key":"C","text":"DBOELG"},{"key":"D","text":"DBONDM"}]',
 'B','DBOEMF',
 'Each letter is shifted forward by 1 in the alphabet: C→D, A→B, N→O, D→E, L→M, E→F. So CANDLE = DBOEMF.','["Coding-Decoding","Reasoning","SSC CGL"]'),

('ssc-cgl-2023-q2','ssc-cgl','ssc-cgl-2023-tier1',NULL,'SSC CGL','2023','Tier 1 Quant','Quantitative Aptitude','2',
 'A train 150 m long passes a pole in 15 seconds. How long will it take to pass a platform 300 m long?',
 '[{"key":"A","text":"30 seconds"},{"key":"B","text":"35 seconds"},{"key":"C","text":"40 seconds"},{"key":"D","text":"45 seconds"}]',
 'D','45 seconds',
 'Speed of train = 150/15 = 10 m/s. Distance to cover for platform = 150 + 300 = 450 m. Time = 450/10 = 45 seconds.','["Time & Distance","Trains","SSC CGL","Quantitative Aptitude"]'),

('ssc-cgl-2023-q3','ssc-cgl','ssc-cgl-2023-tier1',NULL,'SSC CGL','2023','Tier 1 GK','General Awareness','3',
 'The "Operation Smile" launched by the Government of India is related to:',
 '[{"key":"A","text":"Rescue of missing and trafficked children"},{"key":"B","text":"Free cleft lip surgery for underprivileged"},{"key":"C","text":"Anti-drug awareness in schools"},{"key":"D","text":"Digital literacy among rural women"}]',
 'A','Rescue of missing and trafficked children',
 'Operation Smile is a national operation launched by the Ministry of Home Affairs to rescue and rehabilitate missing and trafficked children. It has been conducted periodically across India.','["Government schemes","Current affairs","SSC CGL"]'),

('ssc-cgl-2023-q4','ssc-cgl','ssc-cgl-2023-tier1',NULL,'SSC CGL','2023','Tier 1 English','English Language','4',
 'Select the most appropriate synonym of the word "EPHEMERAL".',
 '[{"key":"A","text":"Permanent"},{"key":"B","text":"Transient"},{"key":"C","text":"Eternal"},{"key":"D","text":"Significant"}]',
 'B','Transient',
 '"Ephemeral" means lasting for a very short time. Its synonym is "transient" (passing quickly). "Permanent" and "eternal" are antonyms. This is a commonly tested vocabulary word in SSC exams.','["Vocabulary","Synonyms","English Language","SSC CGL"]'),

-- IBPS PO 2024
('ibps-po-2024-q1','ibps-po','ibps-po-2024-prelims',NULL,'IBPS PO','2024','Prelims Reasoning','Reasoning Ability','1',
 'In a row of 40 students, Ravi is 15th from the left. What is his position from the right?',
 '[{"key":"A","text":"24th"},{"key":"B","text":"25th"},{"key":"C","text":"26th"},{"key":"D","text":"27th"}]',
 'C','26th',
 'Position from right = Total students − Position from left + 1 = 40 − 15 + 1 = 26.','["Seating arrangement","Reasoning","IBPS PO"]'),

('ibps-po-2024-q2','ibps-po','ibps-po-2024-prelims',NULL,'IBPS PO','2024','Prelims Quant','Quantitative Aptitude','2',
 'Simple interest on Rs 6,000 at 8% per annum for 3 years is:',
 '[{"key":"A","text":"Rs 1,440"},{"key":"B","text":"Rs 1,480"},{"key":"C","text":"Rs 1,520"},{"key":"D","text":"Rs 1,560"}]',
 'A','Rs 1,440',
 'SI = P × R × T / 100 = 6000 × 8 × 3 / 100 = 1440.','["Simple Interest","Quantitative Aptitude","IBPS PO"]'),

('ibps-po-2024-q3','ibps-po','ibps-po-2024-prelims',NULL,'IBPS PO','2024','Prelims English','English Language','3',
 'Choose the word that best fills the blank: The government decided to _____ the old law.',
 '[{"key":"A","text":"repeal"},{"key":"B","text":"reveal"},{"key":"C","text":"repel"},{"key":"D","text":"appeal"}]',
 'A','repeal',
 '"Repeal" means to formally cancel a law. "Reveal" means to disclose, "repel" means to drive away, and "appeal" means to make a plea. In banking exams, legal and formal vocabulary is frequently tested.','["Fill in the blanks","English Language","IBPS PO"]'),

-- RRB NTPC 2024
('rrb-ntpc-2024-q1','rrb-ntpc','rrb-ntpc-2024-stage1',NULL,'RRB NTPC','2024','Stage 1 GK','General Awareness','1',
 'Which is the longest railway platform in the world?',
 '[{"key":"A","text":"Gorakhpur, India"},{"key":"B","text":"Kollam, India"},{"key":"C","text":"Kharagpur, India"},{"key":"D","text":"Hubli, India"}]',
 'D','Hubli, India',
 'As of 2023, Shree Siddharoodha Swamiji Hubballi Station (Hubli) holds the record for the world''s longest railway platform at 1,505 metres. Gorakhpur previously held the record.','["Indian Railways","GK","RRB NTPC"]'),

('rrb-ntpc-2024-q2','rrb-ntpc','rrb-ntpc-2024-stage1',NULL,'RRB NTPC','2024','Stage 1 Maths','Mathematics','2',
 'The LCM of 12, 15, and 20 is:',
 '[{"key":"A","text":"60"},{"key":"B","text":"120"},{"key":"C","text":"180"},{"key":"D","text":"240"}]',
 'A','60',
 'Prime factorisation: 12 = 2²×3, 15 = 3×5, 20 = 2²×5. LCM = 2²×3×5 = 60.','["LCM & HCF","Mathematics","RRB NTPC"]'),

-- NEET 2024
('neet-2024-q1','neet-ug','neet-2024',NULL,'NEET UG','2024','Phase 1 Biology','Biology','1',
 'Which of the following is the site of translation in a cell?',
 '[{"key":"A","text":"Nucleus"},{"key":"B","text":"Ribosome"},{"key":"C","text":"Mitochondria"},{"key":"D","text":"Endoplasmic reticulum"}]',
 'B','Ribosome',
 'Translation (protein synthesis from mRNA) occurs at ribosomes. Ribosomes can be free in the cytoplasm or attached to the rough endoplasmic reticulum. Transcription (DNA → mRNA) occurs in the nucleus.','["Molecular biology","Cell biology","NEET UG"]'),

('neet-2024-q2','neet-ug','neet-2024',NULL,'NEET UG','2024','Phase 1 Physics','Physics','2',
 'A body of mass 2 kg is moving with a velocity of 10 m/s. Its kinetic energy is:',
 '[{"key":"A","text":"20 J"},{"key":"B","text":"50 J"},{"key":"C","text":"100 J"},{"key":"D","text":"200 J"}]',
 'C','100 J',
 'KE = ½mv² = ½ × 2 × 10² = ½ × 2 × 100 = 100 J.','["Kinetic energy","Mechanics","Physics","NEET UG"]'),

('neet-2024-q3','neet-ug','neet-2024',NULL,'NEET UG','2024','Phase 1 Chemistry','Chemistry','3',
 'Which of the following is the correct electronic configuration of Carbon (Z=6)?',
 '[{"key":"A","text":"1s² 2s² 2p²"},{"key":"B","text":"1s² 2s¹ 2p³"},{"key":"C","text":"1s² 2s² 2p¹ 3s¹"},{"key":"D","text":"1s¹ 2s² 2p³"}]',
 'A','1s² 2s² 2p²',
 'Carbon has atomic number 6. Filling orbitals in order: 1s² (2 electrons), 2s² (2 electrons), 2p² (2 electrons). Total = 6 electrons. Configuration is 1s² 2s² 2p².','["Electronic configuration","Atomic structure","Chemistry","NEET UG"]'),

-- JKSSB Finance 2024
('jkssb-2024-q1','jkssb','jkssb-finance-2024',NULL,'JKSSB','2024','Finance Accounts','Public Finance','1',
 'The Consolidated Fund of India is governed by which Article of the Constitution?',
 '[{"key":"A","text":"Article 265"},{"key":"B","text":"Article 266"},{"key":"C","text":"Article 267"},{"key":"D","text":"Article 268"}]',
 'B','Article 266',
 'Article 266 defines the Consolidated Fund of India and Consolidated Funds of States. No money can be appropriated from the Consolidated Fund except in accordance with law and after a vote in Parliament.','["Constitutional provisions","Public Finance","JKSSB"]'),

('jkssb-2024-q2','jkssb','jkssb-finance-2024',NULL,'JKSSB','2024','Finance Accounts','Accountancy','2',
 'In double entry bookkeeping, which of the following is correct?',
 '[{"key":"A","text":"Debit all expenses and losses; Credit all incomes and gains"},{"key":"B","text":"Debit what comes in; Credit what goes out"},{"key":"C","text":"Both A and B"},{"key":"D","text":"Neither A nor B"}]',
 'C','Both A and B',
 'Double entry accounting follows two rules: (1) Debit what comes in, Credit what goes out — for real accounts; (2) Debit all expenses and losses, Credit all incomes and gains — for nominal accounts. Both are fundamental principles.','["Accounting principles","Double entry","JKSSB"]'),

-- CTET 2024
('ctet-2024-q1','ctet','ctet-2024-paper1',NULL,'CTET','2024','Paper 1 CDP','Child Development & Pedagogy','1',
 'According to Jean Piaget, which stage of cognitive development is characterised by object permanence?',
 '[{"key":"A","text":"Sensorimotor stage (0–2 years)"},{"key":"B","text":"Pre-operational stage (2–7 years)"},{"key":"C","text":"Concrete operational stage (7–11 years)"},{"key":"D","text":"Formal operational stage (12+ years)"}]',
 'A','Sensorimotor stage (0–2 years)',
 'Object permanence — understanding that objects exist even when not visible — develops during the Sensorimotor stage (0–2 years). This is a key milestone in Piaget''s theory of cognitive development.','["Piaget","Cognitive development","Child Development","CTET"]'),

('ctet-2024-q2','ctet','ctet-2024-paper1',NULL,'CTET','2024','Paper 1 Maths','Mathematics','2',
 'A student can skip count by 5s. Which competency does this reflect?',
 '[{"key":"A","text":"Number sense and operations"},{"key":"B","text":"Spatial reasoning"},{"key":"C","text":"Data handling"},{"key":"D","text":"Measurement"}]',
 'A','Number sense and operations',
 'Skip counting develops number sense and understanding of multiplicative relationships. It is a foundational numeracy skill classified under number sense and operations in the NCF framework.','["Mathematics pedagogy","Number sense","CTET"]'),

-- JEE Main 2024
('jee-2024-q1','jee-main','jee-main-2024-jan-s1',NULL,'JEE Main','2024','January Physics','Physics','1',
 'A ball is dropped from a height of 80 m. Taking g = 10 m/s², the velocity just before hitting the ground is:',
 '[{"key":"A","text":"20 m/s"},{"key":"B","text":"30 m/s"},{"key":"C","text":"40 m/s"},{"key":"D","text":"50 m/s"}]',
 'C','40 m/s',
 'Using v² = u² + 2gh = 0 + 2 × 10 × 80 = 1600. v = √1600 = 40 m/s.','["Kinematics","Mechanics","Physics","JEE Main"]'),

('jee-2024-q2','jee-main','jee-main-2024-jan-s1',NULL,'JEE Main','2024','January Chemistry','Chemistry','2',
 'The IUPAC name of CH₃-CH₂-CHO is:',
 '[{"key":"A","text":"Propan-1-ol"},{"key":"B","text":"Propanal"},{"key":"C","text":"Propanone"},{"key":"D","text":"Propanoic acid"}]',
 'B','Propanal',
 'CHO is the aldehyde functional group. The compound CH₃-CH₂-CHO has 3 carbons. The IUPAC name for a 3-carbon aldehyde is Propanal.','["Organic chemistry","IUPAC nomenclature","Chemistry","JEE Main"]'),

('jee-2024-q3','jee-main','jee-main-2024-jan-s1',NULL,'JEE Main','2024','January Maths','Mathematics','3',
 'The value of sin 30° × cos 60° + cos 30° × sin 60° is:',
 '[{"key":"A","text":"0"},{"key":"B","text":"1/2"},{"key":"C","text":"√3/2"},{"key":"D","text":"1"}]',
 'D','1',
 'sin 30° × cos 60° + cos 30° × sin 60° = sin(30° + 60°) = sin 90° = 1. This uses the sine addition formula sin(A+B) = sinA cosB + cosA sinB.','["Trigonometry","Mathematics","JEE Main"]')

ON CONFLICT (slug) DO UPDATE SET
  exam_slug = EXCLUDED.exam_slug, paper_slug = EXCLUDED.paper_slug,
  exam_name = EXCLUDED.exam_name, year = EXCLUDED.year, paper = EXCLUDED.paper,
  subject = EXCLUDED.subject, question_no = EXCLUDED.question_no,
  question = EXCLUDED.question, options = EXCLUDED.options,
  answer_key = EXCLUDED.answer_key, answer = EXCLUDED.answer,
  explanation = EXCLUDED.explanation, tags = EXCLUDED.tags,
  updated_at = CURRENT_TIMESTAMP;


-- ── 4. MOCKS ─────────────────────────────────────────────────

INSERT INTO vaultcore.mocks (slug, exam_slug, exam_name, title, description, questions, duration_minutes, difficulty, is_free, subjects)
VALUES
  -- UPSC
  ('upsc-prelims-mini-mock-1',      'upsc-cse',    'UPSC CSE',    'UPSC Prelims Mini Mock 1',              'Quick 20-question UPSC Prelims mock covering polity, history, and geography.', 20, 25, 'Moderate', TRUE,  '["Polity","History","Geography"]'),
  ('upsc-prelims-full-mock-2026',   'upsc-cse',    'UPSC CSE',    'UPSC Prelims Full Mock 2026',           'Full 100-question UPSC Prelims mock with all GS Paper 1 topics.', 100, 120, 'Advanced', FALSE, '["Polity","History","Geography","Economy","Environment","Science & Technology"]'),
  ('upsc-csat-mini-mock',           'upsc-cse',    'UPSC CSE',    'UPSC CSAT Mini Mock',                   'CSAT Paper 2 mini mock with comprehension, reasoning, and basic numeracy.', 20, 30, 'Beginner', TRUE,  '["CSAT","Comprehension","Reasoning","Numeracy"]'),
  -- SSC CGL
  ('ssc-cgl-tier1-reasoning-mock',  'ssc-cgl',     'SSC CGL',     'SSC CGL Tier 1 Reasoning Sprint',       'Focused reasoning sprint for SSC CGL Tier 1 with 25 previous-year style questions.', 25, 20, 'Beginner', TRUE,  '["General Intelligence & Reasoning"]'),
  ('ssc-cgl-tier1-full-mock',       'ssc-cgl',     'SSC CGL',     'SSC CGL Tier 1 Full Mock',              'Full Tier 1 mock — all 4 sections, 100 questions in 60 minutes.', 100, 60, 'Moderate', FALSE, '["Quantitative Aptitude","General Intelligence & Reasoning","English Language","General Awareness"]'),
  ('ssc-cgl-quant-booster',         'ssc-cgl',     'SSC CGL',     'SSC CGL Quantitative Aptitude Booster', 'Quant-focused mock with arithmetic, algebra, geometry, and DI.', 30, 30, 'Advanced', TRUE,  '["Quantitative Aptitude"]'),
  -- SSC CHSL
  ('ssc-chsl-tier1-mock-1',         'ssc-chsl',    'SSC CHSL',    'SSC CHSL Tier 1 Mock Test 1',           'SSC CHSL Tier 1 mock with all sections — 100 questions in 60 minutes.', 100, 60, 'Moderate', TRUE,  '["Quantitative Aptitude","General Intelligence & Reasoning","English Language","General Awareness"]'),
  ('ssc-chsl-english-mock',         'ssc-chsl',    'SSC CHSL',    'SSC CHSL English Language Mock',        'English-focused mock for SSC CHSL — fill in the blanks, synonyms, and reading.', 25, 20, 'Beginner', TRUE,  '["English Language"]'),
  -- IBPS PO
  ('ibps-po-prelims-mock-1',        'ibps-po',     'IBPS PO',     'IBPS PO Prelims Mock Test 1',           'Complete IBPS PO Prelims mock — reasoning, quant, and English in 60 minutes.', 100, 60, 'Moderate', TRUE,  '["Reasoning Ability","Quantitative Aptitude","English Language"]'),
  ('ibps-po-reasoning-mock',        'ibps-po',     'IBPS PO',     'IBPS PO Reasoning Power Pack',          'Reasoning-only mock with puzzles, seating arrangement, and syllogisms.', 35, 25, 'Advanced', FALSE, '["Reasoning Ability"]'),
  -- IBPS Clerk
  ('ibps-clerk-prelims-mock-1',     'ibps-clerk',  'IBPS Clerk',  'IBPS Clerk Prelims Mock Test 1',        'Full IBPS Clerk Prelims mock — 100 questions in 60 minutes.', 100, 60, 'Beginner', TRUE,  '["Reasoning Ability","Quantitative Aptitude","English Language"]'),
  -- SBI PO
  ('sbi-po-prelims-mock-1',         'sbi-po',      'SBI PO',      'SBI PO Prelims Mock Test 1',            'Complete SBI PO Prelims mock with all sections.', 100, 60, 'Moderate', TRUE,  '["Reasoning & Computer Aptitude","Quantitative Aptitude","English Language"]'),
  -- RRB NTPC
  ('rrb-ntpc-stage1-mock-1',        'rrb-ntpc',    'RRB NTPC',    'RRB NTPC Stage 1 Mock Test 1',          'RRB NTPC Stage 1 full mock — GK, math, and reasoning in 90 minutes.', 100, 90, 'Moderate', TRUE,  '["Mathematics","General Intelligence & Reasoning","General Awareness"]'),
  ('rrb-ntpc-gk-mock',              'rrb-ntpc',    'RRB NTPC',    'RRB NTPC GK Rapid Fire Mock',           'GK-focused rapid fire mock for RRB NTPC — history, science, current affairs.', 40, 30, 'Beginner', TRUE,  '["General Awareness"]'),
  -- RRB Group D
  ('rrb-groupd-mock-1',             'rrb-group-d', 'RRB Group D', 'RRB Group D Full Mock Test 1',          'RRB Group D complete mock — all 4 sections in 90 minutes.', 100, 90, 'Moderate', TRUE,  '["Mathematics","General Intelligence & Reasoning","General Science","General Awareness"]'),
  -- CTET
  ('ctet-paper1-mock-1',            'ctet',        'CTET',        'CTET Paper 1 Full Mock Test',           'CTET Paper 1 complete mock — CDP, languages, mathematics, and EVS.', 150, 150,'Moderate', TRUE,  '["Child Development & Pedagogy","Language I","Language II","Mathematics","Environmental Studies"]'),
  -- JEE Main
  ('jee-main-mock-1',               'jee-main',    'JEE Main',    'JEE Main Full Mock Test 1',             'JEE Main full mock — Physics, Chemistry, and Mathematics in 3 hours.', 90, 180,'Advanced', TRUE,  '["Physics","Chemistry","Mathematics"]'),
  ('jee-main-physics-mock',         'jee-main',    'JEE Main',    'JEE Main Physics Topic Mock',           'Physics-focused JEE Main mock — mechanics, thermodynamics, electrostatics.', 30, 60, 'Moderate', TRUE,  '["Physics"]'),
  -- JKSSB
  ('jkssb-finance-full-mock',       'jkssb',       'JKSSB',       'JKSSB Finance Accounts Full Mock',      'Full-length JKSSB Finance Accounts mock — public finance, accountancy, reasoning.', 100, 120,'Advanced', FALSE, '["Public Finance","Accountancy","General Intelligence & Reasoning","J&K General Knowledge"]'),
  ('jkssb-gk-mini-mock',            'jkssb',       'JKSSB',       'JKSSB J&K GK Mini Mock',               'J&K General Knowledge focused mini mock — history, geography, current affairs.', 25, 20, 'Beginner', TRUE,  '["J&K General Knowledge"]'),
  -- NEET
  ('neet-biology-mock-1',           'neet-ug',     'NEET UG',     'NEET Biology Full Mock',                'NEET Biology mock — Botany and Zoology, 90 questions in 60 minutes.', 90, 60, 'Moderate', TRUE,  '["Biology"]'),
  ('neet-full-mock-1',              'neet-ug',     'NEET UG',     'NEET UG Full Mock Test 1',              'Full NEET UG mock — Biology, Physics, and Chemistry, 200 questions.', 200, 180,'Advanced', FALSE, '["Biology","Physics","Chemistry"]'),
  ('neet-physics-mock',             'neet-ug',     'NEET UG',     'NEET Physics Booster Mock',             'Physics-focused NEET mock — mechanics, thermodynamics, and modern physics.', 45, 40, 'Moderate', TRUE,  '["Physics"]')
ON CONFLICT (slug) DO UPDATE SET
  exam_slug = EXCLUDED.exam_slug, exam_name = EXCLUDED.exam_name, title = EXCLUDED.title,
  description = EXCLUDED.description, questions = EXCLUDED.questions,
  duration_minutes = EXCLUDED.duration_minutes, difficulty = EXCLUDED.difficulty,
  is_free = EXCLUDED.is_free, subjects = EXCLUDED.subjects, updated_at = CURRENT_TIMESTAMP;


-- ── 5. MOCK QUESTIONS (linked via mock_slug) ─────────────────

INSERT INTO vaultcore.questions (slug, exam_slug, paper_slug, mock_slug, exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags)
VALUES

-- UPSC Prelims Mini Mock 1
('upsc-mm1-q1','upsc-cse',NULL,'upsc-prelims-mini-mock-1','UPSC CSE','2026','Prelims Mini Mock 1','Polity','1',
 'The President of India can be removed from office by:',
 '[{"key":"A","text":"A resolution passed by Parliament"},{"key":"B","text":"Impeachment by Parliament"},{"key":"C","text":"A Supreme Court order"},{"key":"D","text":"A no-confidence motion in Lok Sabha"}]',
 'B','Impeachment by Parliament',
 'Article 61 prescribes impeachment as the only method to remove the President of India. The resolution must be passed by a 2/3 majority of the total membership of each House of Parliament.','["Polity","President","UPSC Prelims"]'),

('upsc-mm1-q2','upsc-cse',NULL,'upsc-prelims-mini-mock-1','UPSC CSE','2026','Prelims Mini Mock 1','History','2',
 'The "Doctrine of Lapse" was introduced by which Governor-General?',
 '[{"key":"A","text":"Lord Wellesley"},{"key":"B","text":"Lord Dalhousie"},{"key":"C","text":"Lord Cornwallis"},{"key":"D","text":"Lord Canning"}]',
 'B','Lord Dalhousie',
 'Lord Dalhousie introduced the Doctrine of Lapse (1848–56), under which any princely state whose ruler died without a natural male heir would be annexed by the British East India Company. States like Satara, Jhansi, and Nagpur were annexed under this doctrine.','["Modern History","British India","UPSC Prelims"]'),

('upsc-mm1-q3','upsc-cse',NULL,'upsc-prelims-mini-mock-1','UPSC CSE','2026','Prelims Mini Mock 1','Geography','3',
 'The Tropic of Cancer passes through which of the following states in India?',
 '[{"key":"A","text":"Uttar Pradesh"},{"key":"B","text":"Rajasthan"},{"key":"C","text":"Karnataka"},{"key":"D","text":"Andhra Pradesh"}]',
 'B','Rajasthan',
 'The Tropic of Cancer (23.5°N) passes through 8 Indian states: Gujarat, Rajasthan, Madhya Pradesh, Chhattisgarh, Jharkhand, West Bengal, Tripura, and Mizoram. Uttar Pradesh, Karnataka, and Andhra Pradesh do not lie on the Tropic of Cancer.','["Indian geography","Physical geography","UPSC Prelims"]'),

('upsc-mm1-q4','upsc-cse',NULL,'upsc-prelims-mini-mock-1','UPSC CSE','2026','Prelims Mini Mock 1','Economy','4',
 'Which five-year plan focused on "Growth with Social Justice and Equity"?',
 '[{"key":"A","text":"Eighth Five Year Plan"},{"key":"B","text":"Ninth Five Year Plan"},{"key":"C","text":"Tenth Five Year Plan"},{"key":"D","text":"Eleventh Five Year Plan"}]',
 'D','Eleventh Five Year Plan',
 'The Eleventh Five Year Plan (2007–12) had the theme "Faster and More Inclusive Growth" and focused specifically on growth with social justice and equity, targeting a GDP growth rate of 9% along with inclusive development goals.','["Indian economy","Five Year Plans","UPSC Prelims"]'),

('upsc-mm1-q5','upsc-cse',NULL,'upsc-prelims-mini-mock-1','UPSC CSE','2026','Prelims Mini Mock 1','Environment','5',
 'Project Tiger was launched in India in:',
 '[{"key":"A","text":"1969"},{"key":"B","text":"1973"},{"key":"C","text":"1980"},{"key":"D","text":"1984"}]',
 'B','1973',
 'Project Tiger was launched on 1 April 1973 under Prime Minister Indira Gandhi. It is a centrally sponsored scheme of the Government of India to conserve tigers and their habitat. Jim Corbett National Park was the first tiger reserve.','["Environment","Wildlife conservation","UPSC Prelims"]'),

-- SSC CGL Tier 1 Reasoning Sprint
('ssc-cgl-rs-q1','ssc-cgl',NULL,'ssc-cgl-tier1-reasoning-mock','SSC CGL','2026','Reasoning Sprint','General Intelligence & Reasoning','1',
 'If 2 × 3 = 12, 3 × 4 = 20, then 4 × 5 = ?',
 '[{"key":"A","text":"25"},{"key":"B","text":"28"},{"key":"C","text":"30"},{"key":"D","text":"32"}]',
 'C','30',
 'Pattern: a × b = (a+b) × (smaller of a,b). 2×3=(2+3)×2=10? No — let''s check: 2×3=12=2×3+6? Actually 2×(3+3)=12, 3×(4+4)=24≠20. Try: a×b=a²+a×(b-a)×... Simpler: 2×3=(2+1)×(3+1)=12, 3×4=(3+1)×(4+1)=20, 4×5=(4+1)×(5+1)=30. ✓','["Number series","Reasoning","SSC CGL"]'),

('ssc-cgl-rs-q2','ssc-cgl',NULL,'ssc-cgl-tier1-reasoning-mock','SSC CGL','2026','Reasoning Sprint','General Intelligence & Reasoning','2',
 'Find the odd one out: 4, 9, 16, 25, 35, 49',
 '[{"key":"A","text":"9"},{"key":"B","text":"25"},{"key":"C","text":"35"},{"key":"D","text":"49"}]',
 'C','35',
 'The series consists of perfect squares: 4=2², 9=3², 16=4², 25=5², 49=7². 35 is not a perfect square. Hence 35 is the odd one out.','["Odd one out","Series","Reasoning","SSC CGL"]'),

('ssc-cgl-rs-q3','ssc-cgl',NULL,'ssc-cgl-tier1-reasoning-mock','SSC CGL','2026','Reasoning Sprint','General Intelligence & Reasoning','3',
 'A man walks 5 km North, then 3 km East, then 5 km South. How far is he from the starting point?',
 '[{"key":"A","text":"3 km"},{"key":"B","text":"5 km"},{"key":"C","text":"8 km"},{"key":"D","text":"13 km"}]',
 'A','3 km',
 'After walking 5 km North and 5 km South, the north-south displacement cancels out. He is only 3 km East of his starting point. Distance = 3 km.','["Direction sense","Reasoning","SSC CGL"]'),

-- IBPS PO Prelims Mock 1
('ibps-po-m1-q1','ibps-po',NULL,'ibps-po-prelims-mock-1','IBPS PO','2026','Prelims Mock 1','Reasoning Ability','1',
 'How many meaningful English words can be formed using letters W, A, T, E, R?',
 '[{"key":"A","text":"1"},{"key":"B","text":"2"},{"key":"C","text":"3"},{"key":"D","text":"4 or more"}]',
 'D','4 or more',
 'WATER, TARE, RATE, WARE, TEAR, WEAR, ATER — several meaningful words can be formed from W, A, T, E, R. This tests vocabulary alongside reasoning.','["Word formation","Reasoning","IBPS PO"]'),

('ibps-po-m1-q2','ibps-po',NULL,'ibps-po-prelims-mock-1','IBPS PO','2026','Prelims Mock 1','Quantitative Aptitude','2',
 'A sum doubles itself in 8 years at simple interest. What is the rate of interest per annum?',
 '[{"key":"A","text":"10%"},{"key":"B","text":"12.5%"},{"key":"C","text":"15%"},{"key":"D","text":"20%"}]',
 'B','12.5%',
 'If P doubles, SI = P. SI = P × R × T / 100 → P = P × R × 8 / 100 → R = 100/8 = 12.5% per annum.','["Simple Interest","Quantitative Aptitude","IBPS PO"]'),

('ibps-po-m1-q3','ibps-po',NULL,'ibps-po-prelims-mock-1','IBPS PO','2026','Prelims Mock 1','English Language','3',
 'Select the word closest in meaning to "BENEVOLENT":',
 '[{"key":"A","text":"Malicious"},{"key":"B","text":"Charitable"},{"key":"C","text":"Indifferent"},{"key":"D","text":"Hostile"}]',
 'B','Charitable',
 '"Benevolent" means well-meaning and kindly. Its closest synonym is "Charitable" — generous and kind. Malicious and hostile are antonyms. Frequently tested in bank exams.','["Vocabulary","Synonyms","English Language","IBPS PO"]'),

-- RRB NTPC Stage 1 Mock 1
('rrb-ntpc-m1-q1','rrb-ntpc',NULL,'rrb-ntpc-stage1-mock-1','RRB NTPC','2026','Stage 1 Mock 1','General Awareness','1',
 'Which is the first railway zone established in India?',
 '[{"key":"A","text":"Western Railway"},{"key":"B","text":"Eastern Railway"},{"key":"C","text":"Central Railway"},{"key":"D","text":"Southern Railway"}]',
 'C','Central Railway',
 'Central Railway, with its headquarters in Mumbai (CST), was the first railway zone of India, established in 1951. The first passenger train in India ran from Bombay to Thane in 1853 on what became part of this zone.','["Indian Railways","GK","RRB NTPC"]'),

('rrb-ntpc-m1-q2','rrb-ntpc',NULL,'rrb-ntpc-stage1-mock-1','RRB NTPC','2026','Stage 1 Mock 1','Mathematics','2',
 'If the perimeter of a square is 48 cm, what is its area?',
 '[{"key":"A","text":"100 cm²"},{"key":"B","text":"124 cm²"},{"key":"C","text":"144 cm²"},{"key":"D","text":"169 cm²"}]',
 'C','144 cm²',
 'Perimeter = 4 × side → side = 48/4 = 12 cm. Area = side² = 12² = 144 cm².','["Mensuration","Mathematics","RRB NTPC"]'),

-- NEET Biology Mock 1
('neet-bio-m1-q1','neet-ug',NULL,'neet-biology-mock-1','NEET UG','2026','Biology Mock 1','Biology','1',
 'Which of the following is an example of an incomplete dominant trait?',
 '[{"key":"A","text":"ABO blood groups"},{"key":"B","text":"Flower colour in Mirabilis jalapa"},{"key":"C","text":"Sickle cell anaemia"},{"key":"D","text":"Tongue rolling"}]',
 'B','Flower colour in Mirabilis jalapa',
 'In Mirabilis jalapa (four o''clock plant), crossing red (RR) and white (rr) flowers gives pink (Rr) — neither allele is completely dominant, showing incomplete dominance. ABO blood groups show co-dominance.','["Genetics","Incomplete dominance","Biology","NEET UG"]'),

('neet-bio-m1-q2','neet-ug',NULL,'neet-biology-mock-1','NEET UG','2026','Biology Mock 1','Biology','2',
 'The powerhouse of the cell is:',
 '[{"key":"A","text":"Nucleus"},{"key":"B","text":"Ribosome"},{"key":"C","text":"Mitochondria"},{"key":"D","text":"Golgi apparatus"}]',
 'C','Mitochondria',
 'Mitochondria are called the powerhouse of the cell because they produce ATP through cellular respiration (specifically the Krebs cycle and oxidative phosphorylation). They have their own DNA and ribosomes.','["Cell organelles","Cell biology","Biology","NEET UG"]'),

('neet-bio-m1-q3','neet-ug',NULL,'neet-biology-mock-1','NEET UG','2026','Biology Mock 1','Biology','3',
 'Which hormone is responsible for the fight-or-flight response?',
 '[{"key":"A","text":"Insulin"},{"key":"B","text":"Thyroxine"},{"key":"C","text":"Adrenaline (Epinephrine)"},{"key":"D","text":"Cortisol"}]',
 'C','Adrenaline (Epinephrine)',
 'Adrenaline (epinephrine), secreted by the adrenal medulla, triggers the fight-or-flight response by increasing heart rate, blood pressure, blood glucose, and preparing the body for emergency action.','["Endocrine system","Hormones","Biology","NEET UG"]'),

-- JEE Main Full Mock 1
('jee-m1-q1','jee-main',NULL,'jee-main-mock-1','JEE Main','2026','Full Mock 1','Physics','1',
 'Which of the following has the highest electrical conductivity?',
 '[{"key":"A","text":"Copper"},{"key":"B","text":"Silver"},{"key":"C","text":"Gold"},{"key":"D","text":"Aluminium"}]',
 'B','Silver',
 'Silver has the highest electrical conductivity of all metals (6.30 × 10⁷ S/m), followed by copper (5.96 × 10⁷ S/m). However, copper is more commonly used in wiring due to its lower cost.','["Electrical properties","Conductivity","Physics","JEE Main"]'),

('jee-m1-q2','jee-main',NULL,'jee-main-mock-1','JEE Main','2026','Full Mock 1','Chemistry','2',
 'Which bond is present in the water molecule (H₂O)?',
 '[{"key":"A","text":"Ionic bond"},{"key":"B","text":"Covalent bond"},{"key":"C","text":"Metallic bond"},{"key":"D","text":"Hydrogen bond between atoms within molecule"}]',
 'B','Covalent bond',
 'Water (H₂O) has polar covalent bonds between H and O atoms. Each O-H bond is formed by sharing electrons. Hydrogen bonds exist between water molecules (intermolecular) not within a single molecule.','["Chemical bonding","Covalent bond","Chemistry","JEE Main"]'),

('jee-m1-q3','jee-main',NULL,'jee-main-mock-1','JEE Main','2026','Full Mock 1','Mathematics','3',
 'The derivative of sin(x) with respect to x is:',
 '[{"key":"A","text":"-sin(x)"},{"key":"B","text":"cos(x)"},{"key":"C","text":"-cos(x)"},{"key":"D","text":"tan(x)"}]',
 'B','cos(x)',
 'd/dx[sin(x)] = cos(x). This is a fundamental trigonometric derivative. d/dx[cos(x)] = -sin(x), d/dx[tan(x)] = sec²(x).','["Calculus","Differentiation","Mathematics","JEE Main"]'),

-- JKSSB Finance Full Mock
('jkssb-fm-q1','jkssb',NULL,'jkssb-finance-full-mock','JKSSB','2026','Finance Full Mock','J&K General Knowledge','1',
 'Which river is known as the "Vitasta" in ancient texts and is the largest river of Kashmir?',
 '[{"key":"A","text":"Chenab"},{"key":"B","text":"Ravi"},{"key":"C","text":"Jhelum"},{"key":"D","text":"Indus"}]',
 'C','Jhelum',
 'The Jhelum River is known as "Vitasta" in ancient Sanskrit texts and the Rig Veda. It is the largest river flowing through the Kashmir Valley, originating from the Verinag spring in Anantnag district.','["J&K Geography","Rivers","JKSSB"]'),

('jkssb-fm-q2','jkssb',NULL,'jkssb-finance-full-mock','JKSSB','2026','Finance Full Mock','Public Finance','2',
 'The zero-based budgeting approach requires:',
 '[{"key":"A","text":"Carrying forward the previous year''s budget"},{"key":"B","text":"Justifying all expenditures from scratch each year"},{"key":"C","text":"Prioritising only capital expenditure"},{"key":"D","text":"No provision for revenue expenditure"}]',
 'B','Justifying all expenditures from scratch each year',
 'Zero-Based Budgeting (ZBB) requires every department to justify all its expenditures from zero, rather than using the previous year''s budget as a base. It was recommended by the 14th Finance Commission for India.','["Budgeting","Public Finance","JKSSB"]'),

('jkssb-fm-q3','jkssb',NULL,'jkssb-finance-full-mock','JKSSB','2026','Finance Full Mock','Accountancy','3',
 'Which financial statement shows the financial position of a business at a specific date?',
 '[{"key":"A","text":"Income Statement"},{"key":"B","text":"Cash Flow Statement"},{"key":"C","text":"Balance Sheet"},{"key":"D","text":"Statement of Changes in Equity"}]',
 'C','Balance Sheet',
 'The Balance Sheet (Statement of Financial Position) shows assets, liabilities, and equity at a specific point in time. The Income Statement shows revenues and expenses over a period. The Cash Flow Statement shows cash movements.','["Financial statements","Balance Sheet","Accountancy","JKSSB"]'),

-- CTET Paper 1 Full Mock
('ctet-m1-q1','ctet',NULL,'ctet-paper1-mock-1','CTET','2026','Paper 1 Full Mock','Child Development & Pedagogy','1',
 'Vygotsky''s Zone of Proximal Development (ZPD) refers to:',
 '[{"key":"A","text":"Tasks a child can do independently"},{"key":"B","text":"The gap between actual and potential development with guidance"},{"key":"C","text":"The maximum cognitive capacity of a child"},{"key":"D","text":"Tasks completely beyond a child''s capability"}]',
 'B','The gap between actual and potential development with guidance',
 'Vygotsky''s ZPD is the distance between what a learner can do independently and what they can achieve with guidance from a more capable peer or teacher (scaffolding). It is central to the social constructivist theory of learning.','["Vygotsky","ZPD","Child Development","CTET"]'),

('ctet-m1-q2','ctet',NULL,'ctet-paper1-mock-1','CTET','2026','Paper 1 Full Mock','Mathematics','2',
 'Which of the following is the most appropriate strategy to teach fractions to primary school students?',
 '[{"key":"A","text":"Direct instruction with formulae"},{"key":"B","text":"Rote memorisation of fraction tables"},{"key":"C","text":"Using concrete materials like fraction discs and number lines"},{"key":"D","text":"Focusing only on written problems"}]',
 'C','Using concrete materials like fraction discs and number lines',
 'According to NCF and constructivist pedagogy, fractions should be introduced using concrete manipulatives (fraction tiles, discs, number lines) before moving to pictorial and abstract representations. This follows Bruner''s CPA approach.','["Mathematics pedagogy","Fractions","Teaching methods","CTET"]')

ON CONFLICT (slug) DO UPDATE SET
  exam_slug = EXCLUDED.exam_slug, mock_slug = EXCLUDED.mock_slug,
  exam_name = EXCLUDED.exam_name, year = EXCLUDED.year, paper = EXCLUDED.paper,
  subject = EXCLUDED.subject, question_no = EXCLUDED.question_no,
  question = EXCLUDED.question, options = EXCLUDED.options,
  answer_key = EXCLUDED.answer_key, answer = EXCLUDED.answer,
  explanation = EXCLUDED.explanation, tags = EXCLUDED.tags,
  updated_at = CURRENT_TIMESTAMP;


-- ── 6. UPDATE EXAM COUNTS ────────────────────────────────────

UPDATE vaultcore.exams e SET
  papers          = (SELECT COUNT(*) FROM vaultcore.papers p WHERE p.exam_slug = e.slug),
  mocks           = (SELECT COUNT(*) FROM vaultcore.mocks m WHERE m.exam_slug = e.slug),
  total_questions = (SELECT COUNT(*) FROM vaultcore.questions q WHERE q.exam_slug = e.slug),
  updated_at      = CURRENT_TIMESTAMP;
