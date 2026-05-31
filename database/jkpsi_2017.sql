-- JKSSB Sub Inspector of Police (PSI) — 13 May 2017
-- 120 questions | No answers/explanations | −0.25 negative marking

INSERT INTO vaultcore.papers (slug, exam_slug, exam_name, title, year, shift, description, questions, subjects, negative_marking, duration_minutes, held_on)
VALUES (
  'jkpsi-2017',
  'jkssb',
  'JKSSB',
  'JKSSB Sub Inspector of Police (PSI) 2017',
  '2017',
  'Sub Inspector',
  'Complete JKSSB Sub Inspector of Police (PSI) 2017 question paper held on 13 May 2017. Contains 120 objective MCQs covering General Knowledge, Current Affairs, History, Geography, Polity & Constitution, General Science, Economy, J&K Studies, and Quantitative Aptitude.',
  120,
  '["General Knowledge & Current Affairs","History","Geography","J&K General Knowledge","Polity & Constitution","General Science","Economy","Quantitative Aptitude & Reasoning"]'::jsonb,
  0.25,
  120,
  '2017-05-13'
)
ON CONFLICT (slug) DO UPDATE SET
  title = EXCLUDED.title, description = EXCLUDED.description,
  questions = EXCLUDED.questions, subjects = EXCLUDED.subjects,
  negative_marking = EXCLUDED.negative_marking, duration_minutes = EXCLUDED.duration_minutes,
  held_on = EXCLUDED.held_on, updated_at = CURRENT_TIMESTAMP;

INSERT INTO vaultcore.questions (slug, exam_slug, paper_slug, exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags)
VALUES

('jkpsi-2017-q1','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','1',
'In the context of computing software, which of the following is not an operating system?',
'[{"key":"A","text":"Android"},{"key":"B","text":"iOS"},{"key":"C","text":"Windows"},{"key":"D","text":"Microsoft Office"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Technology","General Knowledge"]'::jsonb),

('jkpsi-2017-q2','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','2',
'Consider the following statements about Particulate Matter (PM): (i) Mixture of solid particles and liquid droplets found in the air. (ii) Dust from construction sites and unpaved roads is a major source of PM in the air. (iii) Over exposure to PM can lead to respiratory disorders. Which of the above statements are correct?',
'[{"key":"A","text":"(i) and (ii) only"},{"key":"B","text":"(i) and (iii) only"},{"key":"C","text":"(ii) and (iii) only"},{"key":"D","text":"(i), (ii) and (iii)"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Environment","Pollution"]'::jsonb),

('jkpsi-2017-q3','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','3',
'When is the World Environment Day observed?',
'[{"key":"A","text":"21st January"},{"key":"B","text":"5th June"},{"key":"C","text":"21st July"},{"key":"D","text":"5th October"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Environment","Current Affairs"]'::jsonb),

('jkpsi-2017-q4','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','4',
'The Paris Agreement on climate change seeks to',
'[{"key":"A","text":"Ban the use of hydrocarbons by 2030"},{"key":"B","text":"Reduce the use of hydrofluorocarbons"},{"key":"C","text":"Keep the increase in global average temperature to well below 2°C above pre-industrial levels"},{"key":"D","text":"All the above"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Environment","International Affairs"]'::jsonb),

('jkpsi-2017-q5','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','5',
'The Fourth Buddhist Council was held in Kashmir under the leadership of',
'[{"key":"A","text":"Ashoka"},{"key":"B","text":"Bindusara"},{"key":"C","text":"Kunal"},{"key":"D","text":"Kanishka"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Ancient India","J&K History"]'::jsonb),

('jkpsi-2017-q6','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','6',
'The Border Area Development Programme is a scheme of the',
'[{"key":"A","text":"Ministry of Home Affairs"},{"key":"B","text":"Ministry of Defence"},{"key":"C","text":"Ministry of External Affairs"},{"key":"D","text":"Ministry of Law and Justice"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Government Schemes"]'::jsonb),

('jkpsi-2017-q7','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','J&K General Knowledge','7',
'Among other things, excavations at Ambaran-Pamberwan sites near Akhnoor have proved that:',
'[{"key":"A","text":"It was a Neolithic settlement"},{"key":"B","text":"It was an iron-age settlement"},{"key":"C","text":"It was a burial site"},{"key":"D","text":"It was associated with Buddhism"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","J&K History","Archaeology"]'::jsonb),

('jkpsi-2017-q8','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','8',
'Which one of the following is a renewable source of energy?',
'[{"key":"A","text":"Natural Gas"},{"key":"B","text":"Wind energy"},{"key":"C","text":"Petroleum"},{"key":"D","text":"Nuclear energy"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Energy"]'::jsonb),

('jkpsi-2017-q9','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','9',
'Light years is a measure of',
'[{"key":"A","text":"Time"},{"key":"B","text":"Distance"},{"key":"C","text":"Speed"},{"key":"D","text":"Luminosity"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Physics","Astronomy"]'::jsonb),

('jkpsi-2017-q10','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','10',
'The McMahon Line is mentioned in the context of relations between India and',
'[{"key":"A","text":"Nepal"},{"key":"B","text":"Pakistan"},{"key":"C","text":"Bangladesh"},{"key":"D","text":"China"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","International Relations","Geography"]'::jsonb),

('jkpsi-2017-q11','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','11',
'Annie Besant formed the Home Rule League in India based on the pattern of Home Rule Movement in',
'[{"key":"A","text":"Ireland"},{"key":"B","text":"Scotland"},{"key":"C","text":"England"},{"key":"D","text":"Wales"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Freedom Struggle"]'::jsonb),

('jkpsi-2017-q12','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','12',
'Consider the following statements about Rabindranath Tagore: (i) He composed a number of patriotic songs during the Swadeshi movement. (ii) He returned his knighthood to condemn the brutal killing of innocent people at Jallianwala Bagh. (iii) He refused to accept the Nobel Prize. Which of the statements given above is/are correct?',
'[{"key":"A","text":"(i) only"},{"key":"B","text":"(ii) only"},{"key":"C","text":"(iii) only"},{"key":"D","text":"(i) and (ii)"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Freedom Struggle","Art & Culture"]'::jsonb),

('jkpsi-2017-q13','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','13',
'The famous historical book "Travels in the Mughal Empire" was written by',
'[{"key":"A","text":"Ibn Batuta"},{"key":"B","text":"Francois Bernier"},{"key":"C","text":"Al-Biruni"},{"key":"D","text":"Thomas Roe"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Medieval India","Literature"]'::jsonb),

('jkpsi-2017-q14','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','14',
'Which one among the following was not a feature of the provincial executive as envisaged by the Government of India Act, 1935?',
'[{"key":"A","text":"The executive authority of the province was vested in the Governor"},{"key":"B","text":"There was a Council of Ministers to advise the Governor"},{"key":"C","text":"Dyarchy established by the Government of India Act, 1919 was abolished at the provincial level"},{"key":"D","text":"The Governor could be removed by a vote of no confidence to the Provincial legislature"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Modern India","Constitutional History"]'::jsonb),

('jkpsi-2017-q15','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Economy','15',
'Which of the following statements about India''s unorganized sector are true? (i) Labour is more in number than that in the organized sector. (ii) Job security and work regulation are better in unorganized sector. (iii) They are usually not organized into trade unions. Which of the above statements is/are correct?',
'[{"key":"A","text":"(i) only"},{"key":"B","text":"(i) and (ii) only"},{"key":"C","text":"(i) and (iii) only"},{"key":"D","text":"(i), (ii) and (iii)"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Economy","Labour"]'::jsonb),

('jkpsi-2017-q16','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Economy','16',
'In India, mergers and acquisition of firms are regulated by',
'[{"key":"A","text":"National Manufacturing Competitiveness Council"},{"key":"B","text":"Competition Commission of India"},{"key":"C","text":"Securities and Exchange Board of India"},{"key":"D","text":"Department of Industrial Policy and Promotion"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Economy","Regulatory Bodies"]'::jsonb),

('jkpsi-2017-q17','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Economy','17',
'Share of food in total consumption expenditure has been coming down as per capita income grew over time in the last sixty years because',
'[{"key":"A","text":"People have been purchasing less food"},{"key":"B","text":"People have been preferring non-cereal items in their food basket"},{"key":"C","text":"Growth in food expenditure has been lower than growth in per capita income"},{"key":"D","text":"Percentage of the poor in population has increased over time"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Economy","Consumption"]'::jsonb),

('jkpsi-2017-q18','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','18',
'The only Wild Ass sanctuary in India can be found at',
'[{"key":"A","text":"Barmer in Rajasthan"},{"key":"B","text":"Jaisalmer"},{"key":"C","text":"Rann of Kutch"},{"key":"D","text":"Daman"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Environment","Wildlife","Geography"]'::jsonb),

('jkpsi-2017-q19','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','19',
'Pradhan Mantri Ujjwala Yojana is aimed at',
'[{"key":"A","text":"Providing LED bulb to all BPL families"},{"key":"B","text":"Providing LPG connections to all BPL households"},{"key":"C","text":"Providing electricity to all BPL households"},{"key":"D","text":"Providing smokeless kerosene stoves to all households"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Government Schemes","Current Affairs"]'::jsonb),

('jkpsi-2017-q20','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','20',
'Apart from Costa Rica, the Olive Ridley turtles also nest along the coast of one of the states of the country which has recently issued a ban on fishing for six months to protect this endangered species. Which of the following is the concerned state?',
'[{"key":"A","text":"West Bengal"},{"key":"B","text":"Andhra Pradesh"},{"key":"C","text":"Odisha"},{"key":"D","text":"Karnataka"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Environment","Wildlife","Current Affairs"]'::jsonb),

('jkpsi-2017-q21','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','21',
'Megasthenes visited India during the reign of',
'[{"key":"A","text":"Chandragupta Vikramaditya"},{"key":"B","text":"Chandragupta Maurya"},{"key":"C","text":"Ashoka"},{"key":"D","text":"Harsha"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Ancient India"]'::jsonb),

('jkpsi-2017-q22','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','22',
'The remains of the Vijayanagar empire can be found at',
'[{"key":"A","text":"Bijapur"},{"key":"B","text":"Golconda"},{"key":"C","text":"Hampi"},{"key":"D","text":"Baroda"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Medieval India"]'::jsonb),

('jkpsi-2017-q23','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','23',
'Initially an associate of Gandhi, he left the Congress, broke off with Gandhi and launched a radical social movement called the Self-Respect Movement. The reference here is to',
'[{"key":"A","text":"Chhatrapati Maharaj"},{"key":"B","text":"E.V.R. Naicker"},{"key":"C","text":"P. Tyagaraya Chetti"},{"key":"D","text":"Jyotirao Govind Rao Phule"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Freedom Struggle","Social Reform"]'::jsonb),

('jkpsi-2017-q24','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','24',
'The movement that came to an abrupt end because of the Chauri Chaura incident was the',
'[{"key":"A","text":"Wahabi movement"},{"key":"B","text":"Home Rule movement"},{"key":"C","text":"Non-Cooperation movement"},{"key":"D","text":"Civil Disobedience movement"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Freedom Struggle"]'::jsonb),

('jkpsi-2017-q25','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Geography','25',
'Mango shower is associated with which one of the following states?',
'[{"key":"A","text":"Punjab and Haryana"},{"key":"B","text":"Uttar Pradesh and Bihar"},{"key":"C","text":"Gujarat and Odisha"},{"key":"D","text":"Kerala and Karnataka"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Geography","Climate","Agriculture"]'::jsonb),

('jkpsi-2017-q26','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Geography','26',
'Which one is the major river of Tamil Nadu?',
'[{"key":"A","text":"Narmada"},{"key":"B","text":"Kaveri"},{"key":"C","text":"Tapti"},{"key":"D","text":"Indus"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Geography","Rivers"]'::jsonb),

('jkpsi-2017-q27','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','J&K General Knowledge','27',
'How was the Wular Lake formed?',
'[{"key":"A","text":"It is a reservoir of a Hydel power project"},{"key":"B","text":"It is an ox-bow lake formed by the river Jhelum"},{"key":"C","text":"It was formed due to glacial activity"},{"key":"D","text":"It was formed due to tectonic activity"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","J&K Geography","Lakes","Geography"]'::jsonb),

('jkpsi-2017-q28','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Geography','28',
'Duration of day and night in a country is influenced by its',
'[{"key":"A","text":"Latitudinal extent"},{"key":"B","text":"Longitudinal extent"},{"key":"C","text":"Equator"},{"key":"D","text":"Prime Meridian"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Geography","Earth Science"]'::jsonb),

('jkpsi-2017-q29','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Geography','29',
'Which one of the following water bodies separates Sri Lanka from India?',
'[{"key":"A","text":"Palk Strait and Gulf of Khambhat"},{"key":"B","text":"Palk Strait and Gulf of Mannar"},{"key":"C","text":"Gulf of Mannar and 10 Degree Channel"},{"key":"D","text":"10 Degree Channel and Gulf of Khambhat"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Geography","Water Bodies","International"]'::jsonb),

('jkpsi-2017-q30','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','30',
'The ideals of liberty, equality and fraternity enshrined in the Preamble of the Constitution of India were inspired by',
'[{"key":"A","text":"The French Revolution"},{"key":"B","text":"The Russian Revolution"},{"key":"C","text":"The American Declaration of Independence"},{"key":"D","text":"The Chinese Revolution"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Constitution","Preamble"]'::jsonb),

('jkpsi-2017-q31','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','31',
'In which state is the Manas National Park located?',
'[{"key":"A","text":"Assam"},{"key":"B","text":"Rajasthan"},{"key":"C","text":"West Bengal"},{"key":"D","text":"Tamil Nadu"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Environment","National Parks","Geography"]'::jsonb),

('jkpsi-2017-q32','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','32',
'In blood, platelets are required for',
'[{"key":"A","text":"Transporting oxygen"},{"key":"B","text":"Transporting carbon dioxide"},{"key":"C","text":"Initiating clotting of blood"},{"key":"D","text":"Immunity"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Biology","Human Body"]'::jsonb),

('jkpsi-2017-q33','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','33',
'Which attribute of a sound wave is related to the loudness of sound?',
'[{"key":"A","text":"Amplitude"},{"key":"B","text":"Frequency"},{"key":"C","text":"Pitch"},{"key":"D","text":"Speed"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Physics","Sound"]'::jsonb),

('jkpsi-2017-q34','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','34',
'Who among the following was associated with the Mughal Court as a physician to Prince Dara Shikoh?',
'[{"key":"A","text":"Hakim Afzal Khan"},{"key":"B","text":"Francois Bernier"},{"key":"C","text":"Ibn Batuta"},{"key":"D","text":"Duarte Barbosa"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Medieval India","Mughals"]'::jsonb),

('jkpsi-2017-q35','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','35',
'An emergency under Article 352 of the Indian Constitution can be declared only during:',
'[{"key":"A","text":"Failure of constitutional machinery in a State"},{"key":"B","text":"Financial instability"},{"key":"C","text":"War, external aggression or internal disturbance"},{"key":"D","text":"War, external aggression or armed rebellion"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Constitution","Emergency Provisions"]'::jsonb),

('jkpsi-2017-q36','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','36',
'The provision of the Indian Constitution that most clearly expresses the power of Judicial Review is:',
'[{"key":"A","text":"Article 14"},{"key":"B","text":"Article 21"},{"key":"C","text":"Article 32"},{"key":"D","text":"Article 44"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Constitution","Judiciary"]'::jsonb),

('jkpsi-2017-q37','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','37',
'The SAARC Secretariat is located at:',
'[{"key":"A","text":"Kathmandu"},{"key":"B","text":"Colombo"},{"key":"C","text":"Islamabad"},{"key":"D","text":"Male"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","International Affairs","SAARC"]'::jsonb),

('jkpsi-2017-q38','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','38',
'Pradhan Mantri Jan Dhan Yojana has been launched for:',
'[{"key":"A","text":"Providing housing loans to persons below the poverty line"},{"key":"B","text":"Promoting women''s Self Help Groups"},{"key":"C","text":"Promoting financial inclusion in the country"},{"key":"D","text":"Promoting loans to start-up business ventures"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Government Schemes","Economy","Current Affairs"]'::jsonb),

('jkpsi-2017-q39','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Geography','39',
'Which one of the following pairs of States of India indicates the easternmost and westernmost State?',
'[{"key":"A","text":"Assam and Rajasthan"},{"key":"B","text":"Manipur and Gujarat"},{"key":"C","text":"Nagaland and Rajasthan"},{"key":"D","text":"Arunachal Pradesh and Gujarat"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Geography","India"]'::jsonb),

('jkpsi-2017-q40','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','40',
'Consider the following statements: (i) A Money Bill can be introduced in any of the Houses of Parliament. (ii) The determination whether a Bill is a Money Bill is made by the Union Cabinet. Which of the above statements are correct?',
'[{"key":"A","text":"Only (i)"},{"key":"B","text":"Only (ii)"},{"key":"C","text":"Both (i) and (ii)"},{"key":"D","text":"Neither (i) nor (ii)"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Parliament","Money Bill"]'::jsonb),

('jkpsi-2017-q41','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','41',
'The Government of India Act, 1919, clearly defined:',
'[{"key":"A","text":"The separation of powers between the judiciary and the executive"},{"key":"B","text":"The jurisdictions of the Central and Provincial Governments"},{"key":"C","text":"The powers of the Secretary of State for India and the Viceroy"},{"key":"D","text":"None of the above"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Constitutional History","Modern India"]'::jsonb),

('jkpsi-2017-q42','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','42',
'The area known as "Golan Heights" sometimes appears in the news in the context of the events related to:',
'[{"key":"A","text":"Middle East"},{"key":"B","text":"Central Asia"},{"key":"C","text":"South East Asia"},{"key":"D","text":"Sub-Saharan Africa"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","International Affairs","Geography","Current Affairs"]'::jsonb),

('jkpsi-2017-q43','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','43',
'The Government of India has established the NITI Aayog to replace the:',
'[{"key":"A","text":"Finance Commission"},{"key":"B","text":"Planning Commission"},{"key":"C","text":"Pay Commission"},{"key":"D","text":"National Economic Advisory Board"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Government Bodies","Current Affairs"]'::jsonb),

('jkpsi-2017-q44','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','44',
'Consider the following: (i) The executive power of the Union of India is vested in the Prime Minister. (ii) The Prime Minister of India must be an elected member of the Lok Sabha. Which of the above statements is/are correct?',
'[{"key":"A","text":"(i) Only"},{"key":"B","text":"(ii) only"},{"key":"C","text":"Both (i) and (ii)"},{"key":"D","text":"Neither (i) nor (ii)"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Constitution","Executive"]'::jsonb),

('jkpsi-2017-q45','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','45',
'The provisions of the Fifth and Sixth Schedules of the Indian Constitution have been made in order to:',
'[{"key":"A","text":"Protect the interests of the Scheduled Tribes"},{"key":"B","text":"Protect the interests of the Minority communities"},{"key":"C","text":"Protect the interests of the Scheduled Castes"},{"key":"D","text":"Protect the interests of Women and Children"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Constitution","Schedules"]'::jsonb),

('jkpsi-2017-q46','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','46',
'Which part of the Indian Constitution enshrines the idea of a Welfare State?',
'[{"key":"A","text":"Preamble"},{"key":"B","text":"Fundamental Rights"},{"key":"C","text":"Directive Principles of State Policy"},{"key":"D","text":"Fundamental Duties"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Constitution","DPSP"]'::jsonb),

('jkpsi-2017-q47','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','47',
'Which one of the following countries is known as the "Land of the Thousand Lakes"?',
'[{"key":"A","text":"Denmark"},{"key":"B","text":"Finland"},{"key":"C","text":"The Netherlands"},{"key":"D","text":"Poland"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","International","World Geography"]'::jsonb),

('jkpsi-2017-q48','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Geography','48',
'Which of the following pairs of glaciers and locations is not correctly matched?',
'[{"key":"A","text":"Nubra Valley Glacier — Arunachal Pradesh"},{"key":"B","text":"Milam Glacier — Uttarakhand"},{"key":"C","text":"Bhaga Valley Glacier — Himachal Pradesh"},{"key":"D","text":"Zemu Glacier — Sikkim"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Geography","Glaciers","J&K"]'::jsonb),

('jkpsi-2017-q49','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','49',
'The Central Potato Research Institute is located at',
'[{"key":"A","text":"Almora"},{"key":"B","text":"Shimla"},{"key":"C","text":"Noida"},{"key":"D","text":"Murshidabad"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Knowledge","Research Institutes","Agriculture"]'::jsonb),

('jkpsi-2017-q50','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','50',
'Which one of the following gases is not responsible for global warming?',
'[{"key":"A","text":"Water vapour"},{"key":"B","text":"Oxygen"},{"key":"C","text":"Nitrous Oxide"},{"key":"D","text":"Methane"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Environment","Climate Change"]'::jsonb),

('jkpsi-2017-q51','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','51',
'Which of the following statements regarding temperature of an object in Kelvin scale is/are correct? (i) It can be a negative, zero or positive quantity. (ii) It can either be a negative or a positive quantity. (iii) It can never be negative. (iv) It can be a zero or a positive definite quantity. Select the correct answer using the code given below.',
'[{"key":"A","text":"(i) and (ii) only"},{"key":"B","text":"(ii) and (iv) only"},{"key":"C","text":"(iii) and (iv) only"},{"key":"D","text":"(iv) only"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Physics","Temperature"]'::jsonb),

('jkpsi-2017-q52','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','52',
'Graphite is a good conductor of electricity. It is because of its',
'[{"key":"A","text":"linear structure"},{"key":"B","text":"tetrahedral structure"},{"key":"C","text":"trigonal planar structure"},{"key":"D","text":"hexagonal multilayer structure"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Chemistry","Carbon"]'::jsonb),

('jkpsi-2017-q53','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','53',
'Which one among the following is responsible for the command, control and operational decisions of nuclear weapons in India?',
'[{"key":"A","text":"Nuclear Commission of India"},{"key":"B","text":"Nuclear Command Authority"},{"key":"C","text":"The Ministry of Defence"},{"key":"D","text":"The Cabinet Committee on Security"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Defence","Nuclear","General Knowledge"]'::jsonb),

('jkpsi-2017-q54','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','54',
'Which one of the following Articles of the Constitution of India provides that the State shall not deny to any person equality before the law or the equal protection of the laws within the territory of India?',
'[{"key":"A","text":"Article 14"},{"key":"B","text":"Article 12"},{"key":"C","text":"Article 13"},{"key":"D","text":"Article 15"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Constitution","Fundamental Rights"]'::jsonb),

('jkpsi-2017-q55','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','55',
'The Counter Insurgency and Jungle Warfare School of the Indian Army is located at',
'[{"key":"A","text":"Khadakvasla"},{"key":"B","text":"Dehradun"},{"key":"C","text":"Vairengte"},{"key":"D","text":"Gulmarg"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Defence","Army","General Knowledge"]'::jsonb),

('jkpsi-2017-q56','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','56',
'INS Kalvari which was commissioned into the Indian Navy in December 2017 is a/an:',
'[{"key":"A","text":"Aircraft Carrier"},{"key":"B","text":"Armoured Frigate"},{"key":"C","text":"Battleship"},{"key":"D","text":"Submarine"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Defence","Navy","Current Affairs"]'::jsonb),

('jkpsi-2017-q57','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','57',
'The Doctrine of Lapse was a policy that aimed to',
'[{"key":"A","text":"Control the rebellions in the Princely States"},{"key":"B","text":"Extend the military strength of the British"},{"key":"C","text":"Regulate the landlords"},{"key":"D","text":"Extend the territorial boundaries of the English East India Company"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Modern India","British India"]'::jsonb),

('jkpsi-2017-q58','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','58',
'The Permanent Settlement of 1799 introduced',
'[{"key":"A","text":"Peasant rights"},{"key":"B","text":"The Zamindari system"},{"key":"C","text":"Shipping rights for the East India Company"},{"key":"D","text":"Property rights for women"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Modern India","Land Revenue"]'::jsonb),

('jkpsi-2017-q59','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','59',
'Consider the following statements about Grand Slam tennis tournaments: (i) There are four Grand Slam annual tennis tournaments. (ii) The first Grand Slam of a year is the US Open. (iii) The Australian and the US tournaments are played on clay courts. Which of the statements given above is/are correct?',
'[{"key":"A","text":"(i), (ii) and (iii)"},{"key":"B","text":"(i) and (ii) only"},{"key":"C","text":"(i) only"},{"key":"D","text":"(ii) and (iii) only"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Sports","Tennis","General Knowledge"]'::jsonb),

('jkpsi-2017-q60','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','60',
'After diagnosis of disease in the person, the doctor advises the patient iron and folic acid tablets. The person is suffering from',
'[{"key":"A","text":"Osteoporosis"},{"key":"B","text":"Anaemia"},{"key":"C","text":"Goitre"},{"key":"D","text":"Protein-energy malnutrition"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Biology","Health"]'::jsonb),

('jkpsi-2017-q61','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','61',
'Bernoulli''s principle is based on which one among the following laws?',
'[{"key":"A","text":"Conservation of mass"},{"key":"B","text":"Conservation of momentum"},{"key":"C","text":"Conservation of angular momentum"},{"key":"D","text":"Conservation of energy"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Physics","Fluid Mechanics"]'::jsonb),

('jkpsi-2017-q62','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','62',
'The temperature of water at the bottom of a lake whose upper surface has frozen to ice would be around (in degrees Celsius)',
'[{"key":"A","text":"−10"},{"key":"B","text":"0"},{"key":"C","text":"4"},{"key":"D","text":"−4"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Physics","Temperature"]'::jsonb),

('jkpsi-2017-q63','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Geography','63',
'Taungup Pass is a mountain corridor connecting India with',
'[{"key":"A","text":"Nepal"},{"key":"B","text":"China"},{"key":"C","text":"Pakistan"},{"key":"D","text":"Myanmar"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Geography","Mountain Passes","International"]'::jsonb),

('jkpsi-2017-q64','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','64',
'Which of the following Indus Valley Civilization sites are located in India? (i) Mohenjo-daro (ii) Harappa (iii) Babar Kot (iv) Dholavira. Choose the correct answer from the following:',
'[{"key":"A","text":"(i) and (iv) only"},{"key":"B","text":"(ii) and (iii) only"},{"key":"C","text":"(iii) and (iv) only"},{"key":"D","text":"(iv) only"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Ancient India","IVC"]'::jsonb),

('jkpsi-2017-q65','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','65',
'The pressure exerted by a 760 mm column of mercury at 0°C is known as',
'[{"key":"A","text":"1 pascal"},{"key":"B","text":"1 atmosphere"},{"key":"C","text":"1 bar"},{"key":"D","text":"1 poise"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Physics","Pressure"]'::jsonb),

('jkpsi-2017-q66','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','66',
'Which one of the following hormones is essential for the uptake of glucose by cells in the human body?',
'[{"key":"A","text":"GH"},{"key":"B","text":"TSH"},{"key":"C","text":"Insulin"},{"key":"D","text":"Cortisol"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Biology","Human Body","Hormones"]'::jsonb),

('jkpsi-2017-q67','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','67',
'Altitude sickness is caused at high altitude due to',
'[{"key":"A","text":"High partial pressure of oxygen"},{"key":"B","text":"Low partial pressure of oxygen"},{"key":"C","text":"Low level of haemoglobin"},{"key":"D","text":"High partial pressure of carbon dioxide"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Biology","Health"]'::jsonb),

('jkpsi-2017-q68','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','68',
'Which one of the following statements is not correct with respect to protection of individuals being tried for offences?',
'[{"key":"A","text":"A confession can never be used as evidence against the accused"},{"key":"B","text":"The accused must have violated an existing law"},{"key":"C","text":"An accused cannot be tried and punished for the same offence again"},{"key":"D","text":"The quantum of punishment must be provided in law as it existed on the date of commission of an offence"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Fundamental Rights","Criminal Law"]'::jsonb),

('jkpsi-2017-q69','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','69',
'The headquarters of Economic and Social Commission for Asia and the Pacific is located at',
'[{"key":"A","text":"Singapore"},{"key":"B","text":"Manila"},{"key":"C","text":"Bangkok"},{"key":"D","text":"Hong Kong"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","International Organisations","General Knowledge"]'::jsonb),

('jkpsi-2017-q70','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','70',
'Which one of the following writs is issued by the Supreme Court to secure the freedom of a person upon unlawful arrest?',
'[{"key":"A","text":"Habeas Corpus"},{"key":"B","text":"Mandamus"},{"key":"C","text":"Certiorari"},{"key":"D","text":"Quo Warranto"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Judiciary","Writs","Fundamental Rights"]'::jsonb),

('jkpsi-2017-q71','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','J&K General Knowledge','71',
'Jammu and Kashmir Rifles is',
'[{"key":"A","text":"An infantry regiment of the Indian Army"},{"key":"B","text":"A battalion of the Rashtriya Rifles"},{"key":"C","text":"The name of the Armed Police of the State of Jammu and Kashmir"},{"key":"D","text":"A paramilitary force under the Ministry of Home Affairs"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","J&K General Knowledge","Defence","Army"]'::jsonb),

('jkpsi-2017-q72','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Economy','72',
'Which sector currently contributes most to the Gross Domestic Product of India?',
'[{"key":"A","text":"Manufacturing"},{"key":"B","text":"Agriculture"},{"key":"C","text":"Services"},{"key":"D","text":"Marine"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Economy","GDP","Sectors"]'::jsonb),

('jkpsi-2017-q73','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','73',
'With reference to Simon Commission''s recommendations, which one of the following statements is correct?',
'[{"key":"A","text":"It recommended the replacement of diarchy with responsible government in the provinces"},{"key":"B","text":"It proposed the setting up of inter-provincial council under the Home Department"},{"key":"C","text":"It suggested the abolition of bicameral legislature at the Centre"},{"key":"D","text":"It recommended the creation of Indian Police Service with provision for increased pay for British recruits compared to Indian recruits"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Modern India","Constitutional History"]'::jsonb),

('jkpsi-2017-q74','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Economy','74',
'Consider the following actions by the Government: (i) Cutting the tax rates (ii) Increasing the government spending (iii) Abolishing the subsidies. In the context of economic recession, which of the above actions can be considered a part of the fiscal stimulus package?',
'[{"key":"A","text":"(i) and (ii) only"},{"key":"B","text":"(ii) only"},{"key":"C","text":"(i) and (iii) only"},{"key":"D","text":"(i), (ii) and (iii)"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Economy","Fiscal Policy","Recession"]'::jsonb),

('jkpsi-2017-q75','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','75',
'Circulatory system is made of',
'[{"key":"A","text":"Veins and arteries"},{"key":"B","text":"Lymph vessels and nodes"},{"key":"C","text":"Blood vessels, heart and blood"},{"key":"D","text":"Capillaries and veins"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Biology","Human Body"]'::jsonb),

('jkpsi-2017-q76','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Geography','76',
'Alps Mountains and Himalayas are classic examples of the process of',
'[{"key":"A","text":"Plate subduction"},{"key":"B","text":"Volcanic activity"},{"key":"C","text":"Plate convection"},{"key":"D","text":"Folding"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Geography","Geomorphology","Mountains"]'::jsonb),

('jkpsi-2017-q77','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','77',
'Ozone layer is part of the layer of',
'[{"key":"A","text":"Mesosphere"},{"key":"B","text":"Stratosphere"},{"key":"C","text":"Thermosphere"},{"key":"D","text":"Troposphere"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Atmosphere","Environment"]'::jsonb),

('jkpsi-2017-q78','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','78',
'Which one among the following rocks is not a sedimentary rock?',
'[{"key":"A","text":"Shale"},{"key":"B","text":"Limestone"},{"key":"C","text":"Slate"},{"key":"D","text":"Sandstone"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Geography","Rocks"]'::jsonb),

('jkpsi-2017-q79','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','79',
'Which one of the following is the largest source of electricity in India?',
'[{"key":"A","text":"Hydropower plants"},{"key":"B","text":"Thermal power plants"},{"key":"C","text":"Nuclear power plants"},{"key":"D","text":"Solar power plants"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Energy","Economy","General Knowledge"]'::jsonb),

('jkpsi-2017-q80','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','80',
'Who among the following was associated with the Hindustan Socialist Republican Association?',
'[{"key":"A","text":"Subhash Chandra Bose"},{"key":"B","text":"Mahatma Gandhi"},{"key":"C","text":"Laxmi Sehgal"},{"key":"D","text":"Chandrashekhar Azad"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Freedom Struggle","Revolutionary Movement"]'::jsonb),

('jkpsi-2017-q81','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','81',
'Which among the following is the hardest part of our body?',
'[{"key":"A","text":"Skull bones"},{"key":"B","text":"Thumb nails"},{"key":"C","text":"Rib bones"},{"key":"D","text":"Enamel of teeth"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Biology","Human Body"]'::jsonb),

('jkpsi-2017-q82','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Geography','82',
'The grassland region of North America is known as:',
'[{"key":"A","text":"Selvas"},{"key":"B","text":"Downs"},{"key":"C","text":"Veldt"},{"key":"D","text":"Prairies"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Geography","World Geography","Vegetation"]'::jsonb),

('jkpsi-2017-q83','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','83',
'The Simlipal Biosphere Reserve is located in:',
'[{"key":"A","text":"Meghalaya"},{"key":"B","text":"Manipur"},{"key":"C","text":"Assam"},{"key":"D","text":"Odisha"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Environment","Biosphere Reserves","Geography"]'::jsonb),

('jkpsi-2017-q84','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','84',
'Which one of the following does not have an allotrope?',
'[{"key":"A","text":"Oxygen"},{"key":"B","text":"Sulphur"},{"key":"C","text":"Nitrogen"},{"key":"D","text":"Carbon"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Chemistry","Allotropes"]'::jsonb),

('jkpsi-2017-q85','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','85',
'Consider the following statements: (i) Diamond is hard and graphite is soft. (ii) Diamond is soft and graphite is hard. (iii) Diamond is a bad conductor and graphite is a good conductor. (iv) Diamond is a good conductor and graphite is a bad conductor. Which of the statements given above is/are correct?',
'[{"key":"A","text":"(i) and (iii)"},{"key":"B","text":"(i) only"},{"key":"C","text":"(ii) and (iii)"},{"key":"D","text":"(i) and (iv)"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Chemistry","Carbon","Diamond"]'::jsonb),

('jkpsi-2017-q86','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','86',
'Which one among the following statements about thermal conductivity is correct?',
'[{"key":"A","text":"Steel > Wood > Water"},{"key":"B","text":"Steel > Water > Wood"},{"key":"C","text":"Water > Wood > Steel"},{"key":"D","text":"Water > Steel > Wood"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Physics","Heat"]'::jsonb),

('jkpsi-2017-q87','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Science','87',
'A body weighs 10 kgs on the equator. At the poles, it is likely to weigh',
'[{"key":"A","text":"10 kgs"},{"key":"B","text":"Less than 10 kgs"},{"key":"C","text":"More than 10 kgs"},{"key":"D","text":"0"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Science","Physics","Gravity"]'::jsonb),

('jkpsi-2017-q88','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','88',
'Which of the following monuments was formerly known as "All India War Memorial"?',
'[{"key":"A","text":"India Gate"},{"key":"B","text":"Gateway of India"},{"key":"C","text":"Charminar"},{"key":"D","text":"Red Fort"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Knowledge","Monuments","History"]'::jsonb),

('jkpsi-2017-q89','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','89',
'Which of the following statements regarding the Preamble of the Constitution of India is/are correct? (i) The Preamble is an integral part of the Constitution. (ii) The words "Secular" and "Socialist" have been a part of the Preamble since its inception.',
'[{"key":"A","text":"(i) only"},{"key":"B","text":"(ii) only"},{"key":"C","text":"Both (i) and (ii)"},{"key":"D","text":"Neither (i) nor (ii)"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Constitution","Preamble"]'::jsonb),

('jkpsi-2017-q90','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','90',
'The Vice President of India is elected by an electoral college consisting of',
'[{"key":"A","text":"Members of both the Houses of Parliament"},{"key":"B","text":"Members of the Rajya Sabha only"},{"key":"C","text":"Members of the Lok Sabha only"},{"key":"D","text":"Members of both Houses of Parliament and members of Legislative Assemblies of all States"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Constitution","Vice President"]'::jsonb),

('jkpsi-2017-q91','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','91',
'Navroz is a festival celebrated in India by the:',
'[{"key":"A","text":"Hindus"},{"key":"B","text":"Muslims"},{"key":"C","text":"Christians"},{"key":"D","text":"Parsis"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Art & Culture","Festivals","General Knowledge"]'::jsonb),

('jkpsi-2017-q92','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','History','92',
'Of which significant event of the freedom struggle was the 100th anniversary recently commemorated?',
'[{"key":"A","text":"Swadeshi Movement"},{"key":"B","text":"Champaran Satyagraha"},{"key":"C","text":"Non-Cooperation movement"},{"key":"D","text":"Civil Disobedience movement"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","History","Freedom Struggle","Current Affairs"]'::jsonb),

('jkpsi-2017-q93','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Polity & Constitution','93',
'Normally, the Parliament can legislate on subjects enumerated in the',
'[{"key":"A","text":"Union List"},{"key":"B","text":"State List"},{"key":"C","text":"Financial List"},{"key":"D","text":"Both Union and State List"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Polity","Parliament","Legislative Lists"]'::jsonb),

('jkpsi-2017-q94','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','94',
'What is the missing number of the series 7, X, 21, 31, 43?',
'[{"key":"A","text":"11"},{"key":"B","text":"12"},{"key":"C","text":"13"},{"key":"D","text":"14"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Number Series","Reasoning"]'::jsonb),

('jkpsi-2017-q95','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','95',
'An automobile owner reduced his monthly fuel consumption when the price went up. Price (Rs./Litre): 40, 50, 60, 75 — Monthly consumption (Litres): 60, 48, 40, 32. If the price goes up to Rs. 80 a litre, his expected consumption in litres is expected to be:',
'[{"key":"A","text":"30"},{"key":"B","text":"28"},{"key":"C","text":"26"},{"key":"D","text":"Cannot be determined"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Data Interpretation","Reasoning"]'::jsonb),

('jkpsi-2017-q96','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','96',
'In a test, a candidate attempted only 10 questions and secured 50% marks in each of the questions. If he obtained a total of 25% in the test and all the questions carried equal marks, how many questions were there in the test?',
'[{"key":"A","text":"8"},{"key":"B","text":"10"},{"key":"C","text":"15"},{"key":"D","text":"20"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Percentage","Arithmetic"]'::jsonb),

('jkpsi-2017-q97','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','97',
'A father is nine times as old as his son and the mother is eight times as old as the son. The sum of the father''s and the mother''s age is 68 years. What is the age of the son?',
'[{"key":"A","text":"10 years"},{"key":"B","text":"8 years"},{"key":"C","text":"6 years"},{"key":"D","text":"4 years"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Age Problems","Arithmetic"]'::jsonb),

('jkpsi-2017-q98','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','98',
'Each of A, B, C and D has Rs. 100. A pays Rs. 20 to B, who pays Rs. 10 to C, who gets Rs. 30 from D. In this context, which of the following statements are correct?',
'[{"key":"A","text":"C is the richest"},{"key":"B","text":"D is the richest"},{"key":"C","text":"C has more than what A and D have in aggregate"},{"key":"D","text":"D is richer than B"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Reasoning","Arithmetic"]'::jsonb),

('jkpsi-2017-q99','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','99',
'Ram and Afzal start from the same point in opposite directions. After each 1 km, Ram always turns left and Afzal always turns right. Which of the following statements is correct?',
'[{"key":"A","text":"After both have travelled 2 km, the distance between them is 4 km"},{"key":"B","text":"They meet after each has travelled 3 km"},{"key":"C","text":"They meet for the first time after each has travelled 4 km"},{"key":"D","text":"They never meet"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Reasoning","Direction Sense","Spatial"]'::jsonb),

('jkpsi-2017-q100','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','100',
'Two equal glasses of the same type are respectively 1/3 and 1/4 full of milk. The glasses are then filled to the brim by adding water and the contents are mixed in a pot. What is the ratio of water to milk in the pot?',
'[{"key":"A","text":"3 : 1"},{"key":"B","text":"7 : 3"},{"key":"C","text":"11 : 7"},{"key":"D","text":"17 : 7"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Ratio & Proportion","Mixtures"]'::jsonb),

('jkpsi-2017-q101','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','101',
'A rectangular field has to be fenced on three sides leaving one side of 20 feet uncovered. If the area of the field is 680 sq. feet, how many feet of fencing will be required?',
'[{"key":"A","text":"95"},{"key":"B","text":"92"},{"key":"C","text":"88"},{"key":"D","text":"82"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Mensuration","Arithmetic"]'::jsonb),

('jkpsi-2017-q102','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','102',
'A large field of 700 hectares is divided into two parts. The difference of the areas of the two parts is one-fifth of the average of the two areas. What is the area of the smaller part in hectares?',
'[{"key":"A","text":"385 hectares"},{"key":"B","text":"315 hectares"},{"key":"C","text":"225 hectares"},{"key":"D","text":"175 hectares"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Arithmetic","Area"]'::jsonb),

('jkpsi-2017-q103','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','103',
'Two stations P and Q are 110 km apart on a straight track. One train starts from P at 7 a.m. and travels towards Q at 20 kmph. Another train starts from Q at 8 a.m. and travels towards P at a speed of 25 kmph. At what time will they meet?',
'[{"key":"A","text":"10 a.m."},{"key":"B","text":"10:30 a.m."},{"key":"C","text":"11 a.m."},{"key":"D","text":"11:30 a.m."}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Time Speed Distance","Trains"]'::jsonb),

('jkpsi-2017-q104','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','104',
'Rahul went to a shop and bought things worth Rs. 25 out of which 30 paise went on sales tax on taxable purchases. If the tax rate was 6%, then what was the total amount that Rahul paid for the taxable items?',
'[{"key":"A","text":"Rs. 5"},{"key":"B","text":"Rs. 5.30"},{"key":"C","text":"Rs. 19.70"},{"key":"D","text":"Rs. 20"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Tax","Arithmetic"]'::jsonb),

('jkpsi-2017-q105','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','105',
'A fruit seller had some oranges. He sells 40% of oranges and still has 420 oranges. How many oranges did he have originally?',
'[{"key":"A","text":"550"},{"key":"B","text":"700"},{"key":"C","text":"1000"},{"key":"D","text":"1050"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Percentage","Arithmetic"]'::jsonb),

('jkpsi-2017-q106','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','106',
'An accurate clock shows 8 o''clock in the morning. Through how many degrees will the hour hand rotate when the clock shows 2 o''clock in the afternoon?',
'[{"key":"A","text":"60°"},{"key":"B","text":"90°"},{"key":"C","text":"180°"},{"key":"D","text":"360°"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Clock Problems","Reasoning"]'::jsonb),

('jkpsi-2017-q107','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','107',
'The average of 20 non-zero numbers is zero. Of them, how many may be greater than zero, at the most?',
'[{"key":"A","text":"0"},{"key":"B","text":"10"},{"key":"C","text":"18"},{"key":"D","text":"19"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Average","Arithmetic"]'::jsonb),

('jkpsi-2017-q108','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','108',
'The angle of elevation of a 5 m long ladder leaning against a wall is 45 degrees and the foot of the ladder is 3 m away from the wall. The height of the wall up to the point where the ladder is resting against it is:',
'[{"key":"A","text":"2 m"},{"key":"B","text":"3 m"},{"key":"C","text":"4 m"},{"key":"D","text":"Cannot be determined on the basis of the given information"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Geometry","Trigonometry"]'::jsonb),

('jkpsi-2017-q109','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','109',
'P is able to do a piece of work in 15 days and Q can do the same work in 20 days. If they can work together for 4 days, what is the fraction of work left?',
'[{"key":"A","text":"8/15"},{"key":"B","text":"7/15"},{"key":"C","text":"11/15"},{"key":"D","text":"2/11"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Work & Time","Arithmetic"]'::jsonb),

('jkpsi-2017-q110','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','Quantitative Aptitude & Reasoning','110',
'The sum of the present ages of a son and his father is 60 years. Six years ago, father''s age was five times the age of the son. After 6 years, what will be the son''s age?',
'[{"key":"A","text":"14 years"},{"key":"B","text":"20 years"},{"key":"C","text":"46 years"},{"key":"D","text":"52 years"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Quantitative Aptitude","Age Problems","Arithmetic"]'::jsonb),

('jkpsi-2017-q111','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','111',
'The 2020 Summer Olympics will be held at:',
'[{"key":"A","text":"Doha"},{"key":"B","text":"Tokyo"},{"key":"C","text":"London"},{"key":"D","text":"Barcelona"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Sports","Olympics","Current Affairs"]'::jsonb),

('jkpsi-2017-q112','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','J&K General Knowledge','112',
'The Zoji-la tunnel planned to be constructed under the Zoji-la pass will be:',
'[{"key":"A","text":"The world''s longest bidirectional tunnel"},{"key":"B","text":"Asia''s longest bi-directional tunnel"},{"key":"C","text":"India''s longest bi-directional tunnel"},{"key":"D","text":"The world''s highest tunnel"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","J&K General Knowledge","Infrastructure","Current Affairs"]'::jsonb),

('jkpsi-2017-q113','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','113',
'With which sport is Saikhom Mirabai Chanu associated?',
'[{"key":"A","text":"Archery"},{"key":"B","text":"Athletics"},{"key":"C","text":"Weight lifting"},{"key":"D","text":"Wrestling"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Sports","Current Affairs","General Knowledge"]'::jsonb),

('jkpsi-2017-q114','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','114',
'Who captained the Indian team during the Women''s Cricket World Cup, 2017?',
'[{"key":"A","text":"Mithali Dorai Raj"},{"key":"B","text":"Harmanpreet Kaur"},{"key":"C","text":"Thirush Kamini"},{"key":"D","text":"Poonam Raut"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Sports","Cricket","Current Affairs"]'::jsonb),

('jkpsi-2017-q115','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','115',
'Kailash Satyarthi, who was awarded the Nobel Peace Prize in 2014, works in the field of:',
'[{"key":"A","text":"Women''s rights"},{"key":"B","text":"Nuclear disarmament"},{"key":"C","text":"Water rights"},{"key":"D","text":"Child rights"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Current Affairs","Nobel Prize","General Knowledge"]'::jsonb),

('jkpsi-2017-q116','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','116',
'The National Health Protection Scheme announced by the Finance Minister during the presentation of the budget for the fiscal year 2018-19 will',
'[{"key":"A","text":"Provide a 100-bedded hospital in each district of India"},{"key":"B","text":"Provide a Rs. 5 lakh insurance cover to 10 crore economically vulnerable families"},{"key":"C","text":"Provide life-saving drugs to all persons below the poverty line"},{"key":"D","text":"Provide artificial limbs to physically disabled persons"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Government Schemes","Health","Current Affairs"]'::jsonb),

('jkpsi-2017-q117','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','117',
'The National Institute of Mental Health and Neuro Science is located in:',
'[{"key":"A","text":"Kolkata"},{"key":"B","text":"Bengaluru"},{"key":"C","text":"Gurugram"},{"key":"D","text":"Chennai"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","General Knowledge","Research Institutes","Health"]'::jsonb),

('jkpsi-2017-q118','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','J&K General Knowledge','118',
'Which of the following is not correct with respect to Kalhana''s Rajtarangini?',
'[{"key":"A","text":"The subject of the book deals with various dynasties that ruled Kashmir"},{"key":"B","text":"The book was written in the 15th century"},{"key":"C","text":"It was written in Sanskrit"},{"key":"D","text":"It is an invaluable source of information about early Kashmir"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","J&K History","Literature","History"]'::jsonb),

('jkpsi-2017-q119','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','General Knowledge & Current Affairs','119',
'Consider the following statements about Bitcoin: (i) Bitcoin is a cryptocurrency. (ii) It is the first decentralized digital currency. (iii) The system works as a peer-to-peer network called the blockchain. Which of the above statements are correct?',
'[{"key":"A","text":"(i) only"},{"key":"B","text":"(i) and (ii) only"},{"key":"C","text":"(i) and (iii) only"},{"key":"D","text":"(i), (ii) and (iii)"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","Technology","Current Affairs","Cryptocurrency"]'::jsonb),

('jkpsi-2017-q120','jkssb','jkpsi-2017','JKSSB','2017','JKSSB Sub Inspector of Police (PSI) 2017','J&K General Knowledge','120',
'Sultan Zain-ul-Abedin, who ruled Kashmir during the 15th century, was also known as:',
'[{"key":"A","text":"Bud-shah"},{"key":"B","text":"Alamgeer"},{"key":"C","text":"Jahanpanah"},{"key":"D","text":"Jehangir"}]'::jsonb,
'','','','["JKPSI","JKSSB","2017","J&K History","Medieval Kashmir","Rulers"]'::jsonb)

ON CONFLICT (slug) DO UPDATE SET
  exam_slug      = EXCLUDED.exam_slug,
  paper_slug     = EXCLUDED.paper_slug,
  exam_name      = EXCLUDED.exam_name,
  year           = EXCLUDED.year,
  paper          = EXCLUDED.paper,
  subject        = EXCLUDED.subject,
  question_no    = EXCLUDED.question_no,
  question       = EXCLUDED.question,
  options        = EXCLUDED.options,
  answer_key     = EXCLUDED.answer_key,
  answer         = EXCLUDED.answer,
  explanation    = EXCLUDED.explanation,
  tags           = EXCLUDED.tags,
  updated_at     = CURRENT_TIMESTAMP;

-- Update exam paper count
UPDATE vaultcore.exams SET papers = (SELECT COUNT(*) FROM vaultcore.papers WHERE exam_slug = 'jkssb') WHERE slug = 'jkssb';
