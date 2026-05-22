-- UPSC CSE Prelims 2025 GS Paper II (CSAT)
-- 80 questions | No answers

-- Paper
INSERT INTO vaultcore.papers (slug, exam_slug, exam_name, title, year, shift, description, questions, subjects, negative_marking, source_url, duration_minutes, max_marks)
VALUES (
  'upsc-cse-prelims-2025-gs2',
  'upsc-cse',
  'UPSC Civil Services Examination',
  'Civil Services (Preliminary) Examination 2025 — General Studies Paper II (CSAT)',
  '2025',
  'GS Paper II',
  'UPSC CSE Prelims 2025 General Studies Paper II (CSAT) — 80 MCQs covering Reading Comprehension, Logical Reasoning, Quantitative Aptitude and Mental Ability. Qualifying paper: minimum 33% required.',
  80,
  '["Reading Comprehension", "Quantitative Aptitude", "Mental Ability & Logical Reasoning"]'::jsonb,
  0.83,
  'https://upsc.gov.in/sites/default/files/QP-CSP-25-GENERAL-STUDIES-PAPER-II-26052025.pdf',
  120,
  200
)
ON CONFLICT (slug) DO UPDATE SET
  title        = EXCLUDED.title,
  questions    = EXCLUDED.questions,
  updated_at   = CURRENT_TIMESTAMP;

-- Questions
INSERT INTO vaultcore.questions
  (slug, exam_slug, paper_slug, exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags)
VALUES

-- Q1 (Passage 1: Biodiversity & ecosystem)
('upsc-cse-2025-pre-gs2-q1','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','1',
'Passage: Maintaining an ecosystem just to conserve biodiversity will affect its commercial potential as well as the livelihoods dependent on the ecosystem. There is also a conflict between using an ecosystem only for livelihoods, for commercial exploitation, or strictly for conservation. Deforestation caused due to commercial exploitation will lead to indirect harm like floods, siltation problems and microclimatic instability, apart from adversely affecting livelihoods dependent on forests. These conflicts are particularly acute in developing countries where the dependence of people on the ecosystem is significant, and commercial exploitation has the potential to boost national income.

Which one of the following statements best reflects the critical message conveyed by the author of the passage?',
'[{"key":"A","text":"Conservation of biodiversity is not an issue to be worried about when some people depend on ecosystems for their livelihoods."},{"key":"B","text":"Commercial exploitation of forests goes against the fundamental rights of the people dependent on forests for food and shelter."},{"key":"C","text":"Sustenance of livelihood and degradation of ecosystem while being together exacerbate one another, leading to conflicts and imbalance."},{"key":"D","text":"Commercial exploitation of ecosystems should be completely stopped."}]',
'','','','[]'::jsonb),

-- Q2
('upsc-cse-2025-pre-gs2-q2','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','2',
'With reference to the passage on ecosystem and biodiversity, the following assumptions have been made:
I. No country needs to depend on ecosystems to boost national income.
II. Resource-rich countries need to share their resources with those of scant resources so as to prevent the degradation of ecosystems.
Which of the above assumptions is/are valid?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q3 (Passage 2: Renewable energy learning curve)
('upsc-cse-2025-pre-gs2-q3','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','3',
'Passage: The history of renewable energy suggests there is a steep learning curve, meaning that, as more is produced, costs fall rapidly because of economies of scale and learning by doing. The firms'' green innovation is path-dependent: the more a firm does, the more it is likely to do in the future. The strongest evidence for this is the collapse in the price of solar energy, which became about 90% cheaper during the 2010s, repeatedly beating forecasts. Moving early and gradually gives economies more time to adjust, allowing them to reap the benefits of path-dependent green investment without much disruption. A late, more chaotic transition is costlier.

Which one of the following statements best reflects the central idea of the passage?',
'[{"key":"A","text":"Economies of scale is essential for transition to green growth."},{"key":"B","text":"Modern technological progress is intensely linked to path-dependent innovations."},{"key":"C","text":"Countries with large economies are in a better position to adopt green technologies."},{"key":"D","text":"Timing plays a crucial role in the case of green technology development."}]',
'','','','[]'::jsonb),

-- Q4
('upsc-cse-2025-pre-gs2-q4','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','4',
'With reference to the passage on renewable energy, the following assumptions have been made:
I. Path-dependent green investments will eventually most likely benefit growth as well as public finances in a country like India.
II. If other green technologies follow the same pattern as that of solar energy, there will most likely be an easy green transition.
Which of the above assumptions is/are valid?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q5
('upsc-cse-2025-pre-gs2-q5','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','5',
'A natural number N is such that it can be expressed as N = p + q + r, where p, q and r are distinct factors of N. How many numbers below 50 have this property?',
'[{"key":"A","text":"6"},{"key":"B","text":"7"},{"key":"C","text":"8"},{"key":"D","text":"9"}]',
'','','','[]'::jsonb),

-- Q6
('upsc-cse-2025-pre-gs2-q6','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','6',
'Three prime numbers p, q and r, each less than 20, are such that p − q = q − r. How many distinct possible values can we get for (p + q + r)?',
'[{"key":"A","text":"4"},{"key":"B","text":"5"},{"key":"C","text":"6"},{"key":"D","text":"More than 6"}]',
'','','','[]'::jsonb),

-- Q7
('upsc-cse-2025-pre-gs2-q7','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','7',
'How many possible values of (p + q + r) are there satisfying 1/p + 1/q + 1/r = 1, where p, q and r are natural numbers (not necessarily distinct)?',
'[{"key":"A","text":"None"},{"key":"B","text":"One"},{"key":"C","text":"Three"},{"key":"D","text":"More than three"}]',
'','','','[]'::jsonb),

-- Q8
('upsc-cse-2025-pre-gs2-q8','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','8',
'What comes at X and Y respectively in the following sequence?
January, January, December, October, X, March, October, Y, September',
'[{"key":"A","text":"July, May"},{"key":"B","text":"July, April"},{"key":"C","text":"June, May"},{"key":"D","text":"June, April"}]',
'','','','[]'::jsonb),

-- Q9
('upsc-cse-2025-pre-gs2-q9','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','9',
'Team X scored a total of N runs in 20 overs. Team Y tied the score in 10% less overs. Had team Y''s average run rate (runs per over) been 50% higher, the scores would have been tied in 12 overs. How many runs were scored by team X?',
'[{"key":"A","text":"72"},{"key":"B","text":"144"},{"key":"C","text":"216"},{"key":"D","text":"Cannot be determined"}]',
'','','','[]'::jsonb),

-- Q10
('upsc-cse-2025-pre-gs2-q10','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','10',
'The price (p) of a commodity is first increased by k%; then decreased by k%; again increased by k%; and again decreased by k%. If the new price is q, then what is the relation between p and q?',
'[{"key":"A","text":"p(10⁴ − k²)² = q × 10⁸"},{"key":"B","text":"p(10⁴ − k²)² = q × 10⁴"},{"key":"C","text":"p(10⁴ − k²) = q × 10⁴"},{"key":"D","text":"p(10⁴ − k²) = q × 10⁸"}]',
'','','','[]'::jsonb),

-- Q11 (Passage 1: Indian States and climate challenges)
('upsc-cse-2025-pre-gs2-q11','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','11',
'Passage: Each State in India faces a distinctive set of challenges regarding the impact of warming, but also offers its own set of opportunities for reducing emissions depending on its natural resources. For example, coastal States need to take action to protect their shores from sea level rise, districts that are drier need to prepare for variable monsoon precipitation. Himalayan regions have their own unique challenges, and selected parts of peninsular India and offshore areas offer great opportunities for harnessing wind power. These various aspects need to be considered for developing clear and sustainable goals for the future.

Which one of the following statements best reflects the most logical, rational and pragmatic message conveyed by the author of the passage?',
'[{"key":"A","text":"The mitigation and adaptation strategies to address/tackle the climate change is essentially the responsibility of each State."},{"key":"B","text":"India is too diverse to implement any effective strategy or programme to address/tackle the climate change."},{"key":"C","text":"It is basically the responsibility of the Union Government to implement the climate action plans and ensure net zero emissions."},{"key":"D","text":"India needs to formulate effective climate change mitigation and adaptation strategies at the State/region level."}]',
'','','','[]'::jsonb),

-- Q12
('upsc-cse-2025-pre-gs2-q12','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','12',
'With reference to the passage on Indian States and climate challenges, the following assumptions have been made:
I. Green energy production can be linked to/integrated with the climate change mitigation and adaptation strategies.
II. Effects of climate change are much more severe in coastal and mountainous regions.
Which of the above assumptions is/are valid?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q13 (Passage 2: Social inequality and insecurity)
('upsc-cse-2025-pre-gs2-q13','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','13',
'Passage: If the social inequality is the most acutely felt social problem in India, insecurity, more than poverty, is the most acutely felt economic problem. Besides those below the official poverty line, even those just over the poverty line are subject to multiple economic insecurities of various kinds (due to wealth and/or health risks, market fluctuations, job-related uncertainties). Many Government policies are actually intended towards mitigating these insecurities.

Which one of the following statements best reflects the critical message conveyed by the passage?',
'[{"key":"A","text":"India''s political executive should be aware that poverty and social inequality and the consequent sense of insecurity is the main social problem."},{"key":"B","text":"In India, poverty is the primary reason for social inequality and insecurity."},{"key":"C","text":"Poverty and social inequality are so intricately linked that they pose an unmanageable crisis for India."},{"key":"D","text":"Insecurity, more than poverty, is the main economic issue that Government policies must address."}]',
'','','','[]'::jsonb),

-- Q14
('upsc-cse-2025-pre-gs2-q14','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','14',
'With reference to the passage on social inequality and insecurity, the following assumptions have been made:
I. People above the poverty line also are prone to suffer from anxiety about economic insecurity.
II. Eradication of poverty can result in peace and social equality in the country.
Which of the above assumptions is/are valid?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q15
('upsc-cse-2025-pre-gs2-q15','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','15',
'A solid cube is painted yellow on all its faces. The cube is then cut into 60 smaller but equal pieces by making the minimum number of cuts. Which of the following statements is/are correct?
I. The minimum number of cuts is 9.
II. The number of smaller pieces which are not painted on any face is 6.',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q16
('upsc-cse-2025-pre-gs2-q16','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','16',
'If 7 * 24 = 25 and 12 * 16 = 20, then what is 16 * 63 equal to?',
'[{"key":"A","text":"70"},{"key":"B","text":"66"},{"key":"C","text":"65"},{"key":"D","text":"64"}]',
'','','','[]'::jsonb),

-- Q17
('upsc-cse-2025-pre-gs2-q17','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','17',
'The petrol price shot up by 10% as a result of the hike in crude oil prices. The price of petrol before the hike was ₹90 per litre. A person travels 2200 km every month and his car gives a mileage of 16 km per litre. By how many km should he reduce his travel if he wants to maintain his expenditure at the previous level?',
'[{"key":"A","text":"180 km"},{"key":"B","text":"200 km"},{"key":"C","text":"220 km"},{"key":"D","text":"240 km"}]',
'','','','[]'::jsonb),

-- Q18
('upsc-cse-2025-pre-gs2-q18','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','18',
'A 4-digit number N is such that when divided by 3, 5, 6, 9 leaves a remainder 1, 3, 4, 7 respectively. What is the smallest value of N?',
'[{"key":"A","text":"1068"},{"key":"B","text":"1072"},{"key":"C","text":"1078"},{"key":"D","text":"1082"}]',
'','','','[]'::jsonb),

-- Q19
('upsc-cse-2025-pre-gs2-q19','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','19',
'Consider the following statements:
I. If A < B > C < D > E > F ≥ G = H; then B is always greater than E.
II. If P > Q = R ≥ S = T ≤ U = V > W; then S is always less than V.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q20
('upsc-cse-2025-pre-gs2-q20','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','20',
'What is the unit digit in the multiplication of 1 × 3 × 5 × 7 × 9 × ... × 999?',
'[{"key":"A","text":"1"},{"key":"B","text":"3"},{"key":"C","text":"5"},{"key":"D","text":"9"}]',
'','','','[]'::jsonb),

-- Q21 (Passage 1: Agricultural sector)
('upsc-cse-2025-pre-gs2-q21','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','21',
'Passage: One of the dismal realities of the agricultural sector in independent India has been that it never experienced a high-growth phase, unlike the non-agricultural economy. The highest decadal growth (compound annual growth rate or CAGR) for agriculture has been just 3.5% in the 1980s. Also, after experiencing a spurt in decadal growth during the 1980s, agricultural growth suffered relative stagnation thereafter. This is in sharp contrast to non-agricultural growth, which consistently increased from the 1980s to 2000s.

Which one of the following statements best reflects the corollary to the above passage?',
'[{"key":"A","text":"The benefit of economic reforms percolates down more slowly to the agriculture sector than in other sectors of the economy."},{"key":"B","text":"For India, the green revolution was not as useful as it was expected to be."},{"key":"C","text":"India lagged behind other countries in adapting mechanized and modern farming."},{"key":"D","text":"Rural-to-urban migration resulted in the stagnant agriculture sector."}]',
'','','','[]'::jsonb),

-- Q22
('upsc-cse-2025-pre-gs2-q22','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','22',
'With reference to the passage on Indian agricultural sector, the following assumptions have been made.
The growing divergence between the fortunes of the agricultural and non-agricultural economy in India could have been reduced/contained by:
I. adapting large-scale cultivation of commercial crops and viable corporate farming.
II. providing free insurance for all crops and heavily subsidizing seeds, fertilizers, electricity and farm machinery at par with developed countries.
Which of the above assumptions is/are valid?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q23 (Passage 2: Handlooms)
('upsc-cse-2025-pre-gs2-q23','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','23',
'Passage: In our country, handlooms are equated with a culture that ensures a continuity of tradition. This idea has become part of the public policy-framing and provides a legitimate basis for the State to support the sector. But the notion of tradition as a single, linear entity is being strongly contested today. The narratives dominant in defining culture/tradition in a particular way are seen to have emerged as the identities and histories of large sections. The discounted and, at times, forcibly stifled identities are fighting for their rightful place in history. Against this backdrop, when we promote handloom as a traditional industry, it is not surprising that large sections of our population choose to ignore it.

Which one of the following statements best reflects the most logical and rational message conveyed by the author of the passage?',
'[{"key":"A","text":"We need to free the handloom industry from the limited narrative linked to preserving cultural heritage."},{"key":"B","text":"Continued State support to the handloom industry ensures the preservation of some of our glorious art forms and old traditions."},{"key":"C","text":"Household units of the handloom sector should be modernized and made an economically viable organized industry."},{"key":"D","text":"Handloom products need to be converted to machine-made designer products so as to make them more popular."}]',
'','','','[]'::jsonb),

-- Q24
('upsc-cse-2025-pre-gs2-q24','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','24',
'With reference to the passage on handlooms, the following assumptions have been made:
I. There is no need for the State to be involved in any manner in the handloom sector.
II. Handloom products are no longer appealing and attractive in the rapidly changing modern world.
Which of the above assumptions is/are valid?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q25
('upsc-cse-2025-pre-gs2-q25','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','25',
'Consider the first 100 natural numbers. How many of them are not divisible by any one of 2, 3, 5, 7 and 9?',
'[{"key":"A","text":"20"},{"key":"B","text":"21"},{"key":"C","text":"22"},{"key":"D","text":"23"}]',
'','','','[]'::jsonb),

-- Q26
('upsc-cse-2025-pre-gs2-q26','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','26',
'If 4 ≤ x ≤ 8 and 2 ≤ y ≤ 7, then what is the ratio of maximum value of (x + y) to minimum value of (x − y)?',
'[{"key":"A","text":"15/6"},{"key":"B","text":"2"},{"key":"C","text":"15/2"},{"key":"D","text":"None of the above"}]',
'','','','[]'::jsonb),

-- Q27
('upsc-cse-2025-pre-gs2-q27','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','27',
'Let both p and k be prime numbers such that (p² + k) is also a prime number less than 30. What is the number of possible values of k?',
'[{"key":"A","text":"4"},{"key":"B","text":"5"},{"key":"C","text":"6"},{"key":"D","text":"7"}]',
'','','','[]'::jsonb),

-- Q28
('upsc-cse-2025-pre-gs2-q28','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','28',
'There are n sets of numbers each having only three positive integers with LCM equal to 1001 and HCF equal to 1. What is the value of n?',
'[{"key":"A","text":"6"},{"key":"B","text":"7"},{"key":"C","text":"8"},{"key":"D","text":"More than 8"}]',
'','','','[]'::jsonb),

-- Q29
('upsc-cse-2025-pre-gs2-q29','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','29',
'Let PQR be a 3-digit number, PPT be a 3-digit number and PS be a 2-digit number, where P, Q, R, S, T are distinct non-zero digits. Further, PQR − PS = PPT. If Q = 3 and T < 6, then what is the number of possible values of (R, S)?',
'[{"key":"A","text":"2"},{"key":"B","text":"3"},{"key":"C","text":"4"},{"key":"D","text":"More than 4"}]',
'','','','[]'::jsonb),

-- Q30
('upsc-cse-2025-pre-gs2-q30','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','30',
'Consider the sequence AB_CC_A_BCCC_BBC_C that follows a certain pattern. Which one of the following completes the sequence?',
'[{"key":"A","text":"B, C, B, C, A"},{"key":"B","text":"A, C, B, C, A"},{"key":"C","text":"B, C, B, A, C"},{"key":"D","text":"C, B, B, A, C"}]',
'','','','[]'::jsonb),

-- Q31 (Passage 1: Higher education)
('upsc-cse-2025-pre-gs2-q31','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','31',
'Passage: In our country, regrettably, teaching and learning for the examination have been our forte but the new demands of society and the future of work require critical and independent thinking, learning through doing, asking questions from multiple disciplinary perspectives on the same issue, using evidence for building arguments, and reflecting and articulation. Higher education should not "either be a mere servant of the government policy or a passive respondent to public mood." Higher learning is all about how to think rather than what to think. Teaching has to be re-invented.

Which one of the following statements best reflects the central idea conveyed by the passage?',
'[{"key":"A","text":"India does not have enough resources for promoting quality education in its universities."},{"key":"B","text":"The institutions of higher learning in the country should not be under the control of the Government."},{"key":"C","text":"Classroom approach to higher education should be done away with."},{"key":"D","text":"Classroom needs to be reimagined and teaching needs to be re-invented."}]',
'','','','[]'::jsonb),

-- Q32
('upsc-cse-2025-pre-gs2-q32','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','32',
'With reference to the passage on higher education, the following assumptions have been made:
I. Higher education is a constantly evolving subject that needs to align towards new developments in all spheres of society.
II. In our country, sufficient funds are not allocated for promoting higher education.
Which of the above assumptions is/are valid?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q33 (Passage 2: Food inequality)
('upsc-cse-2025-pre-gs2-q33','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','33',
'Passage: If there is inequality in the pattern of population growth, there is greater inequality in food production and utilization. As societies become wealthier, their consumption of animal products increases. This means that a greater proportion of such basic foodstuff as grains and legumes that could feed humans directly is instead being converted into feed for poultry and large farm animals. Yet this conversion of plant-based food into animal food for humans is far from efficient. Only 16% of the calories fed to chickens are recovered by us when we eat them. This conversion rate goes down to five to seven per cent in large animals that are fed grain to add fat and some protein before slaughter.

Which one of the following statements best reflects the crux of the passage?',
'[{"key":"A","text":"There is an urgent need for a public policy to promote the consumption of cereal-based foods in wealthier societies."},{"key":"B","text":"Animal-based food is far less efficient than grain/plant-based food in terms of production and utilization."},{"key":"C","text":"Plant-based protein should replace the animal-based protein in our daily diets."},{"key":"D","text":"Inequality in food production and consumption is inevitable in any fast changing society."}]',
'','','','[]'::jsonb),

-- Q34
('upsc-cse-2025-pre-gs2-q34','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','34',
'With reference to the passage on food inequality, the following assumptions have been made:
I. The food manufacturing and processing industries in every country should align their objectives and processes in accordance with the changing needs of the societies.
II. Wealthier societies tend to incur great loss of calories of food materials due to indirect utilization of their agricultural produce.
Which of the above assumptions is/are valid?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q35
('upsc-cse-2025-pre-gs2-q35','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','35',
'What is the maximum value of n such that 7 × 343 × 385 × 1000 × 2401 × 77777 is divisible by 35ⁿ?',
'[{"key":"A","text":"3"},{"key":"B","text":"4"},{"key":"C","text":"5"},{"key":"D","text":"7"}]',
'','','','[]'::jsonb),

-- Q36
('upsc-cse-2025-pre-gs2-q36','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','36',
'What is X in the sequence 24, X, 12, 18, 36, 90?',
'[{"key":"A","text":"18"},{"key":"B","text":"12"},{"key":"C","text":"9"},{"key":"D","text":"6"}]',
'','','','[]'::jsonb),

-- Q37
('upsc-cse-2025-pre-gs2-q37','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','37',
'P and Q walk along a circular track. They start at 5:00 a.m. from the same point in opposite directions. P walks at an average speed of 5 rounds per hour and Q walks at an average speed of 3 rounds per hour. How many times will they cross each other between 5:20 a.m. and 7:00 a.m.?',
'[{"key":"A","text":"12"},{"key":"B","text":"13"},{"key":"C","text":"14"},{"key":"D","text":"11"}]',
'','','','[]'::jsonb),

-- Q38
('upsc-cse-2025-pre-gs2-q38','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','38',
'If P = +, Q = −, R = ×, S = ÷, then insert the proper notations between the successive numbers in the equation 60 _ 15 _ 3 _ 20 _ 4 = 20:',
'[{"key":"A","text":"SPRQ"},{"key":"B","text":"QRPS"},{"key":"C","text":"QRSP"},{"key":"D","text":"SPQR"}]',
'','','','[]'::jsonb),

-- Q39
('upsc-cse-2025-pre-gs2-q39','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','39',
'A tram overtakes 2 persons X and Y walking at an average speed of 3 km/hr and 4 km/hr in the same direction and completely passes them in 8 seconds and 9 seconds respectively. What is the length of the tram?',
'[{"key":"A","text":"15 m"},{"key":"B","text":"18 m"},{"key":"C","text":"20 m"},{"key":"D","text":"24 m"}]',
'','','','[]'::jsonb),

-- Q40
('upsc-cse-2025-pre-gs2-q40','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','40',
'If N² = 12345678987654321, then how many digits does the number N have?',
'[{"key":"A","text":"8"},{"key":"B","text":"9"},{"key":"C","text":"10"},{"key":"D","text":"11"}]',
'','','','[]'::jsonb),

-- Q41 (Passage 1: Net-zero carbon)
('upsc-cse-2025-pre-gs2-q41','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','41',
'Passage: Over the next 30 years, many countries are promising to move to net-zero carbon, implying that household emissions will have to be cut to close to nothing. A leading climate scientist reckons that, at best, half the reduction might be achieved through demand-side measures, such as behavioural changes by individuals and households. And even that would require companies and governments to provide more incentives to change through supply-side investments to make low-carbon options cheaper and more widely available.

Which one of the following statements best reflects the central idea conveyed by the passage?',
'[{"key":"A","text":"Moving to net-zero carbon is possible only by the reduction in household emissions."},{"key":"B","text":"Low-carbon behaviour in people can be brought about by incentivising them."},{"key":"C","text":"Cheaper goods and services can be made available to people by using low-carbon technologies."},{"key":"D","text":"Manufacturing industries that use low-carbon technologies should be provided with subsidies."}]',
'','','','[]'::jsonb),

-- Q42
('upsc-cse-2025-pre-gs2-q42','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','42',
'With reference to the passage on net-zero carbon, the following assumptions have been made:
I. Supply-side investments in companies can result in low-carbon behaviour in people.
II. People are not capable of adapting low-carbon behaviour without the involvement of Government and Companies.
Which of the above assumptions is/are valid?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q43 (Passage 2: Raw materials & circular economy)
('upsc-cse-2025-pre-gs2-q43','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','43',
'Passage: In only 50 years, the world''s consumption of raw materials has nearly quadrupled, to more than 100 billion tons. Less than 9% of this is reused. Batteries of old vehicles contain materials such as lithium, cobalt, manganese and nickel that are pricey and can be hard to obtain. Supply chains are long and complicated. Buyers'' risks are being aggravated by their suppliers'' poor environmental and labour standards. Reusing materials makes sense. Once batteries reach the ends of their lives, they should go back to a factory where their ingredients can be recovered and put into new batteries.

Which one of the following statements best reflects the most logical, rational and pragmatic message conveyed by the passage?',
'[{"key":"A","text":"Green economy is not possible without reusing critical minerals."},{"key":"B","text":"Every sector of economy should adapt the reuse of material resources immediately."},{"key":"C","text":"Circular economy can be beneficial for sustainable growth."},{"key":"D","text":"Circular use of material resources is the only option for some industries for their survival."}]',
'','','','[]'::jsonb),

-- Q44
('upsc-cse-2025-pre-gs2-q44','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','44',
'With reference to the passage on raw materials and circular economy, the following assumptions have been made:
I. Automobile factories are examples of the circular economy.
II. Economic growth is compatible with circular use of mineral resources.
Which of the above assumptions is/are valid?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q45
('upsc-cse-2025-pre-gs2-q45','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','45',
'A set (X) of 20 pipes can fill 70% of a tank in 14 minutes. Another set (Y) of 10 pipes fills 3/8th of the tank in 6 minutes. A third set (Z) of 16 pipes can empty half of the tank in 20 minutes. If half of the pipes of set X are closed and only half of the pipes of set Y are open, and all pipes of the set (Z) are open, then how long will it take to fill 50% of the tank?',
'[{"key":"A","text":"8 minutes"},{"key":"B","text":"10 minutes"},{"key":"C","text":"12 minutes"},{"key":"D","text":"16 minutes"}]',
'','','','[]'::jsonb),

-- Q46
('upsc-cse-2025-pre-gs2-q46','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','46',
'If n is a natural number, then what is the number of distinct remainders of (1ⁿ + 2ⁿ) when divided by 4?',
'[{"key":"A","text":"0"},{"key":"B","text":"1"},{"key":"C","text":"2"},{"key":"D","text":"3"}]',
'','','','[]'::jsonb),

-- Q47
('upsc-cse-2025-pre-gs2-q47','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','47',
'Let P = QQQ be a 3-digit number (where all digits are Q). What is the HCF of P and 481?',
'[{"key":"A","text":"1"},{"key":"B","text":"13"},{"key":"C","text":"37"},{"key":"D","text":"481"}]',
'','','','[]'::jsonb),

-- Q48
('upsc-cse-2025-pre-gs2-q48','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','48',
'What is the 489th digit in the number 123456789101112...?',
'[{"key":"A","text":"0"},{"key":"B","text":"3"},{"key":"C","text":"6"},{"key":"D","text":"9"}]',
'','','','[]'::jsonb),

-- Q49
('upsc-cse-2025-pre-gs2-q49','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','49',
'A mobile phone has been stolen. There are 3 suspects P, Q and R. They were questioned knowing that only one of them is guilty. Their responses are as follows:
P: I did not steal. Q stole it.
Q: R did not steal. I did not steal.
R: I did not steal. I do not know who did it.
Who stole the mobile phone?',
'[{"key":"A","text":"P"},{"key":"B","text":"Q"},{"key":"C","text":"R"},{"key":"D","text":"Cannot be concluded"}]',
'','','','[]'::jsonb),

-- Q50
('upsc-cse-2025-pre-gs2-q50','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','50',
'Three teams P, Q, R participated in a tournament in which the teams play with one another exactly once. A win fetches a team 2 points and a draw 1 point. A team gets no point for a loss. Each team scored exactly one goal in the tournament. The team P got 3 points, Q got 2 points and R got 1 point.
Which of the following statements is/are correct?
I. The result of the match between P and Q is a draw with the score 0-0.
II. The number of goals scored by R against Q is 1.',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q51 (Passage 1: Plant diseases and climate change)
('upsc-cse-2025-pre-gs2-q51','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','51',
'Passage: It is hard to predict how changes in the climate and the atmosphere''s chemistry will affect the prevalence and virulence of agricultural diseases. But there is a risk that such changes will make some plant infections more common in all climatic zones, perhaps catastrophically so. Part of the problem is that centuries of selective breeding have refined the genomes of most high-value crops. They are spectacular at growing in today''s conditions but genetic variations that are not immediately useful to them have been bred out. This is good for yields but bad for coping with changes. A minor disease or even an unknown one could suddenly rampage through a genetically honed crop.

Which one of the following statements best reflects the central idea conveyed by the passage?',
'[{"key":"A","text":"Global climate change adversely affects the productivity of crops."},{"key":"B","text":"Our total dependence on genetically honed crops entails possible food insecurity."},{"key":"C","text":"Our food security should not depend on agricultural productivity alone."},{"key":"D","text":"Genetically honed crops should be replaced with their wild varieties in our present cultivation practices."}]',
'','','','[]'::jsonb),

-- Q52
('upsc-cse-2025-pre-gs2-q52','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','52',
'With reference to the passage on plant diseases and climate change, the following assumptions have been made:
I. Global climate change can result in the migration of several plant diseases to new areas.
II. Scientific understanding of the wild relatives of our present crops would enable us to strengthen food security.
Which of the above assumptions is/are valid?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q53 (Passage 2: Opposition in democracy)
('upsc-cse-2025-pre-gs2-q53','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','53',
'Passage: "A good statesman, like any other sensible human being, learns more from his opponents than from his fervent supporters. For his supporters will push him to disaster unless his opponents show him where the dangers are. So if he is wise he will often pray to be delivered from his friends, because they will ruin him. But, though it hurts, he ought also to pray never to be left without opponents; for they keep him on the path of reason and good sense. The national unity of free people depends upon a sufficiently even balance of political power to make it impracticable for the administration to be arbitrary and for opposition to be revolutionary and irreconcilable."

Which one of the following statements best reflects the critical message conveyed by the author of the passage?',
'[{"key":"A","text":"Without opposition parties, the administration in a democracy gets to become more responsible."},{"key":"B","text":"Democracy needs to have revolutionaries in opposition to keep the government alert."},{"key":"C","text":"Rulers in a democracy need the support of opposition for their political survival."},{"key":"D","text":"In a democracy, the opposition is indispensable for the balance of political power and good governance."}]',
'','','','[]'::jsonb),

-- Q54
('upsc-cse-2025-pre-gs2-q54','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','54',
'With reference to the passage on opposition in democracy, the following assumptions have been made:
I. In a democracy, a strong opposition is required only if the Head of Government is indifferent.
II. The more aggressive the opposition, the better is the governance in a democracy.
Which of the above assumptions is/are valid?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q55
('upsc-cse-2025-pre-gs2-q55','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','55',
'P is the brother of Q and R. S is R''s mother. T is P''s father. How many of the following statements are definitely true?
I. S and T are a couple.
II. Q is T''s son.
III. T is Q''s father.
IV. S is P''s mother.
V. R is T''s daughter.
VI. P is S''s son.',
'[{"key":"A","text":"Only two"},{"key":"B","text":"Only three"},{"key":"C","text":"Only four"},{"key":"D","text":"Only five"}]',
'','','','[]'::jsonb),

-- Q56
('upsc-cse-2025-pre-gs2-q56','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','56',
'If NO is coded as 210, NOT is coded as 4200 and NOTE is coded as 21000, then how is NOTES coded?',
'[{"key":"A","text":"399000"},{"key":"B","text":"420000"},{"key":"C","text":"440000"},{"key":"D","text":"630000"}]',
'','','','[]'::jsonb),

-- Q57
('upsc-cse-2025-pre-gs2-q57','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','57',
'If FRANCE is coded as 654321 and GERMANY is coded as 9158437, then how is YEMEN coded?',
'[{"key":"A","text":"54321"},{"key":"B","text":"81913"},{"key":"C","text":"71913"},{"key":"D","text":"71813"}]',
'','','','[]'::jsonb),

-- Q58
('upsc-cse-2025-pre-gs2-q58','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','58',
'The 5-digit number PQRST (all distinct digits) is such that T ≠ 0. P is thrice T. S is greater than Q by 4, while Q is greater than R by 3. How many such 5-digit numbers are possible?',
'[{"key":"A","text":"3"},{"key":"B","text":"4"},{"key":"C","text":"5"},{"key":"D","text":"6"}]',
'','','','[]'::jsonb),

-- Q59
('upsc-cse-2025-pre-gs2-q59','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','59',
'X can complete one-third of a certain work in 6 days, Y can complete one-third of the same work in 8 days and Z can complete three-fourth of the same work in 12 days. All of them work together for n days and then X and Z quit and Y alone finishes the remaining work in 8 days. What is n equal to?',
'[{"key":"A","text":"3"},{"key":"B","text":"4"},{"key":"C","text":"5"},{"key":"D","text":"6"}]',
'','','','[]'::jsonb),

-- Q60
('upsc-cse-2025-pre-gs2-q60','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','60',
'What is X in the sequence 1, 3, 6, 11, 18, X, 42?',
'[{"key":"A","text":"26"},{"key":"B","text":"27"},{"key":"C","text":"29"},{"key":"D","text":"30"}]',
'','','','[]'::jsonb),

-- Q61 (Passage 1: Corporate capitalism)
('upsc-cse-2025-pre-gs2-q61','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','61',
'Passage: There has been no democracy that has grown economically without corporate capitalism. It helps in modernizing the economy and enabling the transition from rural to urban, and agriculture to industry and services, which are inevitable with growth. It generates jobs — and there is no other way to fix a country''s unemployment challenge without a further impetus to private business. Big companies can operate on a large scale and become competitive both domestically and externally. A vibrant corporate capitalist base also leads to additional revenues for the State — which in turn, can be used for greater welfare for the marginalized and creating a more level playing field in terms of opportunities.

Which one of the following statements best reflects the critical message conveyed by the author of the passage?',
'[{"key":"A","text":"Corporate capitalism is important for economic growth of a State and also for democracy."},{"key":"B","text":"Corporate capitalism is imperative for a modern State to achieve its political objectives."},{"key":"C","text":"No State can ensure its economic survival for long without the role of corporate capitalism."},{"key":"D","text":"Corporate capitalism and democracy have mutual dependence for their continued existence."}]',
'','','','[]'::jsonb),

-- Q62
('upsc-cse-2025-pre-gs2-q62','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','62',
'With reference to the passage on corporate capitalism, the following assumptions have been made:
I. Corporate capitalism promotes the growth of labour force and provides more employment opportunities.
II. Poor and marginalized sections of population are benefited by corporate capitalism due to trickle-down effect.
Which of the above assumptions is/are valid?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q63 (Passage 2: Voluntary associations)
('upsc-cse-2025-pre-gs2-q63','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','63',
'Passage: "A network of voluntary associations stands as a ''buffer'' between the relatively powerless individual and the potentially powerful State."

Which one of the following statements reflects the best explanation of the above passage?',
'[{"key":"A","text":"It emphasizes the inability of the State to enforce its will in practice against the opposition of certain groups within it."},{"key":"B","text":"It is a cooperative organization for the promotion of the well-being and development of the personality of its members."},{"key":"C","text":"It takes individuals out of a state of isolation and gives them a chance to participate in the common endeavour."},{"key":"D","text":"It permits citizens to have a variety of loyalties and allegiance."}]',
'','','','[]'::jsonb),

-- Q64
('upsc-cse-2025-pre-gs2-q64','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','64',
'Consider the following statements:
I. There exists a natural number which when increased by 50% can have its number of factors unchanged.
II. There exists a natural number which when increased by 150% can have its number of factors unchanged.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q65
('upsc-cse-2025-pre-gs2-q65','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','65',
'There are 7 places A, B, C, D, E, F and G in a city connected by various roads AB, AC, CD, DE, BF, EG and FG. A is 6 km south of B. A is 10 km west of C. D is 5 km east of E. C is 6 km north of D. F is 9 km west of B. F is 12 km north of G. A person travels from D to F through these roads. What is the distance covered by the person?',
'[{"key":"A","text":"20 km"},{"key":"B","text":"25 km"},{"key":"C","text":"31 km"},{"key":"D","text":"37 km"}]',
'','','','[]'::jsonb),

-- Q66
('upsc-cse-2025-pre-gs2-q66','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','66',
'In a certain code if 64 is written as 343 and 216 is written as 729, then how is 512 written in that code?',
'[{"key":"A","text":"1000"},{"key":"B","text":"1331"},{"key":"C","text":"1728"},{"key":"D","text":"2197"}]',
'','','','[]'::jsonb),

-- Q67
('upsc-cse-2025-pre-gs2-q67','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','67',
'What is the remainder when 9³ + 9⁴ + 9⁵ + 9⁶ + ... + 9¹⁰⁰ is divided by 6?',
'[{"key":"A","text":"0"},{"key":"B","text":"1"},{"key":"C","text":"2"},{"key":"D","text":"3"}]',
'','','','[]'::jsonb),

-- Q68 (Data Sufficiency)
('upsc-cse-2025-pre-gs2-q68','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','68',
'A question is given followed by two Statements I and II. Consider the Question and the Statements and mark the correct option.
Question: What is the smallest 1-digit number having exactly 4 distinct factors?
Statement I: 2 is one of the factors.
Statement II: 3 is one of the factors.
Which one of the following is correct in respect of the above Question and the Statements?',
'[{"key":"A","text":"The Question can be answered by using one of the Statements alone, but cannot be answered using the other statement alone."},{"key":"B","text":"The Question can be answered by using either Statement alone."},{"key":"C","text":"The Question can be answered by using both the Statements together, but cannot be answered using either Statement alone."},{"key":"D","text":"The Question can be answered even without using any of the Statements."}]',
'','','','[]'::jsonb),

-- Q69 (Data Sufficiency)
('upsc-cse-2025-pre-gs2-q69','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','69',
'A question is given followed by two Statements I and II. Consider the Question and the Statements and mark the correct option.
Question: Let P, Q, R, S be distinct non-zero digits. If PP × PQ = RRSS, where P ≤ 3 and Q ≤ 4, then what is Q equal to?
Statement I: R = 1.
Statement II: S = 2.
Which one of the following is correct in respect of the above Question and the Statements?',
'[{"key":"A","text":"The Question can be answered by using one of the Statements alone, but cannot be answered using the other statement alone."},{"key":"B","text":"The Question can be answered by using either Statement alone."},{"key":"C","text":"The Question can be answered by using both the Statements together, but cannot be answered using either Statement alone."},{"key":"D","text":"The Question cannot be answered even using any of the Statements."}]',
'','','','[]'::jsonb),

-- Q70 (Data Sufficiency)
('upsc-cse-2025-pre-gs2-q70','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','70',
'A question is given followed by two Statements I and II. Consider the Question and the Statements and mark the correct option.
Question: How is Q related to P?
Statement I: P has two sisters, R and S.
Statement II: R''s father is the brother of Q.
Which one of the following is correct in respect of the above Question and the Statements?',
'[{"key":"A","text":"The Question can be answered by using one of the Statements alone, but cannot be answered using the other statement alone."},{"key":"B","text":"The Question can be answered by using either Statement alone."},{"key":"C","text":"The Question can be answered by using both the Statements together, but cannot be answered using either Statement alone."},{"key":"D","text":"The Question cannot be answered even using any of the Statements."}]',
'','','','[]'::jsonb),

-- Q71 (Passage 1: Inflation)
('upsc-cse-2025-pre-gs2-q71','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','71',
'Passage: A single number for inflation is an aggregate across different commodities and services — the price rise differs for different items of consumption. So, the single number is arrived at by assigning weights to different commodities and services. For WPI, the weights in production are used; for CPI, the consumption basket is used. But people are not homogeneous. The consumption basket is vastly different for the poor, the middle classes, and the rich. Hence, the CPI is different for each of these classes and a composite index requires averaging the baskets.

Which one of the following statements best reflects the most logical, rational and crucial message conveyed by the passage?',
'[{"key":"A","text":"We must use WPI exclusively in measuring price rise and CPI should be done away with."},{"key":"B","text":"The present calculation of inflation rate does not correctly measure price rise of individual item/commodity."},{"key":"C","text":"Inflation data under-presents services in the consumption basket."},{"key":"D","text":"Knowledge of inflation rate is not really of any use to anybody in the country."}]',
'','','','[]'::jsonb),

-- Q72 (Passage 2: Trust)
('upsc-cse-2025-pre-gs2-q72','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Reading Comprehension','72',
'Passage: Trust stands commonly defined as being vulnerable to others. Entrepreneurship implies trust in others and willingness to expose oneself to betrayal. Trust in expert systems is the essence of globalizing behaviour; trust itself emerges as a super-commodity in the social market and defines the characteristics of goods and services in a global market. Trusting conduct also means holding others in good esteem, and an optimism that they are, or will be, competent in certain respects.

Which one of the following statements best reflects the crux of the passage?',
'[{"key":"A","text":"Trustworthiness cannot be expected in entrepreneurship."},{"key":"B","text":"Trustworthy people are the most vulnerable people."},{"key":"C","text":"No economic activity is possible without being exposed to betrayal."},{"key":"D","text":"Trust is important though it entails risk."}]',
'','','','[]'::jsonb),

-- Q73 (Data Sufficiency)
('upsc-cse-2025-pre-gs2-q73','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','73',
'A question is given followed by two Statements I and II. Consider the Question and the Statements and mark the correct option.
Question: In a football match, team P playing against Q was behind by 3 goals with 10 minutes remaining. Does team P win the match?
Statement I: Team P scored 4 goals in the last 10 minutes.
Statement II: Team Q scored a total of 4 goals in the match.
Which one of the following is correct in respect of the above Question and the Statements?',
'[{"key":"A","text":"The Question can be answered by using one of the Statements alone, but cannot be answered using the other statement alone."},{"key":"B","text":"The Question can be answered by using either Statement alone."},{"key":"C","text":"The Question can be answered by using both the Statements together, but cannot be answered using either Statement alone."},{"key":"D","text":"The Question cannot be answered even using any of the Statements."}]',
'','','','[]'::jsonb),

-- Q74 (Data Sufficiency)
('upsc-cse-2025-pre-gs2-q74','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Mental Ability & Logical Reasoning','74',
'A question is given followed by two Statements I and II. Consider the Question and the Statements and mark the correct option.
Question: Is (p + q)² − 4pq, where p, q are natural numbers, positive?
Statement I: p < q.
Statement II: p > q.
Which one of the following is correct in respect of the above Question and the Statements?',
'[{"key":"A","text":"The Question can be answered by using one of the Statements alone, but cannot be answered using the other statement alone."},{"key":"B","text":"The Question can be answered by using either Statement alone."},{"key":"C","text":"The Question can be answered by using both the Statements together, but cannot be answered using either Statement alone."},{"key":"D","text":"The Question can be answered even without using any of the Statements."}]',
'','','','[]'::jsonb),

-- Q75
('upsc-cse-2025-pre-gs2-q75','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','75',
'In a T20 cricket match, three players X, Y and Z scored a total of 37 runs. The ratio of number of runs scored by X to the number of runs scored by Y is equal to ratio of number of runs scored by Y to number of runs scored by Z.
Value-I = Runs scored by X
Value-II = Runs scored by Y
Value-III = Runs scored by Z
Which one of the following is correct?',
'[{"key":"A","text":"Value-I < Value-II < Value-III"},{"key":"B","text":"Value-III < Value-II < Value-I"},{"key":"C","text":"Value-I < Value-III < Value-II"},{"key":"D","text":"Cannot be determined due to insufficient data"}]',
'','','','[]'::jsonb),

-- Q76
('upsc-cse-2025-pre-gs2-q76','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','76',
'Let p + q = 10, where p, q are integers.
Value-I = Maximum value of p × q when p, q are positive integers.
Value-II = Maximum value of p × q when p ≥ −6, q ≥ −4.
Which one of the following is correct?',
'[{"key":"A","text":"Value-I < Value-II"},{"key":"B","text":"Value-II < Value-I"},{"key":"C","text":"Value-I = Value-II"},{"key":"D","text":"Cannot be determined due to insufficient data"}]',
'','','','[]'::jsonb),

-- Q77
('upsc-cse-2025-pre-gs2-q77','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','77',
'Consider a set of 11 numbers:
Value-I = Minimum value of the average of the numbers of the set when they are consecutive integers ≥ −5.
Value-II = Minimum value of the product of the numbers of the set when they are consecutive non-negative integers.
Which one of the following is correct?',
'[{"key":"A","text":"Value-I < Value-II"},{"key":"B","text":"Value-II < Value-I"},{"key":"C","text":"Value-I = Value-II"},{"key":"D","text":"Cannot be determined due to insufficient data"}]',
'','','','[]'::jsonb),

-- Q78
('upsc-cse-2025-pre-gs2-q78','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','78',
'The average of three numbers p, q and r is k. p is as much more than the average as q is less than the average. What is the value of r?',
'[{"key":"A","text":"k"},{"key":"B","text":"k − 1"},{"key":"C","text":"k + 1"},{"key":"D","text":"k/2"}]',
'','','','[]'::jsonb),

-- Q79
('upsc-cse-2025-pre-gs2-q79','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','79',
'Let x be a real number between 0 and 1. Which of the following statements is/are correct?
I. x² > x³.
II. x > √x.',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]',
'','','','[]'::jsonb),

-- Q80
('upsc-cse-2025-pre-gs2-q80','upsc-cse','upsc-cse-prelims-2025-gs2','UPSC Civil Services Examination','2025','GS Paper II','Quantitative Aptitude','80',
'The difference between any two natural numbers is 10. What can be said about the natural numbers which are divisible by 5 and lie between these two numbers?',
'[{"key":"A","text":"There is only one such number."},{"key":"B","text":"There are only two such numbers."},{"key":"C","text":"There can be more than one such number."},{"key":"D","text":"No such number exists."}]',
'','','','[]'::jsonb)

ON CONFLICT (slug) DO UPDATE SET
  question   = EXCLUDED.question,
  options    = EXCLUDED.options,
  updated_at = CURRENT_TIMESTAMP;

UPDATE vaultcore.papers SET questions = 80 WHERE slug = 'upsc-cse-prelims-2025-gs2';
UPDATE vaultcore.exams  SET popular_years = '["2025"]'::jsonb, papers = 2, total_questions = 180
WHERE slug = 'upsc-cse';
