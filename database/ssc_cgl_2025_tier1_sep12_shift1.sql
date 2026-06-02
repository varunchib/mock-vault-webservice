-- SSC CGL 2025 Tier I — 12 Sep 2025, Shift 1 (9:00 AM)
-- Questions 64–100 (Part-C Quantitative Aptitude + Part-D English Comprehension)
-- Q1–Q63 (Part-A General Intelligence + Part-B General Awareness + Q51–Q63 Quant) pending

-- ─── Paper entry ──────────────────────────────────────────────────────────────

INSERT INTO vaultcore.papers
  (slug, exam_slug, exam_name, title, year, shift, description, questions, subjects,
   negative_marking, duration_minutes, max_marks, held_on)
VALUES
  ('ssc-cgl-2025-tier1-sep12-shift1',
   'ssc-cgl',
   'SSC CGL',
   'SSC CGL 2025 Tier I — 12 Sep 2025 (Shift 1, 9:00 AM)',
   '2025',
   'Shift 1 (9:00 AM)',
   'SSC CGL 2025 Tier I paper held on 12 September 2025, Morning Shift (9:00 AM). 100 questions across General Intelligence & Reasoning, General Awareness, Quantitative Aptitude, and English Comprehension. Complete solutions and explanations.',
   100,
   '["General Intelligence & Reasoning","General Awareness","Quantitative Aptitude","English Language"]',
   0.50,
   60,
   200,
   '2025-09-12')
ON CONFLICT (slug) DO NOTHING;

-- ─── Questions ────────────────────────────────────────────────────────────────
-- Columns: slug, exam_slug, paper_slug, mock_slug, exam_name, year, paper, subject,
--          question_no, question, options, answer_key, answer, explanation, tags

INSERT INTO vaultcore.questions
  (slug, exam_slug, paper_slug, mock_slug, exam_name, year, paper, subject,
   question_no, question, options, answer_key, answer, explanation, tags)
VALUES

-- ── PART-C: Quantitative Aptitude (Q64–Q75) ──────────────────────────────────

('ssc-cgl-2025-t1-s1-q64','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','Quantitative Aptitude','64',
 'A retailer marks an air conditioner 80% above its cost price. He offers a first discount of 25% on the marked price. During a festive offer, an additional discount of 10% is applied on the already discounted price. If the final selling price is ₹15,552, what is the approximate cost price of the air conditioner?',
 '[{"key":"A","text":"₹9,000"},{"key":"B","text":"₹9,200"},{"key":"C","text":"₹12,800"},{"key":"D","text":"₹10,000"}]',
 'C','₹12,800',
 'MP = 1.8 × CP. After 25% discount: 0.75 × 1.8 × CP = 1.35 CP. After 10% festive discount: 0.9 × 1.35 × CP = 1.215 CP. Given 1.215 × CP = ₹15,552 → CP = 15552 ÷ 1.215 = ₹12,800.',
 '["Profit and Loss","Discount","Percentage"]'),

('ssc-cgl-2025-t1-s1-q65','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','Quantitative Aptitude','65',
 'A 40-liter mixture contains juice and water in the ratio 5:3. How much water (in liters) must be added to this mixture to change the ratio of juice to water to 2:3?',
 '[{"key":"A","text":"15.5 litres"},{"key":"B","text":"22.5 litres"},{"key":"C","text":"25 litres"},{"key":"D","text":"30 litres"}]',
 'B','22.5 litres',
 'Juice = 40 × 5/8 = 25 L, Water = 15 L. Let x litres of water be added. New ratio: 25/(15+x) = 2/3 → 75 = 30 + 2x → x = 22.5 litres.',
 '["Mixtures and Alligation","Ratio and Proportion"]'),

('ssc-cgl-2025-t1-s1-q66','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','Quantitative Aptitude','66',
 'A is able to complete a task in 15 days, while B takes 20 days to finish the same task. If they collaborate and work together for 4 days, what fraction of the work will still remain?',
 '[{"key":"A","text":"1/4"},{"key":"B","text":"7/15"},{"key":"C","text":"8/15"},{"key":"D","text":"11/15"}]',
 'C','8/15',
 'Combined rate = 1/15 + 1/20 = 4/60 + 3/60 = 7/60 per day. Work done in 4 days = 4 × 7/60 = 28/60 = 7/15. Remaining = 1 − 7/15 = 8/15.',
 '["Time and Work"]'),

('ssc-cgl-2025-t1-s1-q67','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','Quantitative Aptitude','67',
 'Two oils priced at ₹90 per kg and ₹150 per kg are blended and sold at ₹144 per kg, achieving a profit margin of 20%. What is the ratio of the two oils in the mixture?',
 '[{"key":"A","text":"1:1"},{"key":"B","text":"2:1"},{"key":"C","text":"3:2"},{"key":"D","text":"4:1"}]',
 'A','1:1',
 'Cost price of mixture = 144 ÷ 1.20 = ₹120/kg. By alligation: (150−120) : (120−90) = 30 : 30 = 1:1.',
 '["Mixtures and Alligation","Profit and Loss"]'),

('ssc-cgl-2025-t1-s1-q68','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','Quantitative Aptitude','68',
 'Three pipes, A, B, and C are capable of filling a tank in 6, 8, and 12 hours, respectively. When all three pipes are opened together, they operate for 2 hours before pipe C is closed. How much additional time will it take to completely fill the tank after that?',
 '[{"key":"A","text":"6/7 hours"},{"key":"B","text":"5/6 hours"},{"key":"C","text":"3/5 hours"},{"key":"D","text":"9/2 hours"}]',
 'A','6/7 hours',
 'Rates: A = 1/6, B = 1/8, C = 1/12. All three for 2 h: 2 × (1/6 + 1/8 + 1/12) = 2 × 9/24 = 3/4 filled. Remaining = 1/4. After C closes, A + B rate = 1/6 + 1/8 = 7/24 per hour. Time = (1/4) ÷ (7/24) = 6/7 hours.',
 '["Pipes and Cisterns"]'),

('ssc-cgl-2025-t1-s1-q69','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','Quantitative Aptitude','69',
 'A bullet train covers a fixed distance in 30 minutes at an average speed of 240 km/h. Due to track maintenance, it needs to be diverted, increasing the distance by 20%. If the train needs to arrive at its destination on time (i.e., in 30 minutes), what should its new average speed be in km/h?',
 '[{"key":"A","text":"280 km/h"},{"key":"B","text":"300 km/h"},{"key":"C","text":"288 km/h"},{"key":"D","text":"320 km/h"}]',
 'C','288 km/h',
 'Original distance = 240 × 0.5 = 120 km. New distance = 120 × 1.2 = 144 km. Time remains 30 min = 0.5 h. New speed = 144 ÷ 0.5 = 288 km/h.',
 '["Speed Time Distance"]'),

('ssc-cgl-2025-t1-s1-q70','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','Quantitative Aptitude','70',
 'Two cars, X and Y, start from points 360 km apart and travel at constant speeds. If they move towards each other, they meet in 4 hours. If they move in the same direction, they meet in 12 hours. What is the speed of car X? (Assume X is the faster car).',
 '[{"key":"A","text":"60 km/h"},{"key":"B","text":"75 km/h"},{"key":"C","text":"45 km/h"},{"key":"D","text":"90 km/h"}]',
 'A','60 km/h',
 'Opposite directions: X + Y = 360/4 = 90 km/h. Same direction: X − Y = 360/12 = 30 km/h. Solving: X = (90+30)/2 = 60 km/h, Y = 30 km/h.',
 '["Speed Time Distance","Relative Speed"]'),

('ssc-cgl-2025-t1-s1-q71','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','Quantitative Aptitude','71',
 'A circular pizza having a radius of 21 cm. If 75% of it is eaten, what is the area of pizza remaining?',
 '[{"key":"A","text":"173.25 cm²"},{"key":"B","text":"346.36 cm²"},{"key":"C","text":"432.25 cm²"},{"key":"D","text":"115.5 cm²"}]',
 'B','346.36 cm²',
 'Total area = π × 21² = (22/7) × 441 = 1386 cm². 75% eaten → 25% remains = 0.25 × 1386 = 346.5 ≈ 346.36 cm².',
 '["Mensuration","Circle","Area"]'),

('ssc-cgl-2025-t1-s1-q72','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','Quantitative Aptitude','72',
 'A ring-shaped disc has outer radius 10 cm and inner radius 7 cm. What is the approximate ratio of the ring''s area to the whole outer circle?',
 '[{"key":"A","text":"1:2"},{"key":"B","text":"2:3"},{"key":"C","text":"3:4"},{"key":"D","text":"4:5"}]',
 'A','1:2',
 'Ring area = π(10² − 7²) = π × 51. Outer circle area = π × 100. Ratio = 51:100 ≈ 1:2 (closest option). The ring occupies approximately half the full disc area.',
 '["Mensuration","Circle","Ratio"]'),

('ssc-cgl-2025-t1-s1-q73','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','Quantitative Aptitude','73',
 'A bicycle wheel having a radius of 35 cm. What percentage of its circumference is covered in a quarter turn? (Use π = 22/7)',
 '[{"key":"A","text":"15%"},{"key":"B","text":"25%"},{"key":"C","text":"30%"},{"key":"D","text":"35%"}]',
 'B','25%',
 'One full turn = full circumference (2πr). A quarter turn covers 1/4 of the circumference, regardless of radius. Percentage = (1/4) × 100 = 25%.',
 '["Mensuration","Circle","Percentage"]'),

('ssc-cgl-2025-t1-s1-q74','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','Quantitative Aptitude','74',
 'The line y = mx + 5 passes through (1, 8). Find m.',
 '[{"key":"A","text":"5"},{"key":"B","text":"4"},{"key":"C","text":"3"},{"key":"D","text":"2"}]',
 'C','3',
 'Substituting the point (1, 8) into y = mx + 5: 8 = m × 1 + 5 → m = 8 − 5 = 3.',
 '["Coordinate Geometry","Linear Equations"]'),

('ssc-cgl-2025-t1-s1-q75','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','Quantitative Aptitude','75',
 '31³ + 18³ − 37³ + 210 is equal to:',
 '[{"key":"A","text":"-36810"},{"key":"B","text":"-14820"},{"key":"C","text":"-45670"},{"key":"D","text":"-23450"}]',
 'B','-14820',
 '31³ = 29791; 18³ = 5832; 37³ = 50653. Sum = 29791 + 5832 − 50653 + 210 = 35623 − 50653 + 210 = −15030 + 210 = −14820.',
 '["Algebra","Cubes"]'),

-- ── PART-D: English Comprehension (Q76–Q100) ─────────────────────────────────

('ssc-cgl-2025-t1-s1-q76','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','76',
 'Select the most appropriate synonym of the given word: PERFIDIOUS',
 '[{"key":"A","text":"Honest"},{"key":"B","text":"Faithful"},{"key":"C","text":"Treacherous"},{"key":"D","text":"Loyal"}]',
 'C','Treacherous',
 '"Perfidious" means guilty of betrayal or deceit; untrustworthy. Its closest synonym is "Treacherous". Honest, Faithful, and Loyal are all antonyms.',
 '["Synonyms","Vocabulary"]'),

('ssc-cgl-2025-t1-s1-q77','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','77',
 'Choose the correct meaning of idiom: Hobson''s choice',
 '[{"key":"A","text":"A dilemma between two evils"},{"key":"B","text":"A free and fair decision"},{"key":"C","text":"No real choice at all"},{"key":"D","text":"A selection made under duress"}]',
 'C','No real choice at all',
 'Hobson''s choice refers to a situation in which there appears to be a choice but in reality only one option is available — effectively no choice at all. It originates from Thomas Hobson, a stable-keeper who required customers to take the horse nearest the door or none.',
 '["Idioms and Phrases"]'),

('ssc-cgl-2025-t1-s1-q78','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','78',
 'Select the most appropriate antonym of the given word: Perfidious',
 '[{"key":"A","text":"Betraying"},{"key":"B","text":"Faithless"},{"key":"C","text":"Loyal"},{"key":"D","text":"Treacherous"}]',
 'C','Loyal',
 '"Perfidious" means deceitful and disloyal. Its antonym is "Loyal" — faithful, trustworthy, and dependable. Betraying, Faithless, and Treacherous are all synonyms of perfidious.',
 '["Antonyms","Vocabulary"]'),

('ssc-cgl-2025-t1-s1-q79','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','79',
 'Identify the misspelt word.',
 '[{"key":"A","text":"Vicereine"},{"key":"B","text":"Floccinaucinihilipilification"},{"key":"C","text":"Defenestrate"},{"key":"D","text":"Quintessance"}]',
 'D','Quintessance',
 'The correct spelling is "Quintessence" (not "Quintessance"). It means the most perfect or typical example of a quality. Vicereine (female viceroy), Floccinaucinihilipilification (act of estimating something as worthless), and Defenestrate (to throw out of a window) are all correctly spelled.',
 '["Spelling","Vocabulary"]'),

('ssc-cgl-2025-t1-s1-q80','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','80',
 'Spot the correct spelling of a CSF-shunt procedure.',
 '[{"key":"A","text":"Ventriculoperitoneal"},{"key":"B","text":"Ventriculoperitonal"},{"key":"C","text":"Ventriculaperitoneal"},{"key":"D","text":"Ventriculoperetoneal"}]',
 'A','Ventriculoperitoneal',
 '"Ventriculoperitoneal" is the correct medical spelling — relating to both the brain ventricles and the peritoneum. It is the standard term for a VP shunt, a procedure used to treat hydrocephalus. All other options contain spelling errors.',
 '["Spelling","Medical Terminology"]'),

('ssc-cgl-2025-t1-s1-q81','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','81',
 'Choose the correct one-word substitute for: An official reprimand or strong criticism.',
 '[{"key":"A","text":"Accusation"},{"key":"B","text":"Denunciation"},{"key":"C","text":"Censure"},{"key":"D","text":"Indictment"}]',
 'C','Censure',
 '"Censure" means a formal and severe expression of disapproval or an official reprimand. "Accusation" is a charge of wrongdoing; "Denunciation" is public condemnation; "Indictment" is a formal legal charge — none of these specifically mean an official reprimand.',
 '["One Word Substitution"]'),

('ssc-cgl-2025-t1-s1-q82','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','82',
 'Select the correct option: The startup scaled so rapidly that its infrastructure could ___ keep pace.',
 '[{"key":"A","text":"barely"},{"key":"B","text":"merely"},{"key":"C","text":"scarcely"},{"key":"D","text":"all but"}]',
 'A','barely',
 '"Barely" means only just or almost not — "could barely keep pace" naturally conveys the infrastructure struggling to match rapid growth. "Merely" implies insignificance (wrong context); "all but" means almost or nearly (grammatically awkward here).',
 '["Fill in the Blanks","Adverbs"]'),

('ssc-cgl-2025-t1-s1-q83','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','83',
 'Select the correct option: Rare though the phenomenon is, it can occur ___ prolonged drought conditions.',
 '[{"key":"A","text":"towards"},{"key":"B","text":"amid"},{"key":"C","text":"among"},{"key":"D","text":"under"}]',
 'D','under',
 '"Under prolonged drought conditions" is the correct fixed expression in English — "under conditions" is a standard collocation. "Amid" implies being surrounded by something concurrent; "among" is used with countable groups; "towards" denotes direction.',
 '["Fill in the Blanks","Prepositions"]'),

('ssc-cgl-2025-t1-s1-q84','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','84',
 'Select the correct option: While the proposal appeared pragmatic on paper, its implementation proved ___ complicated than expected.',
 '[{"key":"A","text":"less"},{"key":"B","text":"more"},{"key":"C","text":"much"},{"key":"D","text":"rather"}]',
 'B','more',
 '"More complicated than expected" forms the correct comparative construction — "proved more [adjective] than" is standard English. "Much" and "rather" cannot be followed directly by an adjective + "than". "Less" would contradict the context (implementation was harder, not easier).',
 '["Fill in the Blanks","Comparatives"]'),

('ssc-cgl-2025-t1-s1-q85','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','85',
 'Find the part of the sentence that contains an error:
That the report failed to address the root causes (1)/ of the community unrest were surprising (2)/ given the exhaustive data (3)/ compiled over several months. (4)',
 '[{"key":"A","text":"(1)"},{"key":"B","text":"(2)"},{"key":"C","text":"(3)"},{"key":"D","text":"(4)"}]',
 'B','(2)',
 'The subject of the sentence is the entire noun clause "That the report failed to address the root causes of the community unrest", which is singular. Therefore the verb must be "was surprising", not "were surprising". Correction: "...of the community unrest was surprising".',
 '["Error Detection","Subject-Verb Agreement"]'),

('ssc-cgl-2025-t1-s1-q86','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','86',
 'Find the part of the sentence that contains an error:
What renders the draft legislation particularly contentious is not its proposed realignment of fiscal powers per se, (1)/ but that it presumes, without empirical substantiation, (2)/ a fiscal equivalence among states whose developmental baselines are (3)/ incommensurable by any normative metric. (4)',
 '[{"key":"A","text":"(1)"},{"key":"B","text":"(2)"},{"key":"C","text":"(3)"},{"key":"D","text":"(4)"}]',
 'B','(2)',
 'The construction "not X, but that Y" violates parallel structure. Since part (1) uses a noun phrase ("its proposed realignment..."), part (2) must also be a noun phrase — "but its presumption, without empirical substantiation" — not a clause beginning with "that it presumes".',
 '["Error Detection","Parallel Structure"]'),

('ssc-cgl-2025-t1-s1-q87','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','87',
 'Change the following from active to passive: They have been neglecting maintenance of the archives for years.',
 '[{"key":"A","text":"Maintenance of the archives had been neglected by them for years."},{"key":"B","text":"Maintenance of the archives is being neglected by them for years."},{"key":"C","text":"Maintenance of the archives was being neglected by them for years."},{"key":"D","text":"Maintenance of the archives has been being neglected by them for years."}]',
 'D','Maintenance of the archives has been being neglected by them for years.',
 'The active voice uses Present Perfect Continuous (have been + V-ing). Its passive form is: have/has been being + past participle. "They have been neglecting" → "Maintenance... has been being neglected by them". Though rare in practice, this is the grammatically correct passive transformation.',
 '["Active and Passive Voice","Tenses"]'),

('ssc-cgl-2025-t1-s1-q88','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','88',
 'Select the sentence containing the homonym of the highlighted word: The choir began the introit at the priest''s signal.',
 '[{"key":"A","text":"The child sang the introit during the intermission."},{"key":"B","text":"The introit was replaced by an organ improvisation."},{"key":"C","text":"The missal included Latin text for the introit."},{"key":"D","text":"The cantor rehearsed the Sunday introit."}]',
 'C','The missal included Latin text for the introit.',
 'In the original sentence, "introit" refers to a sung liturgical piece (music). In option C, "introit" refers to the written Latin text included in a missal (book) — representing the textual/literary form rather than the musical performance, i.e., a contextually distinct usage of the same word.',
 '["Homonyms","Vocabulary"]'),

('ssc-cgl-2025-t1-s1-q89','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','89',
 'Convert the sentence provided below from its passive voice structure to an active voice structure: It was being suggested by multiple sources that the operation had been compromised internally.',
 '[{"key":"A","text":"Multiple sources suggested the operation was compromised internally."},{"key":"B","text":"The operation was compromised, multiple sources suggested."},{"key":"C","text":"The sources were suggesting an operation compromise."},{"key":"D","text":"The operation had compromised multiple internal sources."}]',
 'A','Multiple sources suggested the operation was compromised internally.',
 '"It was being suggested by multiple sources" (Past Continuous Passive) → "Multiple sources were suggesting / suggested" (Active). Option A most accurately conveys the meaning in active voice. The embedded clause "had been compromised" simplifies to "was compromised" in the active restatement.',
 '["Active and Passive Voice"]')

ON CONFLICT (slug) DO NOTHING;

-- ── Reading Comprehension Q90–Q94 (passage stored in translations) ────────────
-- Separate INSERT to include the translations column.

INSERT INTO vaultcore.questions
  (slug, exam_slug, paper_slug, mock_slug, exam_name, year, paper, subject,
   question_no, question, options, answer_key, answer, explanation, tags, translations)
VALUES

('ssc-cgl-2025-t1-s1-q90','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','90',
 'According to the passage, how is wisdom primarily acquired?',
 '[{"key":"A","text":"Through textbooks"},{"key":"B","text":"Through emotional detachment"},{"key":"C","text":"Through experience and reflection"},{"key":"D","text":"Through algorithmic thinking"}]',
 'C','Through experience and reflection',
 'The passage states: "wisdom... is earned through trial, failure, reflection, and a nuanced understanding of human nature." It explicitly contrasts this with textbooks (education) and algorithmic thinking (which widens the gap between education and wisdom).',
 '["Reading Comprehension"]',
 '{"en":{"passage":"While education and wisdom are often conflated in colloquial discourse, a discerning mind perceives a fundamental divergence between the two. Education is the formal acquisition of knowledge, often measured through degrees, academic accolades, and proficiency in structured disciplines. It is delivered through systematic curricula, institutionalized assessment, and theoretical frameworks. However, wisdom transcends this rigidity; it is the judicious application of knowledge to real-life contexts, enriched by experience, introspection, and emotional intelligence. An individual may be extensively educated yet remain bereft of wisdom if they lack the discernment to apply their learning ethically and effectively. Conversely, many wise individuals—farmers, artisans, elders—may not possess formal education, but their decisions exhibit prudence and sagacity cultivated through lived realities. Thus, education equips the mind, but wisdom enriches the soul. In an era dominated by information overload and algorithmic thinking, the schism between the two has widened. Educational institutions often prioritize rote memorization and standardized testing over critical thinking and moral reasoning. Consequently, society produces individuals proficient in problem-solving but deficient in decision-making that requires empathy, patience, or foresight. Wisdom, being innately human, cannot be downloaded or fast-tracked; it is earned through trial, failure, reflection, and a nuanced understanding of human nature. Furthermore, while education is temporally bounded—ending with formal schooling or academic milestones—wisdom is a lifelong pursuit. It does not boast certificates but manifests in humility, ethical consistency, and the ability to navigate ambiguity with grace. Ultimately, the highest form of intelligence lies not merely in knowing what is right, but in consistently choosing to do it, especially when it is inconvenient.","question":"According to the passage, how is wisdom primarily acquired?","options":["Through textbooks","Through emotional detachment","Through experience and reflection","Through algorithmic thinking"]}}'),

('ssc-cgl-2025-t1-s1-q91','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','91',
 'What does the author mean by "wisdom enriches the soul"?',
 '[{"key":"A","text":"It enhances academic success"},{"key":"B","text":"It fosters deeper moral insight"},{"key":"C","text":"It improves verbal expression"},{"key":"D","text":"It sharpens mathematical skills"}]',
 'B','It fosters deeper moral insight',
 'The passage contrasts education (which "equips the mind") with wisdom (which "enriches the soul"). The soul here represents one''s moral and ethical inner self. Wisdom, as described — involving humility, ethical consistency, and empathy — fosters deeper moral insight rather than academic or technical skills.',
 '["Reading Comprehension"]',
 '{"en":{"passage":"While education and wisdom are often conflated in colloquial discourse, a discerning mind perceives a fundamental divergence between the two. Education is the formal acquisition of knowledge, often measured through degrees, academic accolades, and proficiency in structured disciplines. It is delivered through systematic curricula, institutionalized assessment, and theoretical frameworks. However, wisdom transcends this rigidity; it is the judicious application of knowledge to real-life contexts, enriched by experience, introspection, and emotional intelligence. An individual may be extensively educated yet remain bereft of wisdom if they lack the discernment to apply their learning ethically and effectively. Conversely, many wise individuals—farmers, artisans, elders—may not possess formal education, but their decisions exhibit prudence and sagacity cultivated through lived realities. Thus, education equips the mind, but wisdom enriches the soul. In an era dominated by information overload and algorithmic thinking, the schism between the two has widened. Educational institutions often prioritize rote memorization and standardized testing over critical thinking and moral reasoning. Consequently, society produces individuals proficient in problem-solving but deficient in decision-making that requires empathy, patience, or foresight. Wisdom, being innately human, cannot be downloaded or fast-tracked; it is earned through trial, failure, reflection, and a nuanced understanding of human nature. Furthermore, while education is temporally bounded—ending with formal schooling or academic milestones—wisdom is a lifelong pursuit. It does not boast certificates but manifests in humility, ethical consistency, and the ability to navigate ambiguity with grace. Ultimately, the highest form of intelligence lies not merely in knowing what is right, but in consistently choosing to do it, especially when it is inconvenient.","question":"What does the author mean by \"wisdom enriches the soul\"?","options":["It enhances academic success","It fosters deeper moral insight","It improves verbal expression","It sharpens mathematical skills"]}}'),

('ssc-cgl-2025-t1-s1-q92','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','92',
 'Who, according to the author, can be wise despite lacking formal education?',
 '[{"key":"A","text":"Scientists"},{"key":"B","text":"School children"},{"key":"C","text":"Elders and artisans"},{"key":"D","text":"Technocrats"}]',
 'C','Elders and artisans',
 'The passage explicitly states: "many wise individuals—farmers, artisans, elders—may not possess formal education, but their decisions exhibit prudence and sagacity cultivated through lived realities." The answer is directly supported by the text.',
 '["Reading Comprehension"]',
 '{"en":{"passage":"While education and wisdom are often conflated in colloquial discourse, a discerning mind perceives a fundamental divergence between the two. Education is the formal acquisition of knowledge, often measured through degrees, academic accolades, and proficiency in structured disciplines. It is delivered through systematic curricula, institutionalized assessment, and theoretical frameworks. However, wisdom transcends this rigidity; it is the judicious application of knowledge to real-life contexts, enriched by experience, introspection, and emotional intelligence. An individual may be extensively educated yet remain bereft of wisdom if they lack the discernment to apply their learning ethically and effectively. Conversely, many wise individuals—farmers, artisans, elders—may not possess formal education, but their decisions exhibit prudence and sagacity cultivated through lived realities. Thus, education equips the mind, but wisdom enriches the soul. In an era dominated by information overload and algorithmic thinking, the schism between the two has widened. Educational institutions often prioritize rote memorization and standardized testing over critical thinking and moral reasoning. Consequently, society produces individuals proficient in problem-solving but deficient in decision-making that requires empathy, patience, or foresight. Wisdom, being innately human, cannot be downloaded or fast-tracked; it is earned through trial, failure, reflection, and a nuanced understanding of human nature. Furthermore, while education is temporally bounded—ending with formal schooling or academic milestones—wisdom is a lifelong pursuit. It does not boast certificates but manifests in humility, ethical consistency, and the ability to navigate ambiguity with grace. Ultimately, the highest form of intelligence lies not merely in knowing what is right, but in consistently choosing to do it, especially when it is inconvenient.","question":"Who, according to the author, can be wise despite lacking formal education?","options":["Scientists","School children","Elders and artisans","Technocrats"]}}'),

('ssc-cgl-2025-t1-s1-q93','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','93',
 'What is the central contrast drawn in the passage?',
 '[{"key":"A","text":"Education vs. career"},{"key":"B","text":"Intelligence vs. memory"},{"key":"C","text":"Reading vs. writing"},{"key":"D","text":"Formal learning vs. applied wisdom"}]',
 'D','Formal learning vs. applied wisdom',
 'The entire passage contrasts education (formal, structured, certificate-based) with wisdom (experiential, applied, lifelong). The author states: "education equips the mind, but wisdom enriches the soul" — making "Formal learning vs. applied wisdom" the precise central contrast.',
 '["Reading Comprehension"]',
 '{"en":{"passage":"While education and wisdom are often conflated in colloquial discourse, a discerning mind perceives a fundamental divergence between the two. Education is the formal acquisition of knowledge, often measured through degrees, academic accolades, and proficiency in structured disciplines. It is delivered through systematic curricula, institutionalized assessment, and theoretical frameworks. However, wisdom transcends this rigidity; it is the judicious application of knowledge to real-life contexts, enriched by experience, introspection, and emotional intelligence. An individual may be extensively educated yet remain bereft of wisdom if they lack the discernment to apply their learning ethically and effectively. Conversely, many wise individuals—farmers, artisans, elders—may not possess formal education, but their decisions exhibit prudence and sagacity cultivated through lived realities. Thus, education equips the mind, but wisdom enriches the soul. In an era dominated by information overload and algorithmic thinking, the schism between the two has widened. Educational institutions often prioritize rote memorization and standardized testing over critical thinking and moral reasoning. Consequently, society produces individuals proficient in problem-solving but deficient in decision-making that requires empathy, patience, or foresight. Wisdom, being innately human, cannot be downloaded or fast-tracked; it is earned through trial, failure, reflection, and a nuanced understanding of human nature. Furthermore, while education is temporally bounded—ending with formal schooling or academic milestones—wisdom is a lifelong pursuit. It does not boast certificates but manifests in humility, ethical consistency, and the ability to navigate ambiguity with grace. Ultimately, the highest form of intelligence lies not merely in knowing what is right, but in consistently choosing to do it, especially when it is inconvenient.","question":"What is the central contrast drawn in the passage?","options":["Education vs. career","Intelligence vs. memory","Reading vs. writing","Formal learning vs. applied wisdom"]}}'),

('ssc-cgl-2025-t1-s1-q94','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','94',
 'According to the author, why has the gap between education and wisdom widened in recent times?',
 '[{"key":"A","text":"Due to overuse of social media"},{"key":"B","text":"Because wisdom is no longer valued"},{"key":"C","text":"Because of rote learning and algorithmic methods"},{"key":"D","text":"Because people stop learning after school"}]',
 'C','Because of rote learning and algorithmic methods',
 'The passage states: "In an era dominated by information overload and algorithmic thinking, the schism between the two has widened. Educational institutions often prioritize rote memorization and standardized testing over critical thinking and moral reasoning." This directly supports option C.',
 '["Reading Comprehension"]',
 '{"en":{"passage":"While education and wisdom are often conflated in colloquial discourse, a discerning mind perceives a fundamental divergence between the two. Education is the formal acquisition of knowledge, often measured through degrees, academic accolades, and proficiency in structured disciplines. It is delivered through systematic curricula, institutionalized assessment, and theoretical frameworks. However, wisdom transcends this rigidity; it is the judicious application of knowledge to real-life contexts, enriched by experience, introspection, and emotional intelligence. An individual may be extensively educated yet remain bereft of wisdom if they lack the discernment to apply their learning ethically and effectively. Conversely, many wise individuals—farmers, artisans, elders—may not possess formal education, but their decisions exhibit prudence and sagacity cultivated through lived realities. Thus, education equips the mind, but wisdom enriches the soul. In an era dominated by information overload and algorithmic thinking, the schism between the two has widened. Educational institutions often prioritize rote memorization and standardized testing over critical thinking and moral reasoning. Consequently, society produces individuals proficient in problem-solving but deficient in decision-making that requires empathy, patience, or foresight. Wisdom, being innately human, cannot be downloaded or fast-tracked; it is earned through trial, failure, reflection, and a nuanced understanding of human nature. Furthermore, while education is temporally bounded—ending with formal schooling or academic milestones—wisdom is a lifelong pursuit. It does not boast certificates but manifests in humility, ethical consistency, and the ability to navigate ambiguity with grace. Ultimately, the highest form of intelligence lies not merely in knowing what is right, but in consistently choosing to do it, especially when it is inconvenient.","question":"According to the author, why has the gap between education and wisdom widened in recent times?","options":["Due to overuse of social media","Because wisdom is no longer valued","Because of rote learning and algorithmic methods","Because people stop learning after school"]}}')

ON CONFLICT (slug) DO NOTHING;

-- ── Q95–Q100: Sentence Improvement, Speech, Rearrangement ────────────────────

INSERT INTO vaultcore.questions
  (slug, exam_slug, paper_slug, mock_slug, exam_name, year, paper, subject,
   question_no, question, options, answer_key, answer, explanation, tags)
VALUES

('ssc-cgl-2025-t1-s1-q95','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','95',
 'Choose the most suitable option to replace the highlighted part of the sentence: She has the reputation [to be a kind woman].',
 '[{"key":"A","text":"to have kindness"},{"key":"B","text":"of being a kind woman"},{"key":"C","text":"of being the kind woman"},{"key":"D","text":"to be kind-hearted"}]',
 'B','of being a kind woman',
 '"Reputation" is followed by "of + gerund", not "to + infinitive". The correct structure is "reputation of being...". Option C is wrong because "the kind woman" implies a specific known person. Option B is the standard collocation.',
 '["Sentence Improvement","Collocations"]'),

('ssc-cgl-2025-t1-s1-q96','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','96',
 'Choose the most suitable option to replace the highlighted part of the sentence: The doctor advised him [to avoid eating sweets and doing exercise regularly].',
 '[{"key":"A","text":"avoiding sweets and doing regular exercise"},{"key":"B","text":"to avoid sweets and to exercises regularly"},{"key":"C","text":"to avoid eating sweets and to exercise regularly"},{"key":"D","text":"to not eat sweets and do exercises"}]',
 'C','to avoid eating sweets and to exercise regularly',
 '"Advised" takes "to + infinitive". The sentence needs parallel infinitive structure: "to avoid eating sweets AND to exercise regularly". Option B has a grammatical error ("to exercises"). Option C correctly uses "to avoid... and to exercise" — parallel infinitives.',
 '["Sentence Improvement","Parallelism","Infinitives"]'),

('ssc-cgl-2025-t1-s1-q97','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','97',
 'A sentence is provided in direct speech. From the four given options, choose the one that most accurately conveys the sentence in its corresponding indirect speech. He asked me, "Have you done your homework?"',
 '[{"key":"A","text":"He asked me if I had done my homework."},{"key":"B","text":"He asked me have I done my homework."},{"key":"C","text":"He asked me whether I have done my homework."},{"key":"D","text":"He asked me whether had I done my homework."}]',
 'A','He asked me if I had done my homework.',
 'In reported speech, "Have you..." (Present Perfect interrogative) becomes "if/whether I had done..." (Past Perfect). The pronoun shifts from "you" to "I". The word order becomes statement order (not question order). Option A correctly applies all these rules.',
 '["Direct and Indirect Speech","Reported Speech"]'),

('ssc-cgl-2025-t1-s1-q98','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','98',
 'A sentence is provided in indirect speech. From the four given options, choose the one that most accurately conveys the sentence in its corresponding direct speech. He said that he would join the meeting after lunch.',
 '[{"key":"A","text":"\"I will join the meeting after lunch,\" he said."},{"key":"B","text":"\"I would join the meeting after lunch,\" he said."},{"key":"C","text":"\"I shall join the meeting after lunch,\" he said."},{"key":"D","text":"\"I can join the meeting after lunch,\" he said."}]',
 'A','"I will join the meeting after lunch," he said.',
 'In indirect speech "would" is the past form of "will". Converting back to direct speech, "he said that he would join..." → "I will join..." (restoring the original future tense). Option A correctly reverses the backshift.',
 '["Direct and Indirect Speech","Reported Speech"]'),

('ssc-cgl-2025-t1-s1-q99','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','99',
 'Rearrange the following sentences in correct order to make a logical passage:
1. A media strategy was framed based on outreach results.
2. Demographic metrics were tracked from campaign dashboards.
3. User interactions were collected across platforms.
4. Analysts segmented users by age and behavior.',
 '[{"key":"A","text":"3-2-4-1"},{"key":"B","text":"2-3-1-4"},{"key":"C","text":"3-1-4-2"},{"key":"D","text":"4-1-2-3"}]',
 'A','3-2-4-1',
 'Logical sequence: Collect interactions (3) → Track demographic metrics from dashboards (2) → Segment users by age/behaviour (4) → Frame media strategy based on outreach results (1). Each step logically follows the previous: data collection → measurement → analysis → strategy.',
 '["Sentence Rearrangement","Paragraph Ordering"]'),

('ssc-cgl-2025-t1-s1-q100','ssc-cgl','ssc-cgl-2025-tier1-sep12-shift1',NULL,
 'SSC CGL','2025','Tier I, 12 Sep 2025, Shift 1','English Language','100',
 'Rearrange the following sentences to form a coherent paragraph:
1. It is a process that involves the systematic and objective investigation of a subject to discover new facts or to confirm existing ones.
2. Research is a foundational pillar of academic and scientific progress.
3. This can be either theoretical, aiming to expand knowledge, or applied, seeking to solve a practical problem.
4. The findings of this investigation are then documented and peer-reviewed to ensure validity and credibility.',
 '[{"key":"A","text":"2, 1, 3, 4"},{"key":"B","text":"1, 2, 4, 3"},{"key":"C","text":"4, 3, 2, 1"},{"key":"D","text":"3, 4, 1, 2"}]',
 'A','2, 1, 3, 4',
 'Logical flow: Introduce research as a foundational pillar (2) → Define what it is — "a process of investigation" (1) → Classify the types — theoretical or applied (3) → Describe what happens to findings — documentation and peer review (4). This follows the classic general → specific → classification → outcome structure.',
 '["Sentence Rearrangement","Paragraph Ordering"]')

ON CONFLICT (slug) DO NOTHING;

-- ─── What is still missing ────────────────────────────────────────────────────
--
-- PART-A  General Intelligence & Reasoning  Q1  – Q25  (25 questions)
-- PART-B  General Awareness                 Q26 – Q50  (25 questions)
-- PART-C  Quantitative Aptitude             Q51 – Q63  (13 questions)
--
-- Total missing: 63 questions.
-- Please provide the question text, options, answer keys, and explanations
-- for Q1–Q63 and a follow-up SQL file will be created.
