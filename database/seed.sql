INSERT INTO vaultcore.exams (slug, name, short_name, category, icon, total_questions, papers, mocks, description, popular_years, subjects)
VALUES
  ('upsc-cse', 'UPSC Civil Services Examination', 'UPSC CSE', 'Central', '🏛️', 18000, 120, 85, 'Union Public Service Commission Civil Services Examination (UPSC CSE) is conducted in three stages (Prelims, Mains, and Interview) to select candidates for IAS, IPS, IFS, and other Group A central services.', '["2024","2023","2022","2021"]', '["Polity","History","Geography","Economy","Environment","CSAT"]'),
  ('ssc-cgl', 'SSC CGL', 'SSC CGL', 'Central', '📋', 24000, 180, 120, 'Staff Selection Commission Combined Graduate Level (SSC CGL) examination recruits candidates for Group B and Group C non-gazetted posts across central government ministries and departments.', '["2024","2023","2022","2021"]', '["Quantitative Aptitude","General Intelligence & Reasoning","English Language","General Awareness"]'),
  ('jkssb', 'Jammu & Kashmir Services Selection Board', 'JKSSB', 'J&K', '📜', 8000, 70, 45, 'Jammu & Kashmir Services Selection Board (JKSSB) conducts competitive examinations for recruitment to non-gazetted posts under J&K government departments, including Finance Accounts Assistant, Junior Assistant, Patwari, VLW, and Wildlife Guard.', '["2024","2023","2022","2021"]', '["Public Finance","Accountancy","J&K General Knowledge","General Intelligence & Reasoning","Quantitative Aptitude"]'),
  ('neet-ug', 'NEET UG', 'NEET UG', 'Medical', '🧬', 12000, 90, 100, 'National Eligibility cum Entrance Test (NEET UG) conducted by the National Testing Agency (NTA) determines admission to MBBS, BDS, BAMS, BSMS, and other undergraduate medical and allied health science programmes across India.', '["2024","2023","2022","2021"]', '["Biology","Physics","Chemistry"]')
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  short_name = EXCLUDED.short_name,
  category = EXCLUDED.category,
  icon = EXCLUDED.icon,
  total_questions = EXCLUDED.total_questions,
  papers = EXCLUDED.papers,
  mocks = EXCLUDED.mocks,
  description = EXCLUDED.description,
  popular_years = EXCLUDED.popular_years,
  subjects = EXCLUDED.subjects,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO vaultcore.papers (slug, exam_slug, exam_name, title, year, shift, description, questions, subjects)
VALUES
  ('upsc-prelims-2023-gs-paper-1', 'upsc-cse', 'UPSC CSE', 'UPSC Prelims 2023 GS Paper 1 Solved', '2023', 'General Studies Paper 1', 'UPSC Prelims 2023 GS Paper 1 with solved answers, topic tags, explanations, and free question-wise practice.', 100, '["Polity","History","Geography","Economy","Environment"]'),
  ('ssc-cgl-2023-tier-1-all-shifts', 'ssc-cgl', 'SSC CGL', 'SSC CGL 2023 Tier 1 All Shifts Solved', '2023', 'Tier 1 All Shifts', 'SSC CGL 2023 Tier 1 solved previous year papers with shift-wise questions and explanations.', 900, '["Quantitative Aptitude","General Intelligence & Reasoning","English Language","General Awareness"]'),
  ('jkssb-finance-accounts-2024-paper', 'jkssb', 'JKSSB', 'JKSSB Finance Accounts 2024 Solved Paper', '2024', 'Finance Accounts Paper', 'JKSSB Finance Accounts 2024 paper with solved answers, explanations, and exam-wise practice links.', 150, '["Public Finance","Accountancy","Budget & Taxation","General Intelligence & Reasoning"]')
ON CONFLICT (slug) DO UPDATE SET
  exam_slug = EXCLUDED.exam_slug,
  exam_name = EXCLUDED.exam_name,
  title = EXCLUDED.title,
  year = EXCLUDED.year,
  shift = EXCLUDED.shift,
  description = EXCLUDED.description,
  questions = EXCLUDED.questions,
  subjects = EXCLUDED.subjects,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO vaultcore.questions (slug, exam_slug, paper_slug, exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags)
VALUES
  ('upsc-prelims-2023-river-origin-question', 'upsc-cse', 'upsc-prelims-2023-gs-paper-1', 'UPSC CSE', '2023', 'Prelims GS Paper 1', 'Geography', '47', 'Which of the following rivers does not originate within India''s territory?', '[{"key":"A","text":"Beas"},{"key":"B","text":"Chenab"},{"key":"C","text":"Sutlej"},{"key":"D","text":"Ravi"}]', 'B', 'Chenab', 'Chenab is commonly tested with Himalayan river origin traps. In PYQ practice, always revise the source, route, and first major region each river flows through. Beas and Ravi originate in Himachal Pradesh, while Sutlej is associated with Tibet near Mansarovar before entering India.', '["River systems","Indian geography","UPSC Prelims"]'),
  ('ssc-cgl-2023-percentage-profit-loss-question', 'ssc-cgl', 'ssc-cgl-2023-tier-1-all-shifts', 'SSC CGL', '2023', 'Tier 1 Quantitative Aptitude', 'Quantitative Aptitude', '18', 'A shopkeeper marks an article 25% above cost price and allows a discount of 10%. What is the profit percentage?', '[{"key":"A","text":"10%"},{"key":"B","text":"12.5%"},{"key":"C","text":"15%"},{"key":"D","text":"20%"}]', 'B', '12.5%', 'Assume cost price is 100. Marked price becomes 125. After 10% discount, selling price is 112.5. Profit is 12.5 on cost price 100, so profit percentage is 12.5%.', '["Percentage","Profit and Loss","SSC CGL"]'),
  ('jkssb-finance-2024-budget-question', 'jkssb', 'jkssb-finance-accounts-2024-paper', 'JKSSB', '2024', 'Finance Accounts Paper', 'Public Finance', '32', 'Which document presents the estimated receipts and expenditure of the government for a financial year?', '[{"key":"A","text":"Appropriation Bill"},{"key":"B","text":"Finance Bill"},{"key":"C","text":"Annual Financial Statement"},{"key":"D","text":"Vote on Account"}]', 'C', 'Annual Financial Statement', 'The Annual Financial Statement is the constitutional name for the budget document that shows estimated receipts and expenditure of the government for a financial year.', '["Budget","Public Finance","JKSSB"]')
ON CONFLICT (slug) DO UPDATE SET
  exam_slug = EXCLUDED.exam_slug,
  paper_slug = EXCLUDED.paper_slug,
  exam_name = EXCLUDED.exam_name,
  year = EXCLUDED.year,
  paper = EXCLUDED.paper,
  subject = EXCLUDED.subject,
  question_no = EXCLUDED.question_no,
  question = EXCLUDED.question,
  options = EXCLUDED.options,
  answer_key = EXCLUDED.answer_key,
  answer = EXCLUDED.answer,
  explanation = EXCLUDED.explanation,
  tags = EXCLUDED.tags,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO vaultcore.mocks (slug, exam_slug, exam_name, title, description, questions, duration_minutes, difficulty, is_free, subjects)
VALUES
  ('upsc-prelims-gs-mini-mock-2026', 'upsc-cse', 'UPSC CSE', 'UPSC Prelims GS Mini Mock 2026', 'A focused UPSC Prelims mini mock covering polity, geography, history, economy, and environment with instant review.', 25, 30, 'Moderate', TRUE, '["Polity","Geography","History","Environment"]'),
  ('ssc-cgl-tier-1-reasoning-sprint', 'ssc-cgl', 'SSC CGL', 'SSC CGL Tier 1 Reasoning Sprint', 'Timed reasoning practice for SSC CGL Tier 1 with previous-year style questions and score analysis.', 30, 20, 'Beginner', TRUE, '["General Intelligence & Reasoning","Quantitative Aptitude","General Awareness"]'),
  ('jkssb-finance-accounts-full-mock', 'jkssb', 'JKSSB', 'JKSSB Finance Accounts Full Mock', 'Full-length JKSSB finance and accounts mock with public finance, accounting, reasoning, and JK GK coverage.', 100, 120, 'Advanced', FALSE, '["Public Finance","Accountancy","General Intelligence & Reasoning","J&K General Knowledge"]')
ON CONFLICT (slug) DO UPDATE SET
  exam_slug = EXCLUDED.exam_slug,
  exam_name = EXCLUDED.exam_name,
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  questions = EXCLUDED.questions,
  duration_minutes = EXCLUDED.duration_minutes,
  difficulty = EXCLUDED.difficulty,
  is_free = EXCLUDED.is_free,
  subjects = EXCLUDED.subjects,
  updated_at = CURRENT_TIMESTAMP;
