-- BPSC 70th Combined Competitive Examination (Preliminary) 2024
-- General Studies — Booklet Series G (09/C/GO/CC/PT-2024(Q))
-- 150 questions · 150 marks · 120 minutes · 1/3 negative marking
-- Answer keys to be filled separately

BEGIN;

-- ── Exam ───────────────────────────────────────────────────────────────────────
INSERT INTO vaultcore.exams (slug, name, short_name, category, icon, total_questions, papers, mocks, description, popular_years, subjects)
VALUES (
  'bpsc',
  'Bihar Public Service Commission Combined Competitive Examination',
  'BPSC CCE',
  'State PSC',
  '🏛️',
  0, 1, 0,
  'Bihar Public Service Commission Combined Competitive Examination (BPSC CCE) selects candidates for Group A and Group B posts in Bihar government. The preliminary examination tests candidates on General Studies including History, Geography, Science, Polity, Economy, Current Affairs, Reasoning, and Bihar-specific topics.',
  '["2024","2023","2022"]'::jsonb,
  '["General Science","History","Geography","Indian Polity","Economy","Current Affairs","Reasoning","Bihar Studies"]'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name            = EXCLUDED.name,
  short_name      = EXCLUDED.short_name,
  description     = EXCLUDED.description,
  subjects        = EXCLUDED.subjects,
  popular_years   = EXCLUDED.popular_years,
  papers          = (SELECT COUNT(*) FROM vaultcore.papers WHERE exam_slug = 'bpsc') + 1,
  updated_at      = CURRENT_TIMESTAMP;

-- ── Paper ──────────────────────────────────────────────────────────────────────
INSERT INTO vaultcore.papers (slug, exam_slug, exam_name, title, year, shift, description, questions, subjects, negative_marking, duration_minutes, max_marks)
VALUES (
  'bpsc-70th-cce-prelims-2024-gs',
  'bpsc',
  'Bihar Public Service Commission Combined Competitive Examination',
  'BPSC 70th CCE Prelims 2024 — General Studies',
  '2024',
  'Booklet Series G',
  'Bihar Public Service Commission 70th Combined Competitive Examination (Preliminary) 2024 — General Studies paper (Code: 09/C/GO/CC/PT-2024(Q), Booklet Series G). 150 questions covering General Science, History, Geography, Indian Polity, Economy, Current Affairs, Reasoning, and Bihar-specific topics. Duration: 2 hours, Maximum Marks: 150, Negative marking: 1/3.',
  150,
  '["General Science","History","Geography","Indian Polity","Economy","Current Affairs","Reasoning","Bihar Studies"]'::jsonb,
  0.33,
  120,
  150
)
ON CONFLICT (slug) DO UPDATE SET
  title      = EXCLUDED.title,
  description = EXCLUDED.description,
  questions  = EXCLUDED.questions,
  updated_at = CURRENT_TIMESTAMP;

UPDATE vaultcore.papers SET held_on = '2024-12-13' WHERE slug = 'bpsc-70th-cce-prelims-2024-gs';

-- ── Questions ──────────────────────────────────────────────────────────────────
DELETE FROM vaultcore.questions WHERE paper_slug = 'bpsc-70th-cce-prelims-2024-gs';

INSERT INTO vaultcore.questions
  (slug, exam_slug, paper_slug, exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags)
VALUES

('bpsc-70th-cce-pre-2024-gs-q1','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','1',
'Dalton''s atomic theory successfully explained:
i. Law of conservation of mass.
ii. Law of constant composition.
iii. Law of radioactivity.
iv. Law of multiple proportion.',
'[{"key":"A","text":"ii, iii and iv"},{"key":"B","text":"i, ii and iii"},{"key":"C","text":"i, ii and iv"},{"key":"D","text":"i, iii and iv"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q2','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Geography','2',
'Which of the following is a technopolis?',
'[{"key":"A","text":"Silicon Valley"},{"key":"B","text":"London"},{"key":"C","text":"Paris"},{"key":"D","text":"Moscow"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q3','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','3',
'Which of the following acid is secreted in the stomach?',
'[{"key":"A","text":"Sulphuric acid"},{"key":"B","text":"Nitric acid"},{"key":"C","text":"Phosphoric acid"},{"key":"D","text":"Hydrochloric acid"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q4','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','4',
'Which of the following ruler ruled Assam in the time of Harsha?',
'[{"key":"A","text":"Aswad Jahan"},{"key":"B","text":"Bhaskar Varman"},{"key":"C","text":"King Dahir"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q5','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','5',
'When was the undersea cable-based Chennai-Andaman and Nicobar (CANI) Project inaugurated and dedicated to the nation by Prime Minister Shri Narendra Modi?',
'[{"key":"A","text":"August 15, 2022"},{"key":"B","text":"August 10, 2019"},{"key":"C","text":"January 26, 2023"},{"key":"D","text":"August 10, 2020"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q6','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','6',
'The meter that is used to measure the distance moved by the vehicle is known as',
'[{"key":"A","text":"Ammeter"},{"key":"B","text":"Speedometer"},{"key":"C","text":"Chronometer"},{"key":"D","text":"Odometer"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q7','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Indian Polity','7',
'Which Amendment to the Constitution abolished the two seats that were reserved for the Anglo-Indian community?',
'[{"key":"A","text":"108th"},{"key":"B","text":"100th"},{"key":"C","text":"102nd"},{"key":"D","text":"104th"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q8','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Reasoning','8',
'What should come in place of the question mark (?) in the following?

  16  21   7  |  10  15  ?
  36  16  64  |
  15  10  13  |  10  21  14',
'[{"key":"A","text":"22"},{"key":"B","text":"18"},{"key":"C","text":"36"},{"key":"D","text":"20"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q9','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Geography','9',
'Which of the following ports is an artificial port?',
'[{"key":"A","text":"Marmugao"},{"key":"B","text":"Mumbai"},{"key":"C","text":"Kochi"},{"key":"D","text":"Chennai"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q10','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','10',
'In April 2024, how many members of the UN Security Council either rejected or abstained from voting for the proposal to allow Palestine to become a full member of the UN?',
'[{"key":"A","text":"6"},{"key":"B","text":"2"},{"key":"C","text":"3"},{"key":"D","text":"5"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q11','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','11',
'In the Union Budget speech for 2024-25, which oilseeds were noted as not being covered under the goal of ''Atmanirbharta'' (self-reliance) for oil?',
'[{"key":"A","text":"Sesame"},{"key":"B","text":"Coconut"},{"key":"C","text":"Soybean"},{"key":"D","text":"Groundnut"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q12','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','12',
'Sheikh Ahmad Abdullah al-Ahmad al-Sabah was appointed as the new Prime Minister of which country in April 2024?',
'[{"key":"A","text":"Palestine"},{"key":"B","text":"Yemen"},{"key":"C","text":"Lebanon"},{"key":"D","text":"Kuwait"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q13','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','13',
'Match the following in context of the Pradhan of Ashta Pradhan system of Maratha rulers:

Official        Department
a. Sachiva      1. Prime Minister
b. Peshwa       2. Incharge of Correspondence
c. Samant       3. Finance Minister
d. Amatya       4. Foreign Minister',
'[{"key":"A","text":"a-2, b-1, c-4, d-3"},{"key":"B","text":"a-1, b-2, c-3, d-4"},{"key":"C","text":"a-3, b-4, c-1, d-2"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q14','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Economy','14',
'According to the Index of Industrial Production (IIP) data from the Ministry of Statistics and Programme Implementation, which indices experienced significant growth in Financial Year 2023?',
'[{"key":"A","text":"Consumer goods and infrastructure/construction goods"},{"key":"B","text":"Consumer goods and capital goods"},{"key":"C","text":"Manufacturing and consumer goods"},{"key":"D","text":"Capital goods and infrastructure/construction goods"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q15','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','15',
'Heat transfer that does not require a medium is called',
'[{"key":"A","text":"Radiation"},{"key":"B","text":"Reflection"},{"key":"C","text":"Conduction"},{"key":"D","text":"Convection"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q16','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','16',
'Which type of rock is formed from cooling and solidification of lava?',
'[{"key":"A","text":"Igneous"},{"key":"B","text":"Sedimentary"},{"key":"C","text":"Crystal"},{"key":"D","text":"Metamorphic"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q17','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','17',
'After elections to the 18th Lok Sabha, who was appointed as the Union Minister of Textiles in the Modi government?',
'[{"key":"A","text":"Giriraj Singh (Begusarai)"},{"key":"B","text":"Bhupendra Yadav (Alvar)"},{"key":"C","text":"Rajiv Ranjan Singh alias Lalan Singh (Munger)"},{"key":"D","text":"Gajendra Singh Shekhawat (Jodhpur)"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q18','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Geography','18',
'Which of the following human races inhabits in China, Mongolia and Japan?',
'[{"key":"A","text":"Australoid"},{"key":"B","text":"Negro"},{"key":"C","text":"Mongoloid"},{"key":"D","text":"Nordic"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q19','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','19',
'"Chach Nama" was translated to Persian by',
'[{"key":"A","text":"Nurrudin Muhammad Aufi"},{"key":"B","text":"Shams-i-Siraj"},{"key":"C","text":"Muhammad Ali Bin Abu Bakr Kufi"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q20','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','20',
'Which of the following represents the suitable condition for the liquefaction of gases?',
'[{"key":"A","text":"Low temperature, high pressure"},{"key":"B","text":"Low temperature, low pressure"},{"key":"C","text":"High temperature, high pressure"},{"key":"D","text":"High temperature, low pressure"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q21','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','21',
'Name the constituency from where the new Chief Minister of Odisha, Mohan Charan Majhi, was elected in the recent State Assembly elections.',
'[{"key":"A","text":"Laikera"},{"key":"B","text":"Keonjhar"},{"key":"C","text":"Telkoi"},{"key":"D","text":"Hinjili"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q22','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','22',
'To highlight the hardships faced by the peasants, Sahajanand Saraswati published which newspaper?',
'[{"key":"A","text":"Lok Sangraha"},{"key":"B","text":"The Broken Wing"},{"key":"C","text":"Indian Nation"},{"key":"D","text":"Nirbal Sevak"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q23','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Reasoning','23',
'How many times do the hands of a clock coincide in a day?',
'[{"key":"A","text":"23"},{"key":"B","text":"12"},{"key":"C","text":"24"},{"key":"D","text":"22"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q24','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','24',
'Which of the following is an iron ore?',
'[{"key":"A","text":"Cinnabar"},{"key":"B","text":"Bauxite"},{"key":"C","text":"Limonite"},{"key":"D","text":"Pyrite"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q25','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','25',
'Who was the founder of the Farazi Movement?',
'[{"key":"A","text":"Haji Shariatullah"},{"key":"B","text":"Sayyid Ahmad"},{"key":"C","text":"Dudhu Mian"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q26','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','26',
'Where was the top leader of Hamas, Ismail Haniyeh, assassinated on 31st July 2024, allegedly in an Israeli airstrike?',
'[{"key":"A","text":"Lebanon"},{"key":"B","text":"Palestine"},{"key":"C","text":"Iran"},{"key":"D","text":"Jordan"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q27','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Economy','27',
'According to a CRISIL Rating report, how much is the corporate bond market expected to grow by Financial Year 2030 in India?',
'[{"key":"A","text":"₹100-120 lakh crore"},{"key":"B","text":"₹50-70 lakh crore"},{"key":"C","text":"₹120-150 lakh crore"},{"key":"D","text":"₹70-90 lakh crore"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q28','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Geography','28',
'Following are the mountain ranges of India:
1. Garo Hills
2. Nandadevi
3. Kamet
4. K2
Which of the following is their correct sequence from east to west?',
'[{"key":"A","text":"3, 4, 2, 1"},{"key":"B","text":"4, 3, 1, 2"},{"key":"C","text":"2, 1, 4, 3"},{"key":"D","text":"1, 2, 3, 4"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q29','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','29',
'Match List-I with List-II:

List-I              List-II
a. Vaishali         1. Silk Textile
b. Bhagalpur        2. Gold
c. Jamui            3. Rail coach factory
d. Madhepura        4. Floriculture

Select the correct answer using the codes given below.',
'[{"key":"A","text":"a-2, b-3, c-4, d-1"},{"key":"B","text":"a-3, b-4, c-1, d-2"},{"key":"C","text":"a-4, b-1, c-2, d-3"},{"key":"D","text":"a-1, b-2, c-3, d-4"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q30','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','30',
'After remaining neutral for almost 200 years, which one of the following countries officially joined NATO in March 2024?',
'[{"key":"A","text":"Sweden"},{"key":"B","text":"North Macedonia"},{"key":"C","text":"Iceland"},{"key":"D","text":"Finland"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q31','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','31',
'Which component of fertilizer is used for stimulating early growth purpose?',
'[{"key":"A","text":"Potassium"},{"key":"B","text":"Nitrogen"},{"key":"C","text":"Oxygen"},{"key":"D","text":"Phosphorus"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q32','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','32',
'Malik Kafur also known as "Hazar Dinar" was bought by whom?',
'[{"key":"A","text":"Alauddin Khilji"},{"key":"B","text":"Ghiyasuddin Tughlaq"},{"key":"C","text":"Nusrat Khan"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q33','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','33',
'In which of the following years was the Bihar State Hydroelectric Power Corporation established?',
'[{"key":"A","text":"1992"},{"key":"B","text":"1982"},{"key":"C","text":"1998"},{"key":"D","text":"1990"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q34','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','34',
'Who wrote "New Lamps For The Old"?',
'[{"key":"A","text":"Surendranath Banerjee"},{"key":"B","text":"Aurobindo Ghosh"},{"key":"C","text":"Motilal Ghosh"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q35','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','35',
'What was the theme of the International Olympic Day 2024, which is celebrated every year on 23rd June?',
'[{"key":"A","text":"Together, For a Peaceful World"},{"key":"B","text":"Let''s Move"},{"key":"C","text":"Move, learn, discover - Together for a better world"},{"key":"D","text":"Let''s Move and Celebrate"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q36','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','36',
'Who was the President of the Indian National Congress at the Patna Session held in 1912?',
'[{"key":"A","text":"Saiyed Mohammad Bahadur"},{"key":"B","text":"Sir S. P. Sinha"},{"key":"C","text":"Saiyed Hassan Imam"},{"key":"D","text":"R. N. Madhulkar"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q37','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Reasoning','37',
'What is the 14th term of the sequence 14, 10, 6, 2, ... ?',
'[{"key":"A","text":"-42"},{"key":"B","text":"-34"},{"key":"C","text":"-46"},{"key":"D","text":"-38"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q38','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Economy','38',
'What were the shares of the Agriculture, Industry and Services sectors in overall GVA at current prices in Financial Year 2024 according to the Economic Survey 2023-24?',
'[{"key":"A","text":"17.7%, 27.6% and 54.7%"},{"key":"B","text":"18.7%, 28.6% and 52.7%"},{"key":"C","text":"17.7%, 28.6% and 53.7%"},{"key":"D","text":"16.7%, 26.6% and 56.7%"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q39','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','39',
'In which city of Bihar is the recently inaugurated National Dolphin Research Centre located?',
'[{"key":"A","text":"Darbhanga"},{"key":"B","text":"Patna"},{"key":"C","text":"Munger"},{"key":"D","text":"Gaya"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q40','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','40',
'Which of the following are the constituents of a soda acid fire extinguisher?',
'[{"key":"A","text":"Conc. sulphuric acid and aluminium sulphate"},{"key":"B","text":"Dil. sulphuric acid and sodium carbonate"},{"key":"C","text":"Dil. sulphuric acid and sodium bicarbonate solution"},{"key":"D","text":"Conc. sulphuric acid and sodium carbonate solution"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q41','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','41',
'Which of the following bacterial diseases is called as splenic fever?',
'[{"key":"A","text":"Typhoid"},{"key":"B","text":"Anthrax"},{"key":"C","text":"Cholera"},{"key":"D","text":"None of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q42','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','42',
'Where was the Japan-India bilateral Maritime Exercise (JIMEX-24) held in 2024?',
'[{"key":"A","text":"Yokosuka, Japan"},{"key":"B","text":"Bay of Bengal"},{"key":"C","text":"Western Pacific Ocean"},{"key":"D","text":"Vishakhapatnam, India"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q43','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','43',
'Ramkrishna Mission was founded by',
'[{"key":"A","text":"Vidyasagar in 1899"},{"key":"B","text":"Swami Vivekanand in 1899"},{"key":"C","text":"Swami Vivekanand in 1897"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q44','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Reasoning','44',
'In a certain code language COMPUTER is written as RFUVQNPC. How will MEDICINE be written in that code language?',
'[{"key":"A","text":"MFEDJOFM"},{"key":"B","text":"MFBDPDQF"},{"key":"C","text":"EOJDJEFM"},{"key":"D","text":"EOJDEJEM"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q45','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','45',
'Which of the following radiation is used to get relief from body aches?',
'[{"key":"A","text":"Infra-red radiation"},{"key":"B","text":"UV radiation"},{"key":"C","text":"Visible radiation"},{"key":"D","text":"None of these"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q46','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','46',
'Which of the following was the capital of the Chera dynasty?',
'[{"key":"A","text":"Kuravur/Karur"},{"key":"B","text":"Kanchipuram"},{"key":"C","text":"Madurai"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q47','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','47',
'The book critical of the British Policies "Gharib Hindustan" was banned in Bihar in 1930 by the British. It was written by',
'[{"key":"A","text":"Ali Mohd. Shad"},{"key":"B","text":"Mohd. Wali Hassan"},{"key":"C","text":"Badrul Hassan"},{"key":"D","text":"Shaikh Mian Jaan"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q48','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','48',
'What is the contribution of agriculture in the Gross Domestic Product (GDP) of Bihar?',
'[{"key":"A","text":"19%"},{"key":"B","text":"17%"},{"key":"C","text":"33%"},{"key":"D","text":"26%"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q49','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Economy','49',
'By how much did the Female Labour Force Participation Rate increase from 2017-18 to 2022-23, according to the National Sample Survey Office (NSSO)?',
'[{"key":"A","text":"From 25.3% to 35%"},{"key":"B","text":"From 23.3% to 37%"},{"key":"C","text":"From 23.3% to 33%"},{"key":"D","text":"From 20.3% to 30%"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q50','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','50',
'Which country took over the chairmanship of BRICS on January 1, 2024?',
'[{"key":"A","text":"India"},{"key":"B","text":"Russia"},{"key":"C","text":"South Africa"},{"key":"D","text":"Brazil"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q51','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','51',
'Which one of the following is an example of melamine used for making floor tiles?',
'[{"key":"A","text":"Polyethene"},{"key":"B","text":"Thermoplastics"},{"key":"C","text":"PVC"},{"key":"D","text":"Thermosetting plastic"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q52','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Reasoning','52',
'How many triangles are there in the figure PQRS given below?
[Figure: Rectangle PQRS divided into multiple triangles]',
'[{"key":"A","text":"16"},{"key":"B","text":"10"},{"key":"C","text":"18"},{"key":"D","text":"12"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q53','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Geography','53',
'Which of the following is a cause of rural to urban migration in India?',
'[{"key":"A","text":"High labour demand in cities"},{"key":"B","text":"Unbalanced rural-urban development"},{"key":"C","text":"Few jobs in rural areas"},{"key":"D","text":"All the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q54','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Economy','54',
'According to the Reserve Bank of India (RBI), what is the forecast for headline inflation in Financial Year 2025?',
'[{"key":"A","text":"5.0%"},{"key":"B","text":"4.1%"},{"key":"C","text":"5.5%"},{"key":"D","text":"4.5%"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q55','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','55',
'"The Hundred Years of Indian National Congress in Bihar" was edited by',
'[{"key":"A","text":"K. K. Dutta"},{"key":"B","text":"P. N. Ojha"},{"key":"C","text":"A. R. Desai"},{"key":"D","text":"B. B. Mishra"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q56','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','56',
'In which organisms does spore formation occur as a mode of reproduction?',
'[{"key":"A","text":"Fungi"},{"key":"B","text":"Algae"},{"key":"C","text":"Yeast"},{"key":"D","text":"Fern"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q57','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','57',
'When did the British shift the capital to Delhi?',
'[{"key":"A","text":"1912"},{"key":"B","text":"1913"},{"key":"C","text":"1911"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q58','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','58',
'Zoji-la Tunnel will connect which of the following places?',
'[{"key":"A","text":"Manali and Jammu"},{"key":"B","text":"Manali and Lahaul Spiti valley"},{"key":"C","text":"Srinagar and Leh"},{"key":"D","text":"Srinagar and Jammu"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q59','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','59',
'Who is the author of the autobiography "I Have the Streets: A Kutti Cricket Story"?',
'[{"key":"A","text":"S. Sreesanth"},{"key":"B","text":"Suresh Raina"},{"key":"C","text":"Rahul Dravid"},{"key":"D","text":"R. Ashwin and S. Monga"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q60','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','60',
'Where was the 13th Ministerial Conference of World Trade Organization (WTO) held in February 2024?',
'[{"key":"A","text":"Argentina"},{"key":"B","text":"Abu Dhabi"},{"key":"C","text":"Indonesia"},{"key":"D","text":"Switzerland"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q61','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Geography','61',
'Which one of the following rivers is different from the others?',
'[{"key":"A","text":"Tungabhadra"},{"key":"B","text":"Narmada"},{"key":"C","text":"Penganga"},{"key":"D","text":"Mahanadi"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q62','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Reasoning','62',
'If + means ÷, − means +, × means − and ÷ means ×, then find the value of:
(36 × 4) ÷ 8 − 4
─────────────────
4 + 8 × 2 + 16 ÷ 1',
'[{"key":"A","text":"10"},{"key":"B","text":"0"},{"key":"C","text":"12"},{"key":"D","text":"8"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q63','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','63',
'Which of the following is the first artificially prepared element?',
'[{"key":"A","text":"Te (Tellurium)"},{"key":"B","text":"Tc (Technetium)"},{"key":"C","text":"Th (Thorium)"},{"key":"D","text":"Tl (Thallium)"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q64','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Economy','64',
'What is the full form of CGTMSE?',
'[{"key":"A","text":"Credit Guarantee Fund Trust for Macro and Small Enterprises"},{"key":"B","text":"Credit Guarantee Fund Trust for Medium and Small Enterprises"},{"key":"C","text":"Credit Guarantee Fund Trust for Micro and Medium Enterprises"},{"key":"D","text":"Credit Guarantee Fund Trust for Micro and Small Enterprises"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q65','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','65',
'Who gave the slogan "DO OR DIE" and when?',
'[{"key":"A","text":"Subhash Chandra Bose during Quit India Movement"},{"key":"B","text":"Jawahar Lal Nehru during Non-cooperation Movement"},{"key":"C","text":"Gandhiji during Quit India Movement"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q66','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','66',
'Which of the following is the fluid part of the blood?',
'[{"key":"A","text":"WBC"},{"key":"B","text":"Plasma"},{"key":"C","text":"Blood platelets"},{"key":"D","text":"RBC"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q67','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','67',
'Consider the following about Ajivika sect:
a. Makhali Gosala was its most important leader.
b. Central idea of the philosophy was "NIYATI" that is fate.
c. The discrimination on the basis of caste and class.
d. The Ajivikas had regular sabhas for meetings.

Which of the following are correct?',
'[{"key":"A","text":"b, c and d are correct"},{"key":"B","text":"a, b and d are correct"},{"key":"C","text":"a and d are correct"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q68','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Geography','68',
'Which of the following minerals occurs in the Minas Gerais province of Brazil?',
'[{"key":"A","text":"Bauxite"},{"key":"B","text":"Iron ore"},{"key":"C","text":"Mica"},{"key":"D","text":"Coal"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q69','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','69',
'The first Hindi daily newspaper to be published in Bihar was',
'[{"key":"A","text":"Kshatriya Samachar"},{"key":"B","text":"Udyoga"},{"key":"C","text":"Sarwa Hitaishi"},{"key":"D","text":"Chaitanya Chandrika"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q70','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','70',
'Which of the following has a highly elongated elliptical orbit?',
'[{"key":"A","text":"Asteroid"},{"key":"B","text":"Comet"},{"key":"C","text":"Meteorite"},{"key":"D","text":"Meteor"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q71','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Reasoning','71',
'If February 1, 1996 is Wednesday, what day is March 3, 1996?',
'[{"key":"A","text":"Friday"},{"key":"B","text":"Sunday"},{"key":"C","text":"Saturday"},{"key":"D","text":"Monday"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q72','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','72',
'Name the place where Donald Trump was speaking at an election rally when an alleged shooter, Thomas Matthew Crooks, shot and injured him.',
'[{"key":"A","text":"Pennsylvania"},{"key":"B","text":"Milwaukee"},{"key":"C","text":"Texas"},{"key":"D","text":"Arizona"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q73','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','73',
'What is the position of India in manufacturing of mobile phones in 2023?',
'[{"key":"A","text":"10th"},{"key":"B","text":"2nd"},{"key":"C","text":"15th"},{"key":"D","text":"4th"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q74','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Geography','74',
'Which of the following cities is located along the side of river Seine?',
'[{"key":"A","text":"Paris"},{"key":"B","text":"Belgrade"},{"key":"C","text":"Lisbon"},{"key":"D","text":"Budapest"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q75','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Economy','75',
'According to the Reserve Bank of India, what is one of the eligibility criteria for a Small Finance Bank (SFB) to transition into a Universal Bank?',
'[{"key":"A","text":"Minimum net worth of ₹1,500 crore"},{"key":"B","text":"Minimum net worth of ₹500 crore"},{"key":"C","text":"Minimum net worth of ₹2,000 crore"},{"key":"D","text":"Minimum net worth of ₹1,000 crore"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q76','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','76',
'Match List-I with List-II and choose the correct answer:

Organization                Headquarter
I.  Swadeshi Sevak Home     a. Vancouver
II. United India House      b. Seattle
III. Yugantar Ashram        c. San Francisco
IV. INA or Azad Hind Fauj  d. Rangoon',
'[{"key":"A","text":"I-d, II-c, III-a, IV-b"},{"key":"B","text":"I-d, II-c, III-b, IV-a"},{"key":"C","text":"I-c, II-d, III-a, IV-b"},{"key":"D","text":"I-a, II-b, III-c, IV-d"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q77','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','77',
'When did Muslim League observe "Direct Action Day"?',
'[{"key":"A","text":"14 August 1946"},{"key":"B","text":"15 August 1947"},{"key":"C","text":"16 August 1946"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q78','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','78',
'In June 2024, which city was named India''s "First UNESCO City of Literature"?',
'[{"key":"A","text":"Delhi"},{"key":"B","text":"Kozhikode"},{"key":"C","text":"Varanasi"},{"key":"D","text":"Hyderabad"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q79','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','79',
'What is the structural and functional unit of life?',
'[{"key":"A","text":"Cell"},{"key":"B","text":"Organ"},{"key":"C","text":"Tissue"},{"key":"D","text":"Organism"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q80','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Reasoning','80',
'Gaurav walks 20 metres towards North. He then turns left and walks 40 metres. He again turns left and walks 20 metres. Further, he moves 20 metres after turning to the right. How far is he from his original position?',
'[{"key":"A","text":"40 metres"},{"key":"B","text":"20 metres"},{"key":"C","text":"60 metres"},{"key":"D","text":"30 metres"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q81','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Economy','81',
'Which one is NOT included in the Budget Priorities in pursuit of ''Vikasit Bharat'' in Union Budget 2024-25?',
'[{"key":"A","text":"Energy Security"},{"key":"B","text":"Productivity and Resilience in Agriculture"},{"key":"C","text":"Sustainable Development"},{"key":"D","text":"Employment and Skilling"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q82','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','82',
'Which of the following drainage systems drains the lands of Bihar?',
'[{"key":"A","text":"Ghagra"},{"key":"B","text":"Mahanadi"},{"key":"C","text":"Yamuna"},{"key":"D","text":"Narmada"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q83','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','83',
'Consider the types of land according to the Amarkosha:
a. Urvara — fertile
b. Maru — desert
c. Shadvala — grassy
d. Devmatrika — watered by rain

Which of the following is correct?',
'[{"key":"A","text":"a and b both"},{"key":"B","text":"c and d both"},{"key":"C","text":"b, c and d"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q84','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Indian Polity','84',
'Under Article 243J, which of the following can make provisions for the maintenance of accounts by Panchayats?',
'[{"key":"A","text":"Parliament"},{"key":"B","text":"State Legislature"},{"key":"C","text":"District Collector"},{"key":"D","text":"State Finance Commission"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q85','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','85',
'Which of the following is a non-contact force?',
'[{"key":"A","text":"Magnetic force"},{"key":"B","text":"Frictional force"},{"key":"C","text":"Impact force"},{"key":"D","text":"None of these"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q86','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Reasoning','86',
'Motorcycle is related to Battery in the same way as Life is related to',
'[{"key":"A","text":"Moon"},{"key":"B","text":"Earth"},{"key":"C","text":"Star"},{"key":"D","text":"Sun"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q87','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','87',
'Consider the following about the King "Pravarasena":
a. He was the real founder of Vakataka dynasty.
b. His empire extended from Bundelkhand in the north to Hyderabad in the south.
c. He succeeded his father king Vindhyashakti.
d. He is mentioned in Puranas.

Which of the following statements are correct?',
'[{"key":"A","text":"a and b both"},{"key":"B","text":"a and c both"},{"key":"C","text":"b, c and d"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q88','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','88',
'Match the following and choose the correct answer:

Newspaper           Editor
I.   Free Hindustan  a. Mahatma Gandhi
II.  Indian Opinion  b. Dadabhai Naoroji
III. Voice of India  c. Surendranath Banerjee
IV.  Bengalee        d. Taraknath Das',
'[{"key":"A","text":"I-c, II-d, III-a, IV-b"},{"key":"B","text":"I-d, II-a, III-b, IV-c"},{"key":"C","text":"I-c, II-a, III-d, IV-b"},{"key":"D","text":"I-d, II-c, III-b, IV-a"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q89','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','89',
'In which one of the following freestyle weight categories did Aman Sehrawat become the first Indian male wrestler to qualify for the 2024 Paris Olympics at the World Wrestling Olympic Qualifiers, Turkiye in May 2024?',
'[{"key":"A","text":"86 kg"},{"key":"B","text":"65 kg"},{"key":"C","text":"74 kg"},{"key":"D","text":"57 kg"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q90','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','90',
'Which of the following districts of Bihar has the highest percentage of Scheduled Tribe population in the 2011 census?',
'[{"key":"A","text":"Katihar"},{"key":"B","text":"Jamui"},{"key":"C","text":"Purnia"},{"key":"D","text":"Banka"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q91','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','91',
'Which sector received the highest allocation in the Bihar Budget 2024-25?',
'[{"key":"A","text":"Agriculture"},{"key":"B","text":"Health"},{"key":"C","text":"Infrastructure"},{"key":"D","text":"Education"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q92','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Reasoning','92',
'Choose the group of letters which is different from others.',
'[{"key":"A","text":"ORUX"},{"key":"B","text":"PSVX"},{"key":"C","text":"CFIL"},{"key":"D","text":"JMPS"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q93','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','93',
'For which of the following metals are corundum and cryolite important ores?',
'[{"key":"A","text":"Aluminium"},{"key":"B","text":"Silver"},{"key":"C","text":"Tin"},{"key":"D","text":"Iron"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q94','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Indian Polity','94',
'What is the eligibility age, after the changes made in March 2024, for senior citizens to vote by postal ballot?',
'[{"key":"A","text":"85 years"},{"key":"B","text":"80 years"},{"key":"C","text":"82 years"},{"key":"D","text":"90 years"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q95','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Geography','95',
'Which of the following states of India has major reserves of coal?',
'[{"key":"A","text":"Jharkhand"},{"key":"B","text":"Chhattisgarh"},{"key":"C","text":"Odisha"},{"key":"D","text":"All the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q96','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Indian Polity','96',
'Which two words have been incorporated in the Preamble by the 42nd Amendment?',
'[{"key":"A","text":"Democratic and Socialist"},{"key":"B","text":"Republic and Secular"},{"key":"C","text":"Socialist and Sovereign"},{"key":"D","text":"Secular and Socialist"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q97','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','97',
'In which Lok Sabha seat did one of India''s Particularly Vulnerable Tribal Groups (PVTGs), the Shompen tribe, for the first time exercise their democratic right to vote in April 2024?',
'[{"key":"A","text":"Tripura East"},{"key":"B","text":"Vizianagram, Andhra Pradesh"},{"key":"C","text":"Tura"},{"key":"D","text":"Andaman and Nicobar"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q98','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','98',
'What was the Per Capita Net State Domestic Product at Current Prices for Bihar for the fiscal year 2022-23, based on the base year 2011-12?',
'[{"key":"A","text":"₹54,111"},{"key":"B","text":"₹42,083"},{"key":"C","text":"₹61,434"},{"key":"D","text":"₹47,498"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q99','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','99',
'Which of the following centres in Bihar is proposed to be developed under Vishnupad Yojana for promotion of tourism in Union Budget 2024?',
'[{"key":"A","text":"Nalanda"},{"key":"B","text":"Rajgir"},{"key":"C","text":"Vaishali"},{"key":"D","text":"Gaya"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q100','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','100',
'Match the following and choose the correct answer:

Political Organisation   Founder
I.   Khaksars            a. Subhash Chandra Bose
II.  Socialist Party     b. Inayatullah Mashriqui
III. Independent Labour Party  c. Jayaprakash Narayan
IV.  Forward Bloc        d. B. R. Ambedkar',
'[{"key":"A","text":"I-b, II-d, III-a, IV-c"},{"key":"B","text":"I-b, II-c, III-d, IV-a"},{"key":"C","text":"I-c, II-d, III-a, IV-b"},{"key":"D","text":"I-d, II-c, III-b, IV-a"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q101','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','101',
'Before his appointment as a judge of the Supreme Court of India in July 2024, Justice N. Kotiswar Singh was the Chief Justice of which High Court?',
'[{"key":"A","text":"Jammu and Kashmir and Ladakh High Court"},{"key":"B","text":"Madras High Court"},{"key":"C","text":"Bombay High Court"},{"key":"D","text":"Gauhati High Court"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q102','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','102',
'The Sikh pilgrimage site "Takhat Sri Harimandir Ji Patna Sahib", which is considered the second holiest Takhat, is located at',
'[{"key":"A","text":"Bhagalpur"},{"key":"B","text":"Gaya"},{"key":"C","text":"Patna"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q103','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','103',
'Bihula Festival is celebrated especially in which one of the following districts in Bihar, usually in the month of August each year?',
'[{"key":"A","text":"Bhagalpur"},{"key":"B","text":"Patna"},{"key":"C","text":"Sitamarhi"},{"key":"D","text":"Darbhanga"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q104','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','104',
'Which of the following represents the resistance of a wire (Ohm''s law)?',
'[{"key":"A","text":"R = I × V"},{"key":"B","text":"R = V²"},{"key":"C","text":"R = V/I"},{"key":"D","text":"R = I/V"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q105','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Indian Polity','105',
'Which Article of the Constitution restricts a Member of Parliament from holding an office of profit?',
'[{"key":"A","text":"Article 102 (1) (c)"},{"key":"B","text":"Article 102 (1) (b)"},{"key":"C","text":"Article 102 (1) (d)"},{"key":"D","text":"Article 102 (1) (a)"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q106','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','106',
'Which of the following great rulers founded the "Haryanka Vansh" in ancient Bihar?',
'[{"key":"A","text":"Bimbisara"},{"key":"B","text":"Brihadrath"},{"key":"C","text":"Ajatashatru"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q107','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','107',
'Which one of the following is true about Ruchira Kamboj, who was the first woman to become the Indian Ambassador to the United Nations and recently retired?',
'[{"key":"A","text":"She was a member of the NITI Aayog"},{"key":"B","text":"She was a member of Indian Council of World Affairs"},{"key":"C","text":"She held the position of Permanent Representative of India to UNESCO Paris"},{"key":"D","text":"She was the first woman Indian Ambassador to USA"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q108','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','108',
'Which of the following are exothermic processes?
i.  Evaporation of water.
ii. Dilution of an acid (H₂SO₄).
iii. Reaction of water with quick lime.
iv. Sublimation of camphor (crystals).',
'[{"key":"A","text":"iii and iv"},{"key":"B","text":"ii and iii"},{"key":"C","text":"i and iv"},{"key":"D","text":"i and ii"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q109','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Indian Polity','109',
'What is the object of "cut motion" in Parliament?',
'[{"key":"A","text":"To move a proposal to reduce expenditure in the budget proposals"},{"key":"B","text":"To restrict day-to-day financial expenditure of the government"},{"key":"C","text":"To restrict grants from the Consolidated Fund of India"},{"key":"D","text":"To restrict the grants of the Government"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q110','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','110',
'Who presented the Bihar Budget 2024-25 in the State Assembly?',
'[{"key":"A","text":"Shri Vijay Sinha"},{"key":"B","text":"Shri Nitish Kumar"},{"key":"C","text":"Shri Vijay Kumar Choudhary"},{"key":"D","text":"Shri Samrat Choudhary"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q111','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','111',
'When did the new province of Bihar come into force during British rule?',
'[{"key":"A","text":"April 1912"},{"key":"B","text":"April 1911"},{"key":"C","text":"March 1912"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q112','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','112',
'Who headed the Royal Commission on Indian currency appointed in 1913?',
'[{"key":"A","text":"James Wilson"},{"key":"B","text":"J. M. Keynes"},{"key":"C","text":"Sir Austin Chamberlain"},{"key":"D","text":"Sir W. R. Mansfield"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q113','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','113',
'Which of the following is the value of the solar constant?',
'[{"key":"A","text":"1.6 kW/m²"},{"key":"B","text":"1.4 kW/m²"},{"key":"C","text":"1.2 kW/m²"},{"key":"D","text":"1.8 kW/m²"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q114','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','114',
'Which of the following was NOT one of the features of the Government of India Act, 1935?',
'[{"key":"A","text":"Reconstruction of the Governor-General''s Executive Council"},{"key":"B","text":"Provincial Autonomy"},{"key":"C","text":"Appraisal of the Act of 1935"},{"key":"D","text":"Proposal for Federation of India"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q115','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Indian Polity','115',
'What is the current position of representation of the Anglo-Indian Community in Lok Sabha?',
'[{"key":"A","text":"Nomination of them has been done away with by the 104th Constitutional Amendment"},{"key":"B","text":"Two Anglo-Indians are nominated by the President"},{"key":"C","text":"They are nominated as per their population"},{"key":"D","text":"One Anglo-Indian is nominated by the President"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q116','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','116',
'Which community was categorized as Scheduled Caste (SC) by a 2015 Bihar government notification, which was quashed in July 2024 by the Supreme Court, ruling that states cannot make changes to the SC list published under Article 341 of the Constitution?',
'[{"key":"A","text":"Lal Begi"},{"key":"B","text":"Tanti-Tantwa"},{"key":"C","text":"Pano"},{"key":"D","text":"Dabgar"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q117','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','117',
'Who won the Men''s Singles title at the French Open Tennis Tournament 2024?',
'[{"key":"A","text":"Novak Djokovic"},{"key":"B","text":"Alexander Zverev"},{"key":"C","text":"Daniil Medvedev"},{"key":"D","text":"Carlos Alcaraz"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q118','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','118',
'Who among the following achieved the distinction of being the first Indian mountaineer to scale Mount Everest and Mount Lhotse twice in one season?',
'[{"key":"A","text":"Satyadeep Gupta"},{"key":"B","text":"Sunil Rohilla"},{"key":"C","text":"Premlata Agarwal"},{"key":"D","text":"Kaamya Karthikeyan"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q119','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','119',
'What is the sex ratio in Bihar as per the Census 2011 of India?',
'[{"key":"A","text":"918"},{"key":"B","text":"916"},{"key":"C","text":"933"},{"key":"D","text":"922"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q120','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','120',
'For which of the following functions is chlorophyll used in photosynthesis?',
'[{"key":"A","text":"Reduction of CO₂"},{"key":"B","text":"Breaking down water molecules"},{"key":"C","text":"No function"},{"key":"D","text":"Absorbing light"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q121','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','121',
'The political strategy Struggle-Truce-Struggle (S-T-S) came into prominence with a call for',
'[{"key":"A","text":"Swadeshi Movement"},{"key":"B","text":"Quit India"},{"key":"C","text":"Boycott of Simon Commission"},{"key":"D","text":"Khilafat issue"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q122','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','122',
'During the Quit India Movement, parallel "National Governments" were established at many places. Which of the following is NOT correctly matched?',
'[{"key":"A","text":"Raiyati Sarkar – Kheda (Gujarat)"},{"key":"B","text":"Prati Sarkar – Satara (Maharashtra)"},{"key":"C","text":"Praja Mandal – Talchar (Orissa)"},{"key":"D","text":"Jatiy Sarkar – Tamluk (Bengal)"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q123','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','123',
'Which of the following is equivalent to Tesla (unit of magnetic field)?',
'[{"key":"A","text":"Ampere per Newton"},{"key":"B","text":"Newton per Coulomb"},{"key":"C","text":"Newton per ampere-second"},{"key":"D","text":"Newton per ampere-metre"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q124','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','124',
'Which dynasty ruled Magadh (Bihar) after the Shishunaga dynasty?',
'[{"key":"A","text":"Maurya Vansh"},{"key":"B","text":"Sunga Vansh"},{"key":"C","text":"Nanda Vansh"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q125','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Indian Polity','125',
'Among the following, who has been Speaker of Lok Sabha prior to his election as President of India?',
'[{"key":"A","text":"Giani Zail Singh"},{"key":"B","text":"V. V. Giri"},{"key":"C","text":"Neelam Sanjeeva Reddy"},{"key":"D","text":"A. P. J. Abdul Kalam"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q126','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','126',
'When did Bihar State introduce the Green Budget for the first time?',
'[{"key":"A","text":"Financial Year 2020-21"},{"key":"B","text":"Financial Year 2018-19"},{"key":"C","text":"Financial Year 2021-22"},{"key":"D","text":"Financial Year 2019-20"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q127','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','127',
'Manvi Madhu Kashyap recently became Bihar''s first transgender',
'[{"key":"A","text":"Havildar in Bihar Regiment"},{"key":"B","text":"Bus Driver in state transport"},{"key":"C","text":"Traffic Police Inspector"},{"key":"D","text":"Sub-Inspector of Police"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q128','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','128',
'Which of the following is a zaid (summer/short-season) crop?',
'[{"key":"A","text":"Gram"},{"key":"B","text":"Fodder"},{"key":"C","text":"Mustard"},{"key":"D","text":"Cotton"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q129','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','129',
'Shreyasi Singh, Member of the Legislative Assembly, who represented India in shooting at the Paris Olympics 2024, was elected from which constituency in Bihar?',
'[{"key":"A","text":"Sugauli"},{"key":"B","text":"Gidhaur"},{"key":"C","text":"Jamui"},{"key":"D","text":"Kesaria"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q130','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','130',
'What was the chief economic foundation of the triangular commerce between India, China and England?',
'[{"key":"A","text":"Silk"},{"key":"B","text":"Opium"},{"key":"C","text":"Black pepper"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q131','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Economy','131',
'What is the full form of PCRA?',
'[{"key":"A","text":"Partial Counting of Remaining Amendment"},{"key":"B","text":"Public Conservations Research Association"},{"key":"C","text":"Petroleum Conservation Research Association"},{"key":"D","text":"Public Council of Research Association"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q132','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','132',
'In October 1943, Subhash Chandra Bose set up a provisional government of free India which was recognized by how many countries including Japan?',
'[{"key":"A","text":"4"},{"key":"B","text":"5"},{"key":"C","text":"10"},{"key":"D","text":"9"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q133','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','133',
'What is the title of the film by Payal Kapadia for which she became the first Indian filmmaker to win the Grand Prix Award at the Cannes Film Festival in May 2024?',
'[{"key":"A","text":"All We Imagine as Light"},{"key":"B","text":"The Shameless"},{"key":"C","text":"The Man Who Could Not Remain Silent"},{"key":"D","text":"Sunflowers Were the First Ones to Know"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q134','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','134',
'Which part of the alimentary canal receives bile from the liver?',
'[{"key":"A","text":"Stomach"},{"key":"B","text":"Oesophagus"},{"key":"C","text":"Small intestine"},{"key":"D","text":"Large intestine"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q135','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Indian Polity','135',
'The Indian National Flag was adopted by the Constituent Assembly on which date?',
'[{"key":"A","text":"26 November 1950"},{"key":"B","text":"24 January 1950"},{"key":"C","text":"26 January 1950"},{"key":"D","text":"22 July 1947"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q136','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Indian Polity','136',
'The size of the Council of Ministers has been restricted to 15 percent of the membership of the Lok Sabha by which Constitutional Amendment?',
'[{"key":"A","text":"92nd Amendment"},{"key":"B","text":"95th Amendment"},{"key":"C","text":"91st Amendment"},{"key":"D","text":"93rd Amendment"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q137','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','137',
'Who is the winner of the prestigious Goldman Environmental Prize 2024 from the region of Asia?',
'[{"key":"A","text":"Thai Van Nguyen, Vietnam"},{"key":"B","text":"Alok Shukla, India"},{"key":"C","text":"Chibeze Ezekiel, Ghana"},{"key":"D","text":"Delima Silalahi, Indonesia"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q138','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','138',
'Under the Royal Titles Act, Queen Victoria became the Empress of India in',
'[{"key":"A","text":"1875"},{"key":"B","text":"1874"},{"key":"C","text":"1877"},{"key":"D","text":"1876"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q139','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','139',
'Which of the following pairs will give displacement reactions?',
'[{"key":"A","text":"AgNO₃ solution and copper metal"},{"key":"B","text":"NaCl solution and copper metal"},{"key":"C","text":"FeSO₄ solution and silver metal"},{"key":"D","text":"MgCl₂ solution and aluminium metal"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q140','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Geography','140',
'The Andes mountain range extends along which of the following?',
'[{"key":"A","text":"West Coast of India"},{"key":"B","text":"West Coast of North America"},{"key":"C","text":"East Coast of Australia"},{"key":"D","text":"West Coast of South America"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q141','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Indian Polity','141',
'By which time must the Governor return an ordinary bill to the concerned State Legislature for reconsideration?',
'[{"key":"A","text":"Three months"},{"key":"B","text":"One month"},{"key":"C","text":"No time limit"},{"key":"D","text":"Two months"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q142','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','142',
'What is the current profession of the young UP woman, Arti, who was conferred the Amal Clooney Women''s Empowerment Award by King Charles III in May 2024?',
'[{"key":"A","text":"ASHA (Accredited Social Health Activist) worker"},{"key":"B","text":"Farm labourer"},{"key":"C","text":"Chikan-kari artisan"},{"key":"D","text":"E-rickshaw driver"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q143','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','143',
'The process of breaking down organic matter by micro-organisms is called',
'[{"key":"A","text":"Respiration"},{"key":"B","text":"Photosynthesis"},{"key":"C","text":"Decomposition"},{"key":"D","text":"Fermentation"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q144','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','History','144',
'Who among the following Indian capitalists was NOT an architect of the "Bombay Plan"?',
'[{"key":"A","text":"Dhirubhai Ambani"},{"key":"B","text":"J. R. D. Tata"},{"key":"C","text":"Sri Ram"},{"key":"D","text":"G. D. Birla"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q145','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Current Affairs','145',
'Which country became the first to bring soil from the far side (dark side) of the Moon in June 2024?',
'[{"key":"A","text":"USA"},{"key":"B","text":"China"},{"key":"C","text":"France"},{"key":"D","text":"India"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q146','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','146',
'What is the name of the one-month-long cattle fair organised at the confluence of the Ganga and Gandak rivers?',
'[{"key":"A","text":"Katihar Mela"},{"key":"B","text":"Sonepur Mela"},{"key":"C","text":"Purnia Mela"},{"key":"D","text":"More than one of the above"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q147','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Indian Polity','147',
'Who decides the disqualification of members of a State Legislative Assembly for matters other than those in the Tenth Schedule of the Constitution?',
'[{"key":"A","text":"Governor"},{"key":"B","text":"Speaker of the Legislative Assembly"},{"key":"C","text":"State Election Commission"},{"key":"D","text":"High Court"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q148','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','148',
'Which of the following is a major cause of air pollution?',
'[{"key":"A","text":"Disposal of plastics"},{"key":"B","text":"Burning of fossil fuels"},{"key":"C","text":"Deforestation"},{"key":"D","text":"Excessive use of pesticides"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q149','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','Bihar Studies','149',
'Munger Hilly region is a part of which of the following physiographic regions?',
'[{"key":"A","text":"Southern Hilly Region"},{"key":"B","text":"North Bihar Plain"},{"key":"C","text":"Someshwar Hilly Range"},{"key":"D","text":"South Bihar Plain"}]'::jsonb,
'','','','[]'::jsonb),

('bpsc-70th-cce-pre-2024-gs-q150','bpsc','bpsc-70th-cce-prelims-2024-gs','Bihar Public Service Commission Combined Competitive Examination','2024','GS 2024 (Series G)','General Science','150',
'Who was the first one to propose a model for the structure of an atom?',
'[{"key":"A","text":"E. Goldstein"},{"key":"B","text":"Rutherford"},{"key":"C","text":"Niels Bohr"},{"key":"D","text":"J. J. Thomson"}]'::jsonb,
'','','','[]'::jsonb);

-- Update exam counts
UPDATE vaultcore.exams SET
  papers = (SELECT COUNT(*) FROM vaultcore.papers WHERE exam_slug = 'bpsc'),
  total_questions = (SELECT COUNT(*) FROM vaultcore.questions WHERE exam_slug = 'bpsc'),
  updated_at = CURRENT_TIMESTAMP
WHERE slug = 'bpsc';

COMMIT;
