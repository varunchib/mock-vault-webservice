-- UPSC Civil Services (Preliminary) Examination, 2025 — GS Paper I
-- 100 questions | No answers yet

-- Exam
INSERT INTO vaultcore.exams (slug, name, category, subjects, icon, short_name, description, mocks, papers, total_questions, popular_years)
VALUES (
  'upsc-cse',
  'UPSC Civil Services Examination',
  'Central',
  '["History","Geography","Environment & Ecology","Economy","Polity & Governance","Science & Technology","Current Affairs"]'::jsonb,
  '🏛️',
  'UPSC CSE',
  'UPSC Civil Services Examination (Prelims & Mains) — the gateway to IAS, IPS, IFS and other Group A & B services.',
  0, 0, 0,
  '["2025"]'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  category = EXCLUDED.category,
  subjects = EXCLUDED.subjects,
  updated_at = CURRENT_TIMESTAMP;

-- Paper
INSERT INTO vaultcore.papers (slug, exam_slug, exam_name, title, year, shift, description, questions, subjects, negative_marking)
VALUES (
  'upsc-cse-prelims-2025-gs1',
  'upsc-cse',
  'UPSC Civil Services Examination',
  'Civil Services (Preliminary) Examination 2025 — General Studies Paper I',
  '2025',
  'GS Paper I',
  'UPSC CSE Prelims 2025 General Studies Paper I — 100 MCQs covering History, Geography, Economy, Polity, Environment, Science & Technology, and Current Affairs.',
  100,
  '["History","Geography","Environment & Ecology","Economy","Polity & Governance","Science & Technology","Current Affairs"]'::jsonb,
  0.66
)
ON CONFLICT (slug) DO UPDATE SET
  title = EXCLUDED.title,
  questions = EXCLUDED.questions,
  updated_at = CURRENT_TIMESTAMP;

-- Questions
INSERT INTO vaultcore.questions
  (slug, exam_slug, paper_slug, exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags)
VALUES

('upsc-cse-2025-pre-gs1-q1','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','1',
'With reference to investments, consider the following:
I. Bonds
II. Hedge Funds
III. Stocks
IV. Venture Capital
How many of the above are treated as Alternative Investment Funds?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"Only three"},{"key":"D","text":"All the four"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q2','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','2',
'Which of the following are the sources of income for the Reserve Bank of India?
I. Buying and selling Government bonds
II. Buying and selling foreign currency
III. Pension fund management
IV. Lending to private companies
V. Printing and distributing currency notes
Select the correct answer using the code given below.',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II, III and IV"},{"key":"C","text":"I, III, IV and V"},{"key":"D","text":"I, II and V"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q3','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','3',
'With reference to the Government of India, consider the following information:
(I) Directorate of Enforcement — Enforcement of the Fugitive Economic Offenders Act, 2018 — works under Internal Security Division-I, Ministry of Home Affairs
(II) Directorate of Revenue Intelligence — Enforces the Provisions of the Customs Act, 1962 — works under Department of Revenue, Ministry of Finance
(III) Directorate General of Systems and Data Management — Carrying out big data analytics to assist tax officers for better policy and nabbing tax evaders — works under Department of Revenue, Ministry of Finance
In how many of the above rows is the information correctly matched?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q4','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','4',
'Consider the following statements:
I. The Reserve Bank of India mandates all the listed companies in India to submit a Business Responsibility and Sustainability Report (BRSR).
II. In India, a company submitting a BRSR makes disclosures in the report that are largely non-financial in nature.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q5','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','5',
'Consider the following statements:
Statement I: In India, income from allied agricultural activities like poultry farming and wool rearing in rural areas is exempted from any tax.
Statement II: In India, rural agricultural land is not considered a capital asset under the provisions of the Income-tax Act, 1961.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement I and Statement II are correct and Statement II explains Statement I"},{"key":"B","text":"Both Statement I and Statement II are correct but Statement II does not explain Statement I"},{"key":"C","text":"Statement I is correct but Statement II is not correct"},{"key":"D","text":"Statement I is not correct but Statement II is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q6','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','6',
'Consider the following statements:
I. India has joined the Minerals Security Partnership as a member.
II. India is a resource-rich country in all the 30 critical minerals that it has identified.
III. The Parliament in 2023 has amended the Mines and Minerals (Development and Regulation) Act, 1957 empowering the Central Government to exclusively auction mining lease and composite license for certain critical minerals.
Which of the statements given above are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q7','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','7',
'Consider the following statements:
Statement I: As regards returns from an investment in a company, generally, bondholders are considered to be relatively at lower risk than stockholders.
Statement II: Bondholders are lenders to a company whereas stockholders are its owners.
Statement III: For repayment purpose, bondholders are prioritized over stockholders by a company.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement II and Statement III are correct and both of them explain Statement I"},{"key":"B","text":"Both Statement I and Statement II are correct and Statement I explains Statement II"},{"key":"C","text":"Only one of the Statements II and III is correct and that explains Statement I"},{"key":"D","text":"Neither Statement II nor Statement III is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q8','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','8',
'Consider the following statements:
I. India accounts for a very large portion of all equity option contracts traded globally thus exhibiting a great boom.
II. India''s stock market has grown rapidly in the recent past even overtaking Hong Kong''s at some point of time.
III. There is no regulatory body either to warn the small investors about the risks of options trading or to act on unregistered financial advisors in this regard.
Which of the statements given above are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q9','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','9',
'Consider the following statements:
Statement I: Circular economy reduces the emissions of greenhouse gases.
Statement II: Circular economy reduces the use of raw materials as inputs.
Statement III: Circular economy reduces wastage in the production process.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement II and Statement III are correct and both of them explain Statement I"},{"key":"B","text":"Both Statement II and Statement III are correct but only one of them explains Statement I"},{"key":"C","text":"Only one of the Statements II and III is correct and that explains Statement I"},{"key":"D","text":"Neither Statement II nor Statement III is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q10','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','10',
'Consider the following statements:
I. Capital receipts create a liability or cause a reduction in the assets of the Government.
II. Borrowings and disinvestment are capital receipts.
III. Interest received on loans creates a liability of the Government.
Which of the statements given above are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q11','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','11',
'Consider the following statements about Raja Ram Mohan Roy:
I. He possessed great love and respect for the traditional philosophical systems of the East.
II. He desired his countrymen to accept the rational and scientific approach and the principle of human dignity and social equality of all men and women.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q12','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','12',
'Consider the following subjects with regard to Non-Cooperation Programme:
I. Boycott of law-courts and foreign cloth
II. Observance of strict non-violence
III. Retention of titles and honours without using them in public
IV. Establishment of Panchayats for settling disputes
How many of the above were parts of Non-Cooperation Programme?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"Only three"},{"key":"D","text":"All the four"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q13','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','13',
'The irrigation device called ''Araghatta'' was',
'[{"key":"A","text":"a water bag made of leather pulled over a pulley"},{"key":"B","text":"a large wheel with earthen pots tied to the outer ends of its spokes"},{"key":"C","text":"a larger earthen pot driven by bullocks"},{"key":"D","text":"a large water bucket pulled up by rope directly by hand"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q14','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','14',
'Who among the following rulers in ancient India had assumed the titles ''Mattavilasa'', ''Vichitrachitta'' and ''Gunabhara''?',
'[{"key":"A","text":"Mahendravarman I"},{"key":"B","text":"Simhavishnu"},{"key":"C","text":"Narasimhavarman I"},{"key":"D","text":"Simhavarman"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q15','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','15',
'Fa-hien (Faxian), the Chinese pilgrim, travelled to India during the reign of',
'[{"key":"A","text":"Samudragupta"},{"key":"B","text":"Chandragupta II"},{"key":"C","text":"Kumaragupta I"},{"key":"D","text":"Skandagupta"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q16','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','16',
'Who among the following led a successful military campaign against the kingdom of Srivijaya, the powerful maritime State, which ruled the Malay Peninsula, Sumatra, Java and the neighbouring islands?',
'[{"key":"A","text":"Amoghavarsha (Rashtrakuta)"},{"key":"B","text":"Prataparudra (Kakatiya)"},{"key":"C","text":"Rajendra I (Chola)"},{"key":"D","text":"Vishnuvardhana (Hoysala)"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q17','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','17',
'With reference to ancient India (600-322 BC), consider the following pairs:
Territorial region — River flowing in the region
(I) Asmaka — Godavari
(II) Kamboja — Vipas
(III) Avanti — Mahanadi
(IV) Kosala — Sarayu
How many of the pairs given above are correctly matched?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"Only three"},{"key":"D","text":"All the four"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q18','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','18',
'The first Gandharva Mahavidyalaya, a music training school, was set up in 1901 by Vishnu Digambar Paluskar in',
'[{"key":"A","text":"Delhi"},{"key":"B","text":"Gwalior"},{"key":"C","text":"Ujjain"},{"key":"D","text":"Lahore"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q19','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','19',
'Ashokan inscriptions suggest that the ''Pradeshika'', ''Rajuka'' and ''Yukta'' were important officers at the',
'[{"key":"A","text":"village-level administration"},{"key":"B","text":"district-level administration"},{"key":"C","text":"provincial administration"},{"key":"D","text":"level of the central administration"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q20','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','20',
'Consider the following statements in respect of the Non-Cooperation Movement:
I. The Congress declared the attainment of ''Swaraj'' by all legitimate and peaceful means to be its objective.
II. It was to be implemented in stages with civil disobedience and non-payment of taxes for the next stage only if ''Swaraj'' did not come within a year and the Government resorted to repression.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q21','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Current Affairs','21',
'Consider the following countries:
I. Austria
II. Bulgaria
III. Croatia
IV. Serbia
V. Sweden
VI. North Macedonia
How many of the above are members of the North Atlantic Treaty Organization?',
'[{"key":"A","text":"Only three"},{"key":"B","text":"Only four"},{"key":"C","text":"Only five"},{"key":"D","text":"All the six"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q22','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Geography','22',
'Consider the following countries:
I. Bolivia
II. Brazil
III. Colombia
IV. Ecuador
V. Paraguay
VI. Venezuela
Andes mountains pass through how many of the above countries?',
'[{"key":"A","text":"Only two"},{"key":"B","text":"Only three"},{"key":"C","text":"Only four"},{"key":"D","text":"Only five"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q23','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Geography','23',
'Consider the following water bodies:
I. Lake Tanganyika
II. Lake Tonlé Sap
III. Patos Lagoon
Through how many of them does the equator pass?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q24','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Geography','24',
'Consider the following statements about turmeric during the year 2022-23:
I. India is the largest producer and exporter of turmeric in the world.
II. More than 30 varieties of turmeric are grown in India.
III. Maharashtra, Telangana, Karnataka and Tamil Nadu are major turmeric producing States in India.
Which of the statements given above are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q25','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Geography','25',
'Which of the following are the evidences of the phenomenon of continental drift?
I. The belt of ancient rocks from Brazil coast matches with those from Western Africa.
II. The gold deposits of Ghana are derived from the Brazil plateau when the two continents lay side by side.
III. The Gondwana system of sediments from India is known to have its counterparts in six different landmasses of the Southern Hemisphere.
Select the correct answer using the code given below.',
'[{"key":"A","text":"I and III only"},{"key":"B","text":"I and II only"},{"key":"C","text":"I, II and III"},{"key":"D","text":"II and III only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q26','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Geography','26',
'Consider the following statements:
Statement I: The amount of dust particles in the atmosphere is more in subtropical and temperate areas than in equatorial and polar regions.
Statement II: Subtropical and temperate areas have less dry winds.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement I and Statement II are correct and Statement II explains Statement I"},{"key":"B","text":"Both Statement I and Statement II are correct but Statement II does not explain Statement I"},{"key":"C","text":"Statement I is correct but Statement II is not correct"},{"key":"D","text":"Statement I is not correct but Statement II is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q27','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Geography','27',
'Consider the following statements:
Statement I: In January, in the Northern Hemisphere, the isotherms bend equatorward while crossing the landmasses, and poleward while crossing the oceans.
Statement II: In January, the air over the oceans is warmer than that over the landmasses in the Northern Hemisphere.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement I and Statement II are correct and Statement II explains Statement I"},{"key":"B","text":"Both Statement I and Statement II are correct but Statement II does not explain Statement I"},{"key":"C","text":"Statement I is correct but Statement II is not correct"},{"key":"D","text":"Statement I is not correct but Statement II is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q28','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Geography','28',
'Consider the following statements:
Statement I: In the context of effect of water on rocks, chalk is known as a very permeable rock whereas clay is known as quite an impermeable or least permeable rock.
Statement II: Chalk is porous and hence can absorb water.
Statement III: Clay is not at all porous.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement II and Statement III are correct and both of them explain Statement I"},{"key":"B","text":"Both Statement II and Statement III are correct but only one of them explains Statement I"},{"key":"C","text":"Only one of the Statements II and III is correct and that explains Statement I"},{"key":"D","text":"Neither Statement II nor Statement III is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q29','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Geography','29',
'Consider the following statements:
I. Without the atmosphere, temperature would be well below freezing point everywhere on the Earth''s surface.
II. Heat absorbed and trapped by the atmosphere maintains our planet''s average temperature.
III. Atmosphere''s gases, like carbon dioxide, are particularly good at absorbing and trapping radiation.
Which of the statements given above are correct?',
'[{"key":"A","text":"I and III only"},{"key":"B","text":"I and II only"},{"key":"C","text":"I, II and III"},{"key":"D","text":"II and III only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q30','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','30',
'Consider the following statements about the Rashtriya Gokul Mission:
I. It is important for the upliftment of rural poor as majority of low producing indigenous animals are with small and marginal farmers and landless labourers.
II. It was initiated to promote indigenous cattle and buffalo rearing and conservation in a scientific and holistic manner.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q31','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','31',
'Consider the following statements:
Statement I: Studies indicate that carbon dioxide emissions from cement industry account for more than 5% of global carbon emissions.
Statement II: Silica-bearing clay is mixed with limestone while manufacturing cement.
Statement III: Limestone is converted into lime during clinker production for cement manufacturing.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement II and Statement III are correct and both of them explain Statement I"},{"key":"B","text":"Both Statement II and Statement III are correct but only one of them explains Statement I"},{"key":"C","text":"Only one of the Statements II and III is correct and that explains Statement I"},{"key":"D","text":"Neither Statement II nor Statement III is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q32','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','32',
'Consider the following statements:
Statement I: At the 28th United Nations Climate Change Conference (COP28), India refrained from signing the ''Declaration on Climate and Health''.
Statement II: The COP28 Declaration on Climate and Health is a binding declaration; and if signed, it becomes mandatory to decarbonize health sector.
Statement III: If India''s health sector is decarbonized, the resilience of its health-care system may be compromised.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement II and Statement III are correct and both of them explain Statement I"},{"key":"B","text":"Both Statement II and Statement III are correct but only one of them explains Statement I"},{"key":"C","text":"Only one of the Statements II and III is correct and that explains Statement I"},{"key":"D","text":"Neither Statement II nor Statement III is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q33','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','33',
'Consider the following statements:
Statement I: Scientific studies suggest that a shift is taking place in the Earth''s rotation and axis.
Statement II: Solar flares and associated coronal mass ejections bombarded the Earth''s outermost atmosphere with tremendous amount of energy.
Statement III: As the Earth''s polar ice melts, the water tends to move towards the equator.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement II and Statement III are correct and both of them explain Statement I"},{"key":"B","text":"Both Statement II and Statement III are correct but only one of them explains Statement I"},{"key":"C","text":"Only one of the Statements II and III is correct and that explains Statement I"},{"key":"D","text":"Neither Statement II nor Statement III is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q34','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','34',
'Consider the following statements:
Statement I: Article 6 of the Paris Agreement on climate change is frequently discussed in global discussions on sustainable development and climate change.
Statement II: Article 6 of the Paris Agreement on climate change sets out the principles of carbon markets.
Statement III: Article 6 of the Paris Agreement on climate change intends to promote inter-country non-market strategies to reach their climate targets.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement II and Statement III are correct and both of them explain Statement I"},{"key":"B","text":"Both Statement II and Statement III are correct but only one of them explains Statement I"},{"key":"C","text":"Only one of the Statements II and III is correct and that explains Statement I"},{"key":"D","text":"Neither Statement II nor Statement III is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q35','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','35',
'Which one of the following launched the ''Nature Solutions Finance Hub for Asia and the Pacific''?',
'[{"key":"A","text":"The Asian Development Bank (ADB)"},{"key":"B","text":"The Asian Infrastructure Investment Bank (AIIB)"},{"key":"C","text":"The New Development Bank (NDB)"},{"key":"D","text":"The International Bank for Reconstruction and Development (IBRD)"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q36','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','36',
'With reference to ''Direct Air Capture'', an emerging technology, which of the following statements is/are correct?
I. It can be used as a way of carbon sequestration.
II. It can be a valuable approach for plastic production and in food processing.
III. In aviation, it can be a source of carbon for combining with hydrogen to create synthetic low-carbon fuel.
Select the correct answer using the code given below.',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"III only"},{"key":"C","text":"I, II and III"},{"key":"D","text":"None of the above statements is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q37','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','37',
'Regarding Peacock tarantula (Gooty tarantula), consider the following statements:
I. It is an omnivorous crustacean.
II. Its natural habitat in India is only limited to some forest areas.
III. In its natural habitat, it is an arboreal species.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"I and III"},{"key":"C","text":"II only"},{"key":"D","text":"II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q38','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','38',
'Consider the following statements:
I. Carbon dioxide (CO2) emissions in India are less than 0.5 t CO2/capita.
II. In terms of CO2 emissions from fuel combustion, India ranks second in Asia-Pacific region.
III. Electricity and heat producers are the largest sources of CO2 emissions in India.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I and III only"},{"key":"B","text":"II only"},{"key":"C","text":"II and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q39','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','39',
'Consider the following pairs:
Plant — Description
(I) Cassava — Woody shrub
(II) Ginger — Herb with pseudostem
(III) Malabar spinach — Herbaceous climber
(IV) Mint — Annual shrub
(V) Papaya — Woody shrub
How many of the above pairs are correctly matched?',
'[{"key":"A","text":"Only two"},{"key":"B","text":"Only three"},{"key":"C","text":"Only four"},{"key":"D","text":"All the five"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q40','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','40',
'With reference to the planet Earth, consider the following statements:
I. Rain forests produce more oxygen than that produced by oceans.
II. Marine phytoplankton and photosynthetic bacteria produce about 50% of world''s oxygen.
III. Well-oxygenated surface water contains several folds higher oxygen than that in atmospheric air.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I and II"},{"key":"B","text":"II only"},{"key":"C","text":"I and III"},{"key":"D","text":"None of the above statements is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q41','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','41',
'Consider the following types of vehicles:
I. Full battery electric vehicles
II. Hydrogen fuel cell vehicles
III. Fuel cell-electric hybrid vehicles
How many of the above are considered as alternative powertrain vehicles?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q42','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','42',
'With reference to Unmanned Aerial Vehicles (UAVs), consider the following statements:
I. All types of UAVs can do vertical landing.
II. All types of UAVs can do automated hovering.
III. All types of UAVs can use battery only as a source of power supply.
How many of the statements given above are correct?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q43','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','43',
'In the context of electric vehicle batteries, consider the following elements:
I. Cobalt
II. Graphite
III. Lithium
IV. Nickel
How many of the above usually make up battery cathodes?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"Only three"},{"key":"D","text":"All the four"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q44','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','44',
'Consider the following:
I. Cigarette butts
II. Eyeglass lenses
III. Car tyres
How many of them contain plastic?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q45','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','45',
'Consider the following substances:
I. Ethanol
II. Nitroglycerine
III. Urea
Coal gasification technology can be used in the production of how many of them?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q46','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','46',
'What is the common characteristic of the chemical substances generally known as CL-20, HMX and LLM-105, which are sometimes talked about in media?',
'[{"key":"A","text":"These are alternatives to hydrofluorocarbon refrigerants"},{"key":"B","text":"These are explosives in military weapons"},{"key":"C","text":"These are high-energy fuels for cruise missiles"},{"key":"D","text":"These are fuels for rocket propulsion"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q47','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','47',
'Consider the following statements:
I. It is expected that Majorana 1 chip will enable quantum computing.
II. Majorana 1 chip has been introduced by Amazon Web Services (AWS).
III. Deep learning is a subset of machine learning.
Which of the statements given above are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q48','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','48',
'With reference to monoclonal antibodies, often mentioned in news, consider the following statements:
I. They are man-made proteins.
II. They stimulate immunological function due to their ability to bind to specific antigens.
III. They are used in treating viral infections like that of Nipah virus.
Which of the statements given above are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q49','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','49',
'Consider the following statements:
I. No virus can survive in ocean waters.
II. No virus can infect bacteria.
III. No virus can change the cellular transcriptional activity in host cells.
How many of the statements given above are correct?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q50','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','50',
'Consider the following statements:
Statement I: Activated carbon is a good and an attractive tool to remove pollutants from effluent streams and to remediate contaminants from various industries.
Statement II: Activated carbon exhibits a large surface area and a strong potential for adsorbing heavy metals.
Statement III: Activated carbon can be easily synthesized from environmental wastes with high carbon content.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement II and Statement III are correct and both of them explain Statement I"},{"key":"B","text":"Both Statement II and Statement III are correct but only one of them explains Statement I"},{"key":"C","text":"Only one of the Statements II and III is correct and that explains Statement I"},{"key":"D","text":"Neither Statement II nor Statement III is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q51','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','51',
'With reference to the Indian polity, consider the following statements:
I. An Ordinance can amend any Central Act.
II. An Ordinance can abridge a Fundamental Right.
III. An Ordinance can come into effect from a back date.
Which of the statements given above are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q52','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','52',
'Consider the following pairs:
State — Description
(I) Arunachal Pradesh — The capital is named after a fort, and the State has two National Parks
(II) Nagaland — The State came into existence on the basis of a Constitutional Amendment Act
(III) Tripura — Initially a Part ''C'' State, it became a centrally administered territory with the reorganization of States in 1956 and later attained the status of a full-fledged State
How many of the above pairs are correctly matched?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q53','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','53',
'With reference to India, consider the following:
I. The Inter-State Council
II. The National Security Council
III. Zonal Councils
How many of the above were established as per the provisions of the Constitution of India?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q54','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','54',
'Consider the following statements:
I. The Constitution of India explicitly mentions that in certain spheres the Governor of a State acts in his/her own discretion.
II. The President of India can, of his/her own, reserve a bill passed by a State Legislature for his/her consideration without it being forwarded by the Governor of the State concerned.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q55','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','55',
'Consider the following pairs:
Provision in the Constitution of India — Stated under
(I) Separation of Judiciary from the Executive in the public services of the State — The Directive Principles of the State Policy
(II) Valuing and preserving of the rich heritage of our composite culture — The Fundamental Duties
(III) Prohibition of employment of children below the age of 14 years in factories — The Fundamental Rights
How many of the above pairs are correctly matched?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q56','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','56',
'Consider the following statements: With reference to the Constitution of India, if an area in a State is declared as Scheduled Area under the Fifth Schedule —
I. the State Government loses its executive power in such areas and a local body assumes total administration
II. the Union Government can take over the total administration of such areas under certain circumstances on the recommendations of the Governor
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q57','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','57',
'With reference to India, consider the following pairs:
Organization — Union Ministry
(I) The National Automotive Board — Ministry of Commerce and Industry
(II) The Coir Board — Ministry of Heavy Industries
(III) The National Centre for Trade Information — Ministry of Micro, Small and Medium Enterprises
How many of the above pairs are correctly matched?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q58','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','58',
'Consider the following subjects under the Constitution of India:
I. List I — Union List, in the Seventh Schedule
II. Extent of the executive power of a State
III. Conditions of the Governor''s office
For a constitutional amendment with respect to which of the above, ratification by the Legislatures of not less than one-half of the States is required before presenting the bill to the President of India for assent?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q59','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','59',
'With reference to the Indian polity, consider the following statements:
I. The Governor of a State is not answerable to any court for the exercise and performance of the powers and duties of his/her office.
II. No criminal proceedings shall be instituted or continued against the Governor during his/her term of office.
III. Members of a State Legislature are not liable to any proceedings in any court in respect of anything said within the House.
Which of the statements given above are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q60','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','60',
'Consider the following activities:
I. Production of crude oil
II. Refining, storage and distribution of petroleum
III. Marketing and sale of petroleum products
IV. Production of natural gas
How many of the above activities are regulated by the Petroleum and Natural Gas Regulatory Board in our country?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"Only three"},{"key":"D","text":"All the four"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q61','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','61',
'Suppose the revenue expenditure is ₹80,000 crores and the revenue receipts of the Government are ₹60,000 crores. The Government budget also shows borrowings of ₹10,000 crores and interest payments of ₹6,000 crores. Which of the following statements are correct?
I. Revenue deficit is ₹20,000 crores.
II. Fiscal deficit is ₹10,000 crores.
III. Primary deficit is ₹4,000 crores.
Select the correct answer using the code given below.',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q62','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Current Affairs','62',
'India is one of the founding members of the International North-South Transport Corridor (INSTC), a multimodal transportation corridor, which will connect',
'[{"key":"A","text":"India to Central Asia to Europe via Iran"},{"key":"B","text":"India to Central Asia via China"},{"key":"C","text":"India to South-East Asia through Bangladesh and Myanmar"},{"key":"D","text":"India to Europe through Azerbaijan"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q63','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','63',
'Consider the following statements:
Statement I: Of the two major ethanol producers in the world, i.e., Brazil and the United States of America, the former produces more ethanol than the latter.
Statement II: Unlike in the United States of America where corn is the principal feedstock for ethanol production, sugarcane is the principal feedstock for ethanol production in Brazil.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement I and Statement II are correct and Statement II explains Statement I"},{"key":"B","text":"Both Statement I and Statement II are correct but Statement II does not explain Statement I"},{"key":"C","text":"Statement I is correct but Statement II is not correct"},{"key":"D","text":"Statement I is not correct but Statement II is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q64','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','64',
'The World Bank warned that India could become one of the first places where wet-bulb temperatures routinely exceed 35°C. Which of the following statements best reflect(s) the implication of the above-said report?
I. Peninsular India will most likely suffer from flooding, tropical cyclones and droughts.
II. The survival of animals including humans will be affected as shedding of their body heat through perspiration becomes difficult.
Select the correct answer using the code given below.',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q65','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','65',
'A country''s fiscal deficit stands at ₹50,000 crores. It is receiving ₹10,000 crores through non-debt creating capital receipts. The country''s interest liabilities are ₹1,500 crores. What is the gross primary deficit?',
'[{"key":"A","text":"₹48,500 crores"},{"key":"B","text":"₹51,500 crores"},{"key":"C","text":"₹58,500 crores"},{"key":"D","text":"None of the above"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q66','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','66',
'Which of the following statements with regard to recommendations of the 15th Finance Commission of India are correct?
I. It has recommended grants of ₹4,800 crores from the year 2022-23 to the year 2025-26 for incentivizing States to enhance educational outcomes.
II. 45% of the net proceeds of Union taxes are to be shared with States.
III. ₹45,000 crores are to be kept as performance-based incentive for all States for carrying out agricultural reforms.
IV. It reintroduced tax effort criteria to reward fiscal performance.
Select the correct answer using the code given below.',
'[{"key":"A","text":"I, II and III"},{"key":"B","text":"I, II and IV"},{"key":"C","text":"I, III and IV"},{"key":"D","text":"II, III and IV"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q67','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','67',
'Consider the following statements in respect of the International Bank for Reconstruction and Development (IBRD):
I. It provides loans and guarantees to middle income countries.
II. It works single-handedly to help developing countries to reduce poverty.
III. It was established to help Europe rebuild after the World War II.
Which of the statements given above are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q68','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','68',
'Consider the following statements in respect of RTGS and NEFT:
I. In RTGS, the settlement time is instantaneous while in case of NEFT, it takes some time to settle payments.
II. In RTGS, the customer is charged for inward transactions while that is not the case for NEFT.
III. Operating hours for RTGS are restricted on certain days while this is not true for NEFT.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"I and II"},{"key":"C","text":"I and III"},{"key":"D","text":"III only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q69','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','69',
'Consider the following countries:
I. United Arab Emirates
II. France
III. Germany
IV. Singapore
V. Bangladesh
How many countries amongst the above are there other than India where international merchant payments are accepted under UPI?',
'[{"key":"A","text":"Only two"},{"key":"B","text":"Only three"},{"key":"C","text":"Only four"},{"key":"D","text":"All the five"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q70','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Economy','70',
'Consider the following statements about ''PM Surya Ghar Muft Bijli Yojana'':
I. It targets installation of one crore solar rooftop panels in the residential sector.
II. The Ministry of New and Renewable Energy aims to impart training on installation, operation, maintenance and repairs of solar rooftop systems at grassroot levels.
III. It aims to create more than three lakhs skilled manpower through fresh skilling, and upskilling, under scheme component of capacity building.
Which of the statements given above are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"I and III only"},{"key":"C","text":"II and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q71','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','71',
'"Sedition has become my religion" was the famous statement given by Gandhiji at the time of',
'[{"key":"A","text":"the Champaran Satyagraha"},{"key":"B","text":"publicly violating Salt Law at Dandi"},{"key":"C","text":"attending the Second Round Table Conference in London"},{"key":"D","text":"the launch of the Quit India Movement"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q72','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','72',
'The famous female figurine known as ''Dancing Girl'', found at Mohenjo-daro, is made of',
'[{"key":"A","text":"carnelian"},{"key":"B","text":"clay"},{"key":"C","text":"bronze"},{"key":"D","text":"gold"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q73','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','73',
'Who provided legal defence to the people arrested in the aftermath of Chauri Chaura incident?',
'[{"key":"A","text":"C. R. Das"},{"key":"B","text":"Madan Mohan Malaviya and Krishna Kant"},{"key":"C","text":"Dr. Saifuddin Kitchlew and Khwaja Hasan Nizami"},{"key":"D","text":"M. A. Jinnah"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q74','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','74',
'Subsequent to which one of the following events, Gandhiji, who consistently opposed untouchability and appealed for its eradication from all spheres, decided to include the upliftment of ''Harijans'' in his political and social programme?',
'[{"key":"A","text":"The Poona Pact"},{"key":"B","text":"The Gandhi-Irwin Agreement (Delhi Pact)"},{"key":"C","text":"Arrest of Congress leadership at the time of the Quit India Movement"},{"key":"D","text":"Promulgation of the Government of India Act, 1935"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q75','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','75',
'Consider the following fruits:
I. Papaya
II. Pineapple
III. Guava
How many of the above were introduced in India by the Portuguese in the sixteenth and seventeenth centuries?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q76','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Geography','76',
'Consider the following countries:
I. United Kingdom
II. Denmark
III. New Zealand
IV. Australia
V. Brazil
How many of the above countries have more than four time zones?',
'[{"key":"A","text":"All the five"},{"key":"B","text":"Only four"},{"key":"C","text":"Only three"},{"key":"D","text":"Only two"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q77','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Geography','77',
'Consider the following statements:
I. Anadyr in Siberia and Nome in Alaska are a few kilometers from each other, but when people are waking up and getting set for breakfast in these cities, it would be different days.
II. When it is Monday in Anadyr, it is Tuesday in Nome.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q78','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','History','78',
'Who among the following was the founder of the ''Self-Respect Movement''?',
'[{"key":"A","text":"''Periyar'' E. V. Ramaswamy Naicker"},{"key":"B","text":"Dr. B. R. Ambedkar"},{"key":"C","text":"Bhaskarrao Jadhav"},{"key":"D","text":"Dinkarrao Javalkar"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q79','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Geography','79',
'Consider the following pairs:
Country — Resource-rich in
(I) Botswana — Diamond
(II) Chile — Lithium
(III) Indonesia — Nickel
In how many of the above rows is the given information correctly matched?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q80','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Geography','80',
'Consider the following pairs:
Region — Country
(I) Mallorca — Italy
(II) Normandy — Spain
(III) Sardinia — France
In how many of the above rows is the given information correctly matched?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q81','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','81',
'Consider the following statements:
Statement I: Some rare earth elements are used in the manufacture of flat television screens and computer monitors.
Statement II: Some rare earth elements have phosphorescent properties.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement I and Statement II are correct and Statement II explains Statement I"},{"key":"B","text":"Both Statement I and Statement II are correct but Statement II does not explain Statement I"},{"key":"C","text":"Statement I is correct but Statement II is not correct"},{"key":"D","text":"Statement I is not correct but Statement II is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q82','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','82',
'Consider the following statements:
I. Indian Railways have prepared a National Rail Plan (NRP) to create a ''future ready'' railway system by 2028.
II. ''Kavach'' is an Automatic Train Protection system developed in collaboration with Germany.
III. ''Kavach'' system consists of RFID tags fitted on track in station section.
Which of the statements given above are not correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q83','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','83',
'Consider the following space missions:
I. Axiom-4
II. SpaDeX
III. Gaganyaan
How many of the space missions given above encourage and support microgravity research?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q84','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','84',
'With reference to India''s defence, consider the following pairs:
Aircraft type — Description
(I) Dornier-228 — Maritime patrol aircraft
(II) IL-76 — Supersonic combat aircraft
(III) C-17 Globemaster III — Military transport aircraft
How many of the pairs given above are correctly matched?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All the three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q85','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','85',
'Artificial way of causing rainfall to reduce air pollution makes use of',
'[{"key":"A","text":"silver iodide and potassium iodide"},{"key":"B","text":"silver nitrate and potassium iodide"},{"key":"C","text":"silver iodide and potassium nitrate"},{"key":"D","text":"silver nitrate and potassium chloride"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q86','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','86',
'Consider the following statements with regard to pardoning power of the President of India:
I. The exercise of this power by the President can be subjected to limited judicial review.
II. The President can exercise this power without the advice of the Central Government.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q87','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','87',
'Consider the following statements:
I. On the dissolution of the House of the People, the Speaker shall not vacate his/her office until immediately before the first meeting of the House of the People after the dissolution.
II. According to the provisions of the Constitution of India, a Member of the House of the People on being elected as Speaker shall resign from his/her political party immediately.
III. The Speaker of the House of the People may be removed from his/her office by a resolution of the House of the People passed by a majority of all the then Members of the House, provided that no resolution shall be moved unless at least fourteen days'' notice has been given of the intention to move the resolution.
Which of the statements given above are correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q88','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','88',
'Consider the following statements:
I. If any question arises as to whether a Member of the House of the People has become subject to disqualification under the 10th Schedule, the President''s decision in accordance with the opinion of the Council of Union Ministers shall be final.
II. There is no mention of the word ''political party'' in the Constitution of India.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q89','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','89',
'Consider the following statements:
Statement I: In India, State Governments have no power for making rules for grant of concessions in respect of extraction of minor minerals even though such minerals are located in their territories.
Statement II: In India, the Central Government has the power to notify minor minerals under the relevant law.
Which one of the following is correct in respect of the above statements?',
'[{"key":"A","text":"Both Statement I and Statement II are correct and Statement II explains Statement I"},{"key":"B","text":"Both Statement I and Statement II are correct but Statement II does not explain Statement I"},{"key":"C","text":"Statement I is correct but Statement II is not correct"},{"key":"D","text":"Statement I is not correct but Statement II is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q90','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Environment & Ecology','90',
'Which organization has enacted the Nature Restoration Law (NRL) to tackle climate change and biodiversity loss?',
'[{"key":"A","text":"The European Union"},{"key":"B","text":"The World Bank"},{"key":"C","text":"The Organization for Economic Cooperation and Development"},{"key":"D","text":"The Food and Agriculture Organization"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q91','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','91',
'Consider the following statements:
I. Panchayats at the intermediate level exist in all States.
II. To be eligible to be a Member of a Panchayat at the intermediate level, a person should attain the age of thirty years.
III. The Chief Minister of a State constitutes a commission to review the financial position of Panchayats at the intermediate levels and to make recommendations regarding the distribution of net proceeds of taxes and duties, leviable by the State, between the State and Panchayats at the intermediate level.
Which of the statements given above are not correct?',
'[{"key":"A","text":"I and II only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q92','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Current Affairs','92',
'Consider the following statements in respect of BIMSTEC:
I. It is a regional organization consisting of seven member States till January 2025.
II. It came into existence with the signing of the Dhaka Declaration, 1999.
III. Bangladesh, India, Sri Lanka, Thailand and Nepal are founding member States of BIMSTEC.
IV. In BIMSTEC, the subsector of ''tourism'' is being led by India.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I and II"},{"key":"B","text":"II and III"},{"key":"C","text":"I and IV"},{"key":"D","text":"I only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q93','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','93',
'Who amongst the following are members of the Jury to select the recipient of ''Gandhi Peace Prize''?
I. The President of India
II. The Prime Minister of India
III. The Chief Justice of India
IV. The Leader of Opposition in the Lok Sabha
Select the correct answer using the code given below.',
'[{"key":"A","text":"II and IV only"},{"key":"B","text":"I, II and III"},{"key":"C","text":"II, III and IV"},{"key":"D","text":"I and III only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q94','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Science & Technology','94',
'GPS-Aided Geo Augmented Navigation (GAGAN) uses a system of ground stations to provide necessary augmentation. Which of the following statements is/are correct in respect of GAGAN?
I. It is designed to provide additional accuracy and integrity.
II. It will allow more uniform and high quality air traffic management.
III. It will provide benefits only in aviation but not in other modes of transportation.
Select the correct answer using the code given below.',
'[{"key":"A","text":"I, II and III"},{"key":"B","text":"II and III only"},{"key":"C","text":"I only"},{"key":"D","text":"I and II only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q95','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Current Affairs','95',
'Consider the following statements regarding AI Action Summit held in Grand Palais, Paris in February 2025:
I. Co-chaired with India, the event builds on the advances made at the Bletchley Park Summit held in 2023 and the Seoul Summit held in 2024.
II. Along with other countries, US and UK also signed the declaration on inclusive and sustainable AI.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q96','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Current Affairs','96',
'Consider the following pairs:
(I) International Year of the Woman Farmer — 2026
(II) International Year of Sustainable and Resilient Tourism — 2027
(III) International Year of Peace and Trust — 2025
(IV) International Year of Asteroid Awareness and Planetary Defence — 2029
How many of the pairs given above are correctly matched?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"Only three"},{"key":"D","text":"All the four"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q97','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Current Affairs','97',
'Consider the following statements with regard to BRICS:
I. 16th BRICS Summit was held under the Chairship of Russia in Kazan.
II. Indonesia has become a full member of BRICS.
III. The theme of the 16th BRICS Summit was ''Strengthening Multiculturalism for Just Global Development and Security''.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I and II"},{"key":"B","text":"II and III"},{"key":"C","text":"I and III"},{"key":"D","text":"I only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q98','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Polity & Governance','98',
'Consider the following statements about Lokpal:
I. The power of Lokpal applies to public servants of India, but not to the Indian public servants posted outside India.
II. The Chairperson or a Member shall not be a Member of the Parliament or a Member of the Legislature of any State or Union Territory, and only the Chief Justice of India, whether incumbent or retired, has to be its Chairperson.
III. The Chairperson or a Member shall not be a person of less than forty-five years of age on the date of assuming office as the Chairperson or Member, as the case may be.
IV. Lokpal cannot inquire into the allegations of corruption against a sitting Prime Minister of India.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"III only"},{"key":"B","text":"II and III"},{"key":"C","text":"I and IV"},{"key":"D","text":"None of the above statements is correct"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q99','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Current Affairs','99',
'Consider the following statements in respect of the first Kho Kho World Cup:
I. The event was held in Delhi, India.
II. Indian men beat Nepal with a score of 78-40 in the final to become the World Champion in men category.
III. Indian women beat Nepal with a score of 54-36 in the final to become the World Champion in women category.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II and III only"},{"key":"C","text":"I and III only"},{"key":"D","text":"I, II and III"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-2025-pre-gs1-q100','upsc-cse','upsc-cse-prelims-2025-gs1','UPSC Civil Services Examination','2025','GS Paper I','Current Affairs','100',
'Consider the following statements:
I. In the finals of the 45th Chess Olympiad held in 2024, Gukesh Dommaraju became the world''s youngest winner after defeating the Russian player Ian Nepomniachtchi.
II. Abhimanyu Mishra, an American chess player, holds the record of becoming world''s youngest ever Grandmaster.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"I only"},{"key":"B","text":"II only"},{"key":"C","text":"Both I and II"},{"key":"D","text":"Neither I nor II"}]'::jsonb,
'','','','[]'::jsonb);

-- Update paper question count
UPDATE vaultcore.papers SET questions = 100, updated_at = CURRENT_TIMESTAMP
WHERE slug = 'upsc-cse-prelims-2025-gs1';
