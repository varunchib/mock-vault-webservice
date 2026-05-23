-- JKPSC — JKCCE Prelims 2025 GS Paper I (Set B)
-- 100 questions · 200 marks (2 marks each) · 120 minutes · 0.67 marks negative (1/3)

BEGIN;

-- Exam
INSERT INTO vaultcore.exams (slug, name, category, subjects, icon, short_name, description, mocks, papers, total_questions, popular_years)
VALUES (
  'jkpsc',
  'Jammu & Kashmir Public Service Commission',
  'State',
  '["Polity & Governance","History & Culture","Geography","Economy","Science & Technology","Environment & Ecology","J&K Affairs","Current Affairs"]'::jsonb,
  '🏔️',
  'JKPSC',
  'Jammu & Kashmir Public Service Commission conducts the Combined Competitive Examination (JKCCE) for J&K civil services recruitment.',
  0, 1, 100,
  '["2025"]'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name            = EXCLUDED.name,
  subjects        = EXCLUDED.subjects,
  papers          = EXCLUDED.papers,
  total_questions = EXCLUDED.total_questions,
  updated_at      = CURRENT_TIMESTAMP;

-- Paper
INSERT INTO vaultcore.papers (slug, exam_slug, exam_name, title, year, shift, description, questions, subjects, negative_marking, duration_minutes, max_marks)
VALUES (
  'jkpsc-jkcce-prelims-2025-gs1-set-b',
  'jkpsc',
  'Jammu & Kashmir Public Service Commission',
  'JKCCE Prelims 2025 — General Studies Paper I (Set B)',
  '2025',
  'Set B',
  'JKPSC JKCCE Prelims 2025 General Studies Paper I Set B — 100 questions, 200 marks, 120 minutes, 1/3 negative marking.',
  100,
  '["Polity & Governance","History & Culture","Geography","Economy","Science & Technology","Environment & Ecology","J&K Affairs","Current Affairs"]'::jsonb,
  0.67,
  120,
  200
)
ON CONFLICT (slug) DO UPDATE SET
  title      = EXCLUDED.title,
  questions  = EXCLUDED.questions,
  updated_at = CURRENT_TIMESTAMP;

-- Questions
INSERT INTO vaultcore.questions
  (slug, exam_slug, paper_slug, exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags)
VALUES

('jkpsc-jkcce-2025-pre-gs1-q1','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','1',
'What is the permissible limit of noise pollution, prescribed by CPCB during night time?',
'[{"key":"A","text":"Less than 40 dB"},{"key":"B","text":"40-70 dB"},{"key":"C","text":"70-100 dB"},{"key":"D","text":"More than 100 dB"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q2','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Geography','2',
'Amount of destruction caused by an earthquake is measured by:',
'[{"key":"A","text":"Richter Scale"},{"key":"B","text":"Intensity Scale"},{"key":"C","text":"Magnitude Scale"},{"key":"D","text":"Mercalli Scale"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q3','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','3',
'What is the correct increasing order of Global Warming Potential of the following Greenhouse Gases?
I. Methane
II. Fluorinated Gases
III. Carbon dioxide
IV. Nitrous Oxide
Select the correct answer using the codes given below:',
'[{"key":"A","text":"III, II, I, IV"},{"key":"B","text":"II, III, I, IV"},{"key":"C","text":"I, II, III, IV"},{"key":"D","text":"III, I, IV, II"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q4','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Economy','4',
'Which of the following indicators are used to calculate the Physical Quality of Life Index (PQLI)?
I. Infant mortality rate
II. Life expectancy at age one
III. Standard of living (income per capita)
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q5','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Economy','5',
'Consider the following statements:
Assertion (A): Currency depreciation always leads to an improvement in the trade balance.
Reason (R): The real exchange rate adjusts the nominal exchange rate for differences in price levels (inflation) between countries.
Select the correct answer:',
'[{"key":"A","text":"Both A and R are true, and R is the correct explanation of A"},{"key":"B","text":"Both A and R are true, but R is not the correct explanation of A"},{"key":"C","text":"A is true, but R is false"},{"key":"D","text":"A is false, but R is true"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q6','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Economy','6',
'Consider the following statements:
I. The Exchange Rate Mechanism (ERM) of the International Monetary Fund (IMF) facilitates currency convertibility among member countries.
II. Under a flexible foreign exchange rate system, the need for balance of payments adjustments through foreign exchange reserves is reduced.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q7','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Economy','7',
'As per the Union Budget 2025-26, what target (in gigawatts) has been set for nuclear power capacity by the year 2047?',
'[{"key":"A","text":"30 GW (gigawatts)"},{"key":"B","text":"50 GW (gigawatts)"},{"key":"C","text":"100 GW (gigawatts)"},{"key":"D","text":"200 GW (gigawatts)"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q8','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','8',
'Consider the following initiatives:
I. PM SHRI
II. STARS
III. DIKSHA
IV. ULLAS
V. PM POSHAN
Through how many of the above initiatives does the Government aim to achieve the objectives of the National Education Policy (NEP), 2020?',
'[{"key":"A","text":"Only two"},{"key":"B","text":"Only three"},{"key":"C","text":"Only four"},{"key":"D","text":"All five"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q9','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','9',
'Which of the following sub-schemes being implemented under the Samagra Shiksha Abhiyan programme are to achieve the objectives of the National Education Policy (NEP), 2020?
I. NISHTHA
II. Vidya Pravesh
III. District Institutes of Education and Training (DIETs)
IV. Rani Laxmibai Balika Vidyalaya
Which of the above are correct?',
'[{"key":"A","text":"I, II and III"},{"key":"B","text":"I, II and IV"},{"key":"C","text":"I, III and IV"},{"key":"D","text":"II, III and IV"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q10','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Economy','10',
'Match the following key deficit indicators with their respective values in percentage of GDP for the Financial Year 2025-26 as per the Union Budget:
i. Primary Deficit          — a. 0.3 percent
ii. Effective Revenue Deficit — b. 4.4 percent
iii. Revenue Deficit         — c. 0.8 percent
iv. Fiscal Deficit           — d. 1.5 percent
Choose the correct answer:',
'[{"key":"A","text":"i-c, ii-a, iii-d, iv-b"},{"key":"B","text":"i-a, ii-b, iii-c, iv-d"},{"key":"C","text":"i-b, ii-d, iii-a, iv-c"},{"key":"D","text":"i-d, ii-c, iii-b, iv-a"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q11','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','11',
'Which of the following are e-initiatives of the Employees'' State Insurance Corporation (ESIC)?
I. E-Pehchan
II. E-Biz Platform
III. ABHA Number Creation
IV. UPI App for IPs
V. GIS based Maps
Choose the correct answer:',
'[{"key":"A","text":"I, II, III and IV"},{"key":"B","text":"I, II and V"},{"key":"C","text":"II, III and IV"},{"key":"D","text":"III, IV and V"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q12','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','12',
'Which of the following are the key pillars of health policy?
I. Preventive health care
II. Early detection of ailments
III. Free and low-cost treatment and medicines
IV. Availability of doctors in urban areas
V. Expansion of technology in health
Choose the correct answer:',
'[{"key":"A","text":"I, II, III and IV"},{"key":"B","text":"I, II, III and V"},{"key":"C","text":"I, IV and V"},{"key":"D","text":"II, III, IV and V"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q13','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Economy','13',
'The following countries are India''s top five trade partners in Financial Year 2024-25. Choose the correct sequence in terms of trade values in decreasing order:
I. UAE
II. USA
III. China
IV. Russia
V. Saudi Arabia',
'[{"key":"A","text":"I, II, III, IV, V"},{"key":"B","text":"II, III, I, IV, V"},{"key":"C","text":"III, IV, V, I, II"},{"key":"D","text":"IV, I, II, V, III"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q14','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','14',
'Consider the following statements regarding the PM e-Bus Sewa scheme:
I. PM e-Bus Sewa is a centrally sponsored scheme initiated in 2023.
II. It aims to augment bus operations in urban areas with central assistance of Rs. 20,000 crore for developing 10,000 electric buses.
III. More than 169 cities with population size between 3 lakh and 40 lakh, as per census 2011, are eligible to participate under the scheme.
IV. The scheme shall remain valid up to March 2047.
Which of the following statements is/are correct?',
'[{"key":"A","text":"I, II and III only"},{"key":"B","text":"I, II and IV only"},{"key":"C","text":"I, III and IV only"},{"key":"D","text":"II, III and IV only"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q15','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Economy','15',
'Match the following countries with the year in which they crossed the pre-pandemic GDP (constant prices, national currency):
Countries       — Year
1. India        — i. 2020
2. China        — ii. 2021
3. Japan        — iii. 2022
4. United Kingdom — iv. 2023
Choose the correct answer:',
'[{"key":"A","text":"1-iv, 2-iii, 3-ii, 4-i"},{"key":"B","text":"1-i, 2-ii, 3-iii, 4-iv"},{"key":"C","text":"1-ii, 2-i, 3-iv, 4-iii"},{"key":"D","text":"1-iii, 2-iv, 3-i, 4-ii"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q16','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','16',
'Match the following Sustainable Development Goals (SDGs):
Goal      — Name of Goal
1. Goal 4  — i. Gender Equality
2. Goal 5  — ii. Quality Education
3. Goal 6  — iii. Reduced Inequality
4. Goal 10 — iv. Clean Water and Sanitation
Choose the correct answer:',
'[{"key":"A","text":"1-ii, 2-i, 3-iv, 4-iii"},{"key":"B","text":"1-iv, 2-iii, 3-ii, 4-i"},{"key":"C","text":"1-i, 2-ii, 3-iii, 4-iv"},{"key":"D","text":"1-iii, 2-iv, 3-i, 4-ii"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q17','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','17',
'How many houses have been completed under Pradhan Mantri Awaas Yojana-Gramin (PMAY-G) from 2016 till January 2025?',
'[{"key":"A","text":"1.69 crore"},{"key":"B","text":"2.69 crore"},{"key":"C","text":"3.69 crore"},{"key":"D","text":"4.69 crore"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q18','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Economy','18',
'Which of the following pairs of Chairperson and their respective Finance Commission are correctly matched?
I. 10th Finance Commission — KC Pant
II. 12th Finance Commission — Dr. C Rangarajan
III. 13th Finance Commission — Vijay Kelkar
IV. 14th Finance Commission — Dr. YV Reddy
Choose the correct answer:',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"I, II and III only"},{"key":"C","text":"I, III and IV only"},{"key":"D","text":"I, II, III and IV"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q19','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','19',
'Which one of the following Acts provided for the establishment of a Public Service Commission in India for the first time?',
'[{"key":"A","text":"Indian Councils Act, 1861"},{"key":"B","text":"Indian Councils Act, 1909"},{"key":"C","text":"Government of India Act, 1919"},{"key":"D","text":"Government of India Act, 1935"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q20','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','20',
'Which of the following pairs are correctly matched?
I. Education — Concurrent List
II. Income Tax — Concurrent List
III. Public Health — State List
IV. Census — Union List
Choose the correct answer:',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"I, II and III only"},{"key":"C","text":"I, III and IV only"},{"key":"D","text":"II, III and IV only"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q21','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','21',
'Consider the following statements regarding the Advisory Jurisdiction of the Supreme Court of India:
Statement-I: It is not mandatory for the Supreme Court to provide its opinion on a Presidential reference.
Statement-II: The opinion given by the Supreme Court is binding in nature.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement-I and Statement-II are correct and Statement-II is the correct explanation for Statement-I"},{"key":"B","text":"Both Statement-I and Statement-II are correct and Statement-II is not the correct explanation for Statement-I"},{"key":"C","text":"Statement-I is correct but Statement-II is incorrect"},{"key":"D","text":"Statement-I is incorrect but Statement-II is correct"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q22','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','22',
'Consider the following statements regarding the Advocate General of the State:
I. He/She is appointed by the Governor of a State.
II. He/She holds office during the pleasure of the Governor.
III. His/Her remuneration is determined by the State Legislature.
Which of the statements given above is/are NOT correct?',
'[{"key":"A","text":"I"},{"key":"B","text":"II"},{"key":"C","text":"III"},{"key":"D","text":"None of the above"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q23','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','23',
'Consider the following functionaries:
I. Chief Justice of India
II. Cabinet Secretary
III. Chief Election Commissioner
IV. Union Cabinet Ministers
The correct sequence in the order of precedence is:',
'[{"key":"A","text":"II, III, I, IV"},{"key":"B","text":"II, I, III, IV"},{"key":"C","text":"I, II, III, IV"},{"key":"D","text":"I, IV, III, II"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q24','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','24',
'With reference to the jurisdiction of the Lokpal, consider the following public authorities:
I. Prime Minister
II. Union Ministers
III. Members of Parliament
IV. Officials of the Central Government
Which of the above come under the jurisdiction of the Lokpal?',
'[{"key":"A","text":"I only"},{"key":"B","text":"I and III only"},{"key":"C","text":"II and IV only"},{"key":"D","text":"I, II and IV"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q25','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','25',
'When a Money Bill is presented to the President of India for assent, which of the following powers does she exercise?
I. She may give her assent to the bill.
II. She may withhold her assent to the bill.
III. She may return the bill for reconsideration of the Parliament.
Select the correct answer using the code given below:',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"I and III only"},{"key":"C","text":"I only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q26','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','26',
'Consider the following statements:
Assertion (A): The Chairperson of NITI Aayog is appointed by the Prime Minister.
Reason (R): The NITI Aayog was created by an executive resolution of the Government of India.
The correct answer is:',
'[{"key":"A","text":"A and R are both correct and R is the correct explanation of A"},{"key":"B","text":"A and R are both correct and R is NOT the correct explanation of A"},{"key":"C","text":"A is correct, but R is NOT correct"},{"key":"D","text":"A is NOT correct, but R is correct"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q27','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','27',
'Which of the following authorities'' salaries, allowances, and pensions are charged upon the Consolidated Fund of India?
I. Judges of the Supreme Court
II. Comptroller and Auditor General of India
III. Chief Election Commissioner
Select the correct answer using the code given below:',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"I and III only"},{"key":"C","text":"III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q28','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','28',
'Consider the following pairs regarding the veto powers of the President of India:
1. Absolute Veto   — President withholds assent to a bill passed by the Parliament.
2. Suspensive Veto — President returns a bill (other than a money bill) for reconsideration.
3. Pocket Veto     — President neither gives assent nor returns the bill when Parliament is not in session.
4. Line-Item Veto  — President can reject specific provisions or items in a bill (mainly financial bills).
How many of the above pairs are correctly matched?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"Only three"},{"key":"D","text":"All four"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q29','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','29',
'Through which Constitutional Amendment was sub-clause (1A) added to Article 75, stating that the total number of Ministers including the Prime Minister shall not exceed 15% of the total number of members of the House of the People?',
'[{"key":"A","text":"91st Amendment"},{"key":"B","text":"86th Amendment"},{"key":"C","text":"89th Amendment"},{"key":"D","text":"95th Amendment"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q30','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','30',
'Consider the following statements regarding the 37th Constitutional Amendment:
I. Article 239A was added by the 37th Amendment.
II. Article 239A has been made applicable to Union Territory of Jammu and Kashmir by the Jammu and Kashmir Reorganisation Act, 2019.
Choose the correct statement(s):',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II are correct"},{"key":"D","text":"None of the above"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q31','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','31',
'Who among the following served as Vice-President of India?
I. Dr. S. Radhakrishnan
II. Dr. Zakir Hussain
III. Fakhruddin Ali Ahmed
IV. Giani Zail Singh
Choose the correct answer:',
'[{"key":"A","text":"I"},{"key":"B","text":"I and II"},{"key":"C","text":"I, II and III"},{"key":"D","text":"I, II, III and IV"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q32','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','32',
'Arrange the following states in descending order according to the number of times President''s Rule has been imposed:
I. Uttar Pradesh
II. Tamil Nadu
III. Madhya Pradesh
IV. Karnataka
Select the correct answer:',
'[{"key":"A","text":"I — IV — II — III"},{"key":"B","text":"I — II — IV — III"},{"key":"C","text":"IV — I — II — III"},{"key":"D","text":"II — III — I — IV"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q33','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','33',
'Arrange the following states in the ascending order of their representation (seats) in the Council of States (Rajya Sabha):
I. West Bengal
II. Rajasthan
III. Punjab
IV. Karnataka
Choose the correct answer:',
'[{"key":"A","text":"III — II — IV — I"},{"key":"B","text":"III — IV — II — I"},{"key":"C","text":"IV — I — II — III"},{"key":"D","text":"II — III — IV — I"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q34','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','34',
'Which of the following pairs of states and their formation dates is correctly matched?
I. Arunachal Pradesh — 1986
II. Telangana — 2013
III. Goa — 1986
IV. Uttarakhand — 2001
Choose the correct answer:',
'[{"key":"A","text":"Only I"},{"key":"B","text":"I and III"},{"key":"C","text":"II and IV"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q35','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','35',
'How many national parties participated in the first Lok Sabha election of India held in 1952?',
'[{"key":"A","text":"12"},{"key":"B","text":"13"},{"key":"C","text":"14"},{"key":"D","text":"15"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q36','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','36',
'In which Article of the Indian Constitution is the provision related to the audit of Panchayat accounts mentioned?',
'[{"key":"A","text":"243 J"},{"key":"B","text":"243 I"},{"key":"C","text":"243 L"},{"key":"D","text":"243 K"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q37','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','37',
'Which of the following pairs accurately represent dominant castes in state politics in India?
I. Lingayats — Karnataka
II. Patidars — Gujarat
III. Vokkalingas — Tamil Nadu
IV. Kammas — Andhra Pradesh
Select the correct answer:',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"I, II and III only"},{"key":"C","text":"I, II and IV only"},{"key":"D","text":"I, III and IV only"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q38','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','38',
'Consider the following statements regarding the Blue Flag Certification:
I. It is an internationally recognised eco-label awarded by the Foundation for Environmental Education (FEE) in Denmark.
II. The Chandrabhaga Beach in Odisha was the first in India to receive the Blue Flag Certification.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q39','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','39',
'Which of the following traditional cultivation techniques practiced by the Kondh tribes is under threat due to the monocropping of Eucalyptus?',
'[{"key":"A","text":"Jhum cultivation"},{"key":"B","text":"Dongar cultivation"},{"key":"C","text":"Poonam Krishi cultivation"},{"key":"D","text":"Apatani wet rice cultivation"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q40','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','40',
'Recently, the Union Cabinet granted Classical Language Status to five languages. Consider the following statements regarding the revised criteria for a language to be conferred with Classical status:
I. High antiquity of its early texts or recorded history, spanning at least 1500-2000 years.
II. A body of ancient literature/texts considered a valuable heritage by successive generations of speakers.
III. The literary tradition should be original and not borrowed from another speech community.
IV. The language must be currently spoken by more than 50 million people.
Which of the statements given above are correct?',
'[{"key":"A","text":"I, II and III only"},{"key":"B","text":"II and IV only"},{"key":"C","text":"I, III and IV only"},{"key":"D","text":"All four statements"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q41','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','41',
'Consider the following institutions and their corresponding domains under India''s National Quantum Mission (NQM):
Institution — Domain
1. IISc, Bengaluru — i. Quantum Computing Hub
2. IIT, Madras     — ii. Quantum Communication Hub
3. IIT, Bombay     — iii. Quantum Materials and Devices Hub
4. IIT, Delhi      — iv. Quantum Sensing and Metrology Hub
Which of the above pairs is/are correctly matched?',
'[{"key":"A","text":"1-i, 2-ii, 3-iv, 4-iii"},{"key":"B","text":"1-i, 2-iii, 3-ii, 4-iv"},{"key":"C","text":"1-ii, 2-iv, 3-iii, 4-i"},{"key":"D","text":"1-iii, 2-i, 3-iv, 4-ii"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q42','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','42',
'Consider the following statements with reference to the Gaganyaan Mission of ISRO:
I. The mission aims to place astronauts in a geostationary orbit.
II. It comprises two uncrewed flights followed by one crewed mission.
III. The human-rated launch vehicle for the mission is derived from LVM3.
Which of the statement(s) given above is/are incorrect?',
'[{"key":"A","text":"I only"},{"key":"B","text":"I and II only"},{"key":"C","text":"II and III only"},{"key":"D","text":"I and III only"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q43','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','43',
'Consider the following statements regarding the Nipah Virus (NiV):
I. It is an orthopoxvirus.
II. NiV is a zoonotic disease transmitted from animals to humans.
III. Polymerase Chain Reaction (PCR) is the preferred laboratory test for NiV.
IV. The incubation period ranges from 4 to 14 days on average.
How many of the above statements is/are correct?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"Only three"},{"key":"D","text":"All four"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q44','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Current Affairs','44',
'With reference to India''s international humanitarian missions, consider the following pairs:
Operation — Purpose
1. Operation Dost   — Earthquake relief in Turkey and Syria
2. Operation Ganga  — Evacuation of Indians from the Ukraine conflict
3. Operation Kaveri — Evacuation of Indians from Sudan
4. Operation Ajay   — Rescue from the Israel-Hamas conflict
How many of the above pairs are correctly matched?',
'[{"key":"A","text":"1 pair"},{"key":"B","text":"2 pairs"},{"key":"C","text":"3 pairs"},{"key":"D","text":"4 pairs"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q45','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','45',
'Consider the following technologies:
I. Natural Language Processing
II. Quantum Computing
III. Audio Processing
IV. Computer Vision
Which of the above are supported by Hugging Face''s AI model hub?',
'[{"key":"A","text":"II and III"},{"key":"B","text":"I, II and IV"},{"key":"C","text":"I, III and IV"},{"key":"D","text":"I, II, III and IV"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q46','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Current Affairs','46',
'Match the following global awards conferred on Prime Minister Narendra Modi with the respective countries:
Award — Country
1. The Grand Cross of the Order of Honour         — i. Russia
2. The Grand Companion of the Order of Logohu      — ii. Greece
3. The Order of the Holy Apostle Andrew the First  — iii. France
4. The Grand Cross of the Legion of Honour         — iv. Papua New Guinea
Match the correct option:',
'[{"key":"A","text":"1-i, 2-ii, 3-iii, 4-iv"},{"key":"B","text":"1-ii, 2-iv, 3-i, 4-iii"},{"key":"C","text":"1-iii, 2-i, 3-iv, 4-ii"},{"key":"D","text":"1-iv, 2-iii, 3-ii, 4-i"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q47','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Polity & Governance','47',
'As per the Constitution of India, the State can impose reasonable restrictions on the freedom of speech and expression on which of the following grounds?
I. Sovereignty and integrity of India
II. Public Order
III. Contempt of Court
IV. Defamation
Select the correct answer using the code given below:',
'[{"key":"A","text":"I and III only"},{"key":"B","text":"I, II and IV only"},{"key":"C","text":"II and IV only"},{"key":"D","text":"I, II, III and IV"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q48','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Current Affairs','48',
'The Shanghai Cooperation Organisation (SCO) has at present:',
'[{"key":"A","text":"10 member states, 14 observer states and 2 dialogue partners"},{"key":"B","text":"14 member states, 2 observer states and 10 dialogue partners"},{"key":"C","text":"10 member states, 10 observer states and 10 dialogue partners"},{"key":"D","text":"10 member states, 2 observer states and 14 dialogue partners"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q49','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','J&K Affairs','49',
'The Jammu and Kashmir Energy Development Agency''s mission and vision are:
I. To lead the energy transition.
II. To speed up the transition to partial renewable energy.
III. To build a culture of excellence.
IV. To maintain the highest standards of quality and sustainability.
Choose the correct option:',
'[{"key":"A","text":"Only I, II and III are correct"},{"key":"B","text":"Only II, III and IV are correct"},{"key":"C","text":"Only I, III and IV are correct"},{"key":"D","text":"Only I, II and IV are correct"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q50','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','50',
'Match the following proponents of Indian classical music with their Gharanas:
Musician — Gharana
1. Channulal Mishra          — i. Agra Gharana
2. Krishnarao Shankar Pandit — ii. Kirana Gharana
3. Bhimsen Joshi             — iii. Gwalior Gharana
4. Pandit Yashpal            — iv. Banaras Gharana
Match the correct option:',
'[{"key":"A","text":"1-i, 2-ii, 3-iii, 4-iv"},{"key":"B","text":"1-ii, 2-iv, 3-i, 4-iii"},{"key":"C","text":"1-iii, 2-i, 3-iv, 4-ii"},{"key":"D","text":"1-iv, 2-iii, 3-ii, 4-i"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q51','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Current Affairs','51',
'With reference to Mirabai Chanu, consider the following statements:
I. She won a silver medal in the IWF Senior World Weightlifting Championship 2025.
II. She won a gold medal in the IWF Senior World Weightlifting Championship 2017.
III. She won a silver medal in the IWF Senior World Weightlifting Championship 2022.
IV. She won a gold medal at the Paris Olympics 2024.
Choose the correct answer using the code given below:',
'[{"key":"A","text":"Only I, II and III are correct"},{"key":"B","text":"Only II, III and IV are correct"},{"key":"C","text":"Only I, III and IV are correct"},{"key":"D","text":"All are correct"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q52','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','52',
'Consider the following statements regarding the Indus Valley Civilization:
I. The buildings at Harappa were more elaborately constructed than those at Mohenjo-Daro.
II. Mohenjo-Daro had a large tank (Great Bath) located within the Citadel mound.
III. The granary is the largest building discovered at Harappa.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I and II"},{"key":"B","text":"II only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q53','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','53',
'Match the following Buddhist Councils with their respective venues:
Council — Venue
1. First Buddhist Council  — a. Rajgriha
2. Second Buddhist Council — b. Vaishali
3. Third Buddhist Council  — c. Kashmir
4. Fourth Buddhist Council — d. Pataliputra
How many of the above pairs is/are incorrectly matched?',
'[{"key":"A","text":"Only one pair"},{"key":"B","text":"Only two pairs"},{"key":"C","text":"Only three pairs"},{"key":"D","text":"All pairs are correctly matched"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q54','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','54',
'Consider the following locations:
I. Surat
II. Madras
III. Bombay
In how many of the above-given locations did the British East India Company establish their factories during the reign of Mughal emperor Jahangir?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q55','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','55',
'Consider the following monuments:
I. Taj Mahal
II. Agra Fort
III. Red Fort
IV. Shalimar Bagh
In how many of the above monuments has the pietra dura (inlay work with semi-precious stones) technique been used?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"Only three"},{"key":"D","text":"All four"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q56','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','56',
'Which of the following foreign accounts provide contemporary evidence about the Vijayanagara Empire?
I. Abdur Razzaq''s writings
II. Domingo Paes'' travel account
III. Ibn Battuta''s Rihla
IV. Niccolo de Conti''s travelogue
Select the correct answer using the code given below:',
'[{"key":"A","text":"I, II and III only"},{"key":"B","text":"I, II and IV only"},{"key":"C","text":"II and III only"},{"key":"D","text":"All four"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q57','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','57',
'Consider the following statements regarding the provisions of the Cripps Mission (1942):
I. The provinces were to enjoy full autonomy and could choose to remain outside the proposed Indian Union.
II. The Mission proposed the establishment of a Constituent Assembly after the war to frame India''s Constitution.
III. The Muslim League rejected the offer because it did not explicitly recognize the demand for Pakistan.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"I and III only"},{"key":"C","text":"I, II and III"},{"key":"D","text":"II and III only"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q58','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','58',
'With reference to the Government of India Act, 1935, consider the following statements:
I. It introduced provincial autonomy with ministries responsible to the elected provincial legislatures.
II. It retained the overriding powers of the Governor-General in both provincial and central administration.
III. It established bicameral legislatures at the Centre and in all provinces without exception.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"I and III only"},{"key":"C","text":"II and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q59','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','59',
'With reference to the Lahore Session of the Indian National Congress (1929), consider the following statements:
I. It was presided over by Subhas Chandra Bose.
II. The resolution of Purna Swaraj was adopted at this session.
III. It was decided to celebrate 26 January 1930 as Independence Day.
IV. It approved participation in the Round Table Conference.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I and IV only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I, II and III only"},{"key":"D","text":"II, III and IV only"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q60','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','60',
'Consider the following personalities:
I. Bankim Chandra Chatterjee
II. Ishwar Chandra Vidyasagar
III. Ishan Chandra Roy
IV. Ram Mohan Roy
V. Sambhunath Pal
VI. Tomma Dora
How many of the above personalities were associated with the Pabna Agrarian Revolt (1873-76)?',
'[{"key":"A","text":"Only two"},{"key":"B","text":"Only three"},{"key":"C","text":"Only four"},{"key":"D","text":"Only five"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q61','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','61',
'With reference to journals in Modern Indian History, consider the following pairs:
Journal — Founder / Associated Person
1. Kesari        — Surendranath Banerjee
2. Bengalee      — Bal Gangadhar Tilak
3. Sudharak      — Gopal Krishna Gokhale
4. Indian Mirror — Keshab Chandra Sen
How many of the above pairs are correctly matched?',
'[{"key":"A","text":"Only one pair"},{"key":"B","text":"Only two pairs"},{"key":"C","text":"Only three pairs"},{"key":"D","text":"All four pairs"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q62','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','62',
'Glucose is classified as:',
'[{"key":"A","text":"Aldohexose"},{"key":"B","text":"Ketohexose"},{"key":"C","text":"Aldopentose"},{"key":"D","text":"Ketopentose"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q63','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','63',
'Ramcharita was written by:',
'[{"key":"A","text":"Tulsi Das"},{"key":"B","text":"Banabhatta"},{"key":"C","text":"Padmagupta"},{"key":"D","text":"Sandhyakaranandin"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q64','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','J&K Affairs','64',
'The saffron cultivation in Kashmir was introduced by:',
'[{"key":"A","text":"Mijjhantika"},{"key":"B","text":"Arvala"},{"key":"C","text":"Sakyasimha"},{"key":"D","text":"Asvaghosha"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q65','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','J&K Affairs','65',
'Choose the incorrect statement about the findings of the 1st Water Census of Jammu and Kashmir:',
'[{"key":"A","text":"Majority of the water bodies in Jammu and Kashmir are located in rural areas."},{"key":"B","text":"More than half of total water bodies in Jammu and Kashmir are lakes."},{"key":"C","text":"There are less than 10,000 water bodies in Jammu and Kashmir."},{"key":"D","text":"More than 50% of the water bodies are publicly owned in the UT."}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q66','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','66',
'Which of the following statements about coral reefs in India is/are correct?
Statement 1: The Fourth Global Coral Bleaching Event (GCBE4) has not impacted the coral reefs of India in regions such as the Andaman and Nicobar Islands, Gulf of Mannar, Lakshadweep, and the Gulf of Kachchh.
Statement 2: Marine Protected Areas (MPAs) have been established across India to limit human activities and promote ecosystem and coral reef recovery.
Statement 3: Coral species are not protected under the Indian Wildlife (Protection) Act, 1972.
How many statement(s) is/are correct?',
'[{"key":"A","text":"Only one statement"},{"key":"B","text":"Only two statements"},{"key":"C","text":"All statements are correct"},{"key":"D","text":"No statement is correct"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q67','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Geography','67',
'The equator does NOT pass through which of the following African countries?',
'[{"key":"A","text":"Gabon"},{"key":"B","text":"Cameroon"},{"key":"C","text":"Kenya"},{"key":"D","text":"Somalia"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q68','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','J&K Affairs','68',
'Which among the following districts of J&K is covered under the NAVYA (Nurturing Aspirations through Vocational training for Young Adolescent Girls) initiative?',
'[{"key":"A","text":"Baramulla"},{"key":"B","text":"Badgam"},{"key":"C","text":"Pulwama"},{"key":"D","text":"Kupwara"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q69','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','J&K Affairs','69',
'Consider the following statements about the Surinsar-Mansar lake:
Statement 1: It was designated as a Ramsar site in 2005.
Statement 2: This site does not host migratory birds.
Statement 3: It has a rich diversity of aquatic fauna.
Which of the above statement(s) is/are correct?',
'[{"key":"A","text":"Only 1 and 2"},{"key":"B","text":"Only 1 and 3"},{"key":"C","text":"Only 2 and 3"},{"key":"D","text":"All the statements are correct"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q70','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Geography','70',
'The longitudinal extent of India is:',
'[{"key":"A","text":"70°7'' E to 97°25'' E"},{"key":"B","text":"68°7'' E to 97°25'' E"},{"key":"C","text":"67°7'' E to 96°25'' E"},{"key":"D","text":"68°7'' E to 95°25'' E"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q71','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Economy','71',
'Consider the following statements regarding the Human Poverty Index (HPI) developed by the UNDP:
I. The HPI-1 measures human poverty in developing countries, focusing on deprivation in longevity, knowledge, and standard of living.
II. The HPI-2 measures human poverty in industrialised countries, incorporating an additional dimension of social exclusion.
III. The Human Poverty Index has been replaced by the Multidimensional Poverty Index (MPI) in the Human Development Reports since 2010.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q72','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Geography','72',
'Match the indigenous cattle breeds with their corresponding regions of origin in India:
Breed    — Region of Origin
a. Bargur  — i. Karnataka
b. Hallikar — ii. Kerala
c. Vechur   — iii. Tamil Nadu
d. Bachaur  — iv. Bihar
Choose the correct match:',
'[{"key":"A","text":"a-iii, b-i, c-ii, d-iv"},{"key":"B","text":"a-ii, b-iv, c-iii, d-i"},{"key":"C","text":"a-iv, b-ii, c-i, d-iii"},{"key":"D","text":"a-iii, b-iv, c-ii, d-i"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q73','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','History & Culture','73',
'Recently, archaeologists conducted the first-ever scientific dating of a sarcophagus (terracotta coffin), along with burial offerings such as carnelian beads indicating trade contacts with northern regions during the Harappan period. The newly discovered site is:',
'[{"key":"A","text":"Kilnamandi"},{"key":"B","text":"Adichanallur"},{"key":"C","text":"Sivagalai"},{"key":"D","text":"Rakhigarhi"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q74','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','74',
'Arrange the following Biosphere Reserves of India in the chronological order of their establishment:
1. Gulf of Mannar, Tamil Nadu
2. Simlipal, Odisha
3. Pachmarhi, Madhya Pradesh
4. Agasthyamalai, Tamil Nadu/Kerala
5. Kachchh, Gujarat
Choose the correct answer:',
'[{"key":"A","text":"Gulf of Mannar, Simlipal, Pachmarhi, Agasthyamalai, Kachchh"},{"key":"B","text":"Gulf of Mannar, Pachmarhi, Simlipal, Agasthyamalai, Kachchh"},{"key":"C","text":"Simlipal, Gulf of Mannar, Pachmarhi, Kachchh, Agasthyamalai"},{"key":"D","text":"Kachchh, Agasthyamalai, Pachmarhi, Simlipal, Gulf of Mannar"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q75','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','J&K Affairs','75',
'With reference to disaster management in India, consider the following statements regarding Operation Megh Rahat launched by the Indian Army in 2014:
I. It was a major Humanitarian Assistance and Disaster Relief (HADR) operation conducted in Jammu and Kashmir.
II. The operation was launched in response to severe landslides triggered by an earthquake.
III. It involved large-scale deployment of troops, engineering task forces, and helicopters to rescue civilians and restore essential infrastructure.
IV. The operation was jointly carried out by the state government in collaboration with non-governmental organizations (NGOs).
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I, II and III only"},{"key":"B","text":"I and III only"},{"key":"C","text":"I, III and IV only"},{"key":"D","text":"II, III and IV only"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q76','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','76',
'Consider the following statements:
Assertion (A): Heavier objects fall faster than lighter ones.
Reason (R): Acceleration due to gravity is independent of the mass of the object.
Select the correct answer from the options given below:',
'[{"key":"A","text":"Both A and R are correct and R is the correct explanation of A"},{"key":"B","text":"Both A and R are correct and R is NOT the correct explanation of A"},{"key":"C","text":"A is correct, but R is NOT correct"},{"key":"D","text":"A is NOT correct, but R is correct"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q77','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','77',
'Consider the following statements regarding light:
I. Reflection and refraction are optical phenomena.
II. Both reflection and refraction involve a change in the speed of light.
III. Refraction bends the path of light.
Which of the above statement(s) is/are correct?',
'[{"key":"A","text":"Only I and II are correct"},{"key":"B","text":"Only II and III are correct"},{"key":"C","text":"Only I and III are correct"},{"key":"D","text":"I, II and III are correct"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q78','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','78',
'Which of the following statements about viruses and bacteria is correct?',
'[{"key":"A","text":"Viruses can reproduce independently outside living cells."},{"key":"B","text":"Bacteria can live independently and reproduce by binary fission."},{"key":"C","text":"Both viruses and bacteria are multicellular organisms."},{"key":"D","text":"Viruses and bacteria are both visible under a light microscope."}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q79','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','79',
'Identify the correct match between digestive enzymes and the substances they act upon:
1. Amylase — carbohydrates
2. Lipase  — fats
3. Pepsin  — proteins
How many of the above matches is/are correct?',
'[{"key":"A","text":"Only one match"},{"key":"B","text":"Only two matches"},{"key":"C","text":"All three matches"},{"key":"D","text":"None of the matches"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q80','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','80',
'Consider the following statements regarding genetic material and cell divisions:
I. Genetic traits are carried by DNA.
II. RNA is a double-stranded molecule.
III. Mitosis leads to the formation of new cells, contributing to growth.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"Only I and II"},{"key":"B","text":"Only I and III"},{"key":"C","text":"Only II and III"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q81','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','81',
'Consider the following pairs:
Plant Hormone  — Function
1. Auxin        — Involved in phototropism
2. Cytokinin    — Stimulates cell division
3. Gibberellin  — Promotes stem elongation
4. Abscisic acid — Promotes seed dormancy
How many of the above pair(s) is/are correctly matched?',
'[{"key":"A","text":"Only one pair"},{"key":"B","text":"Only two pairs"},{"key":"C","text":"Only three pairs"},{"key":"D","text":"All four pairs"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q82','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','82',
'A satellite moving in a circular orbit around the Earth has which of the following characteristic?',
'[{"key":"A","text":"Zero acceleration"},{"key":"B","text":"Constant speed but changing velocity"},{"key":"C","text":"Constant velocity"},{"key":"D","text":"Decreasing energy"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q83','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Current Affairs','83',
'Who among the following was/were awarded the Nobel Prize posthumously?
I. Erik Axel Karlfeldt
II. Dag Hammarskjold
III. Pierre Curie
Choose the correct answer:',
'[{"key":"A","text":"Only I and II"},{"key":"B","text":"Only III"},{"key":"C","text":"I, II and III"},{"key":"D","text":"None of the above"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q84','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','84',
'Which of the following acts as the natural pacemaker of the human heart?',
'[{"key":"A","text":"AV node"},{"key":"B","text":"SA node"},{"key":"C","text":"Bundle of His"},{"key":"D","text":"Purkinje fibers"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q85','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','85',
'Consider the following statements regarding Diethylene Glycol (DEG):
I. It is an industrial solvent used in a variety of products, including antifreeze, brake fluid, and fabric and dye manufacturing.
II. The chemical is a standard ingredient in e-cigarette liquid.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q86','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','86',
'Consider the following statements regarding electricity:
I. Static electricity does not flow through wires.
II. Lightning is an example of static electricity.
III. Electric current is always static in nature.
Which of the above statement(s) is/are correct?',
'[{"key":"A","text":"Only I and II are correct"},{"key":"B","text":"Only II and III are correct"},{"key":"C","text":"Only I and III are correct"},{"key":"D","text":"I, II and III are correct"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q87','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','87',
'Pure water has a pH of 7 at which of the following temperatures?',
'[{"key":"A","text":"100°C"},{"key":"B","text":"51°C"},{"key":"C","text":"32°C"},{"key":"D","text":"25°C"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q88','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','88',
'Consider the following statements:
I. Diamond and graphite are allotropes of carbon.
II. Both diamond and graphite are good conductors of electricity.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q89','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Current Affairs','89',
'Which of the indigenous air defence systems was integrated with Akashteer during Operation Sindoor to automate low-level aerial threat response?',
'[{"key":"A","text":"Akash SAM"},{"key":"B","text":"Barak-8"},{"key":"C","text":"Prithvi Air Defence"},{"key":"D","text":"S-400"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q90','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','90',
'Consider the following statements regarding the Lion-tailed Macaque (Macaca silenus):
I. It is strictly arboreal in its habits.
II. It is endemic to the Western Ghats.
III. It is classified as "Critically Endangered" on the IUCN Red List and is protected under Schedule I of the Wildlife (Protection) Act, 1972.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I, II and III"},{"key":"B","text":"I and II only"},{"key":"C","text":"II and III only"},{"key":"D","text":"I and III only"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q91','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','91',
'Which of the following organisms breed only once in their lifetime (semelparous species)?
I. Pelagic fishes
II. Oysters
III. Pacific salmon fish
IV. Bamboo
Select the correct answer using the code given below:',
'[{"key":"A","text":"I, II and IV"},{"key":"B","text":"I and III"},{"key":"C","text":"II and IV"},{"key":"D","text":"III and IV"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q92','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','92',
'Recently, patches of coral reefs have been reported in which of the following locations in India?
I. Ratnagiri
II. Malvan and Redi
III. Gaveshani Bank
IV. South Bombay
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I, II and III"},{"key":"B","text":"II and III"},{"key":"C","text":"I, II, III and IV"},{"key":"D","text":"III and IV"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q93','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','93',
'Identify the States in India that have approved Plastic Parks:
I. Uttarakhand
II. Maharashtra
III. Madhya Pradesh
IV. Jharkhand
Which of the above statements is/are correct?',
'[{"key":"A","text":"I, II, III and IV"},{"key":"B","text":"I, III and IV only"},{"key":"C","text":"II, III and IV only"},{"key":"D","text":"I and III only"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q94','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','94',
'Which of the following birds exhibit brood parasitism?
I. Indigobird
II. Common Cuckoo
III. Honeyguide
IV. Eagle
V. Pigeon
VI. Cowbirds
Choose the correct answer:',
'[{"key":"A","text":"I, II, IV, V and VI"},{"key":"B","text":"II, III, IV and V"},{"key":"C","text":"I, V and VI"},{"key":"D","text":"I, II, III and VI"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q95','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Science & Technology','95',
'Consider the following statements:
I. Deep Ocean Mission, launched in 2021, focuses on sustainably harnessing ocean wealth and strengthening the Blue Economy, launched by the Ministry of Earth Sciences (MoES).
II. India''s first unmanned submersible vehicle MATSYA 6000 is being developed as part of the Samudrayaan Project under the Deep Ocean Mission.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q96','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','96',
'Find the correctly matched extinct species and their countries:
Species               — Country
1. Dodo               — 1. Mauritius
2. Quagga             — 2. Australia
3. Thylacine          — 3. Africa
4. Steller''s sea cow — 4. Russia
Which of the above pairs is/are correct?',
'[{"key":"A","text":"2 and 3 only"},{"key":"B","text":"1 and 4 only"},{"key":"C","text":"1, 3 and 4 only"},{"key":"D","text":"1, 2 and 4 only"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q97','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','97',
'International Big Cat Alliance (IBCA) became a treaty-based intergovernmental organization after ratification by five countries. Which of the following combinations is/are correct?',
'[{"key":"A","text":"India, Liberia, Eswatini, Ethiopia, and Nicaragua"},{"key":"B","text":"India, Liberia, Ethiopia, Somalia, and Nicaragua"},{"key":"C","text":"India, Ethiopia, Eswatini, Somalia, and Nicaragua"},{"key":"D","text":"India, Liberia, Eswatini, Somalia, and Nicaragua"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q98','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','98',
'Consider the following statements regarding Carbon Pricing:
I. Carbon pricing is a policy tool that puts a financial cost on greenhouse gas emissions, primarily methane.
II. It works by making emitters pay for the environmental damage caused by their pollution, encouraging them to reduce emissions.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q99','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Agriculture','99',
'Consider the following statements regarding cotton production and GM crops in India:
I. Bt. cotton is the only Genetically Modified (GM) crop approved for commercial cultivation in India.
II. India is the world''s third-largest cotton producer, after China and the United States.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('jkpsc-jkcce-2025-pre-gs1-q100','jkpsc','jkpsc-jkcce-prelims-2025-gs1-set-b','Jammu & Kashmir Public Service Commission','2025','GS Paper I (Set B)','Environment & Ecology','100',
'Consider the following statements:
I. The Montreux Record is maintained under the Ramsar Convention as part of the List of Wetlands of International Importance.
II. In India, Keoladeo National Park (Rajasthan) and Chilika Lake (Odisha) are currently included in the Montreux Record.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb);

COMMIT;
