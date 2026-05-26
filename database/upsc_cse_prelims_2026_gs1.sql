-- UPSC Civil Services (Preliminary) Examination 2026
-- General Studies Paper I
-- 100 questions · 200 marks · 120 minutes · 0.67 negative marking per wrong answer
-- Held: 24 May 2026
-- Questions added without answer key

BEGIN;

INSERT INTO vaultcore.exams (slug, name, short_name, category, icon, total_questions, papers, mocks, description, popular_years, subjects)
VALUES (
  'upsc-cse',
  'Union Public Service Commission Civil Services Examination',
  'UPSC CSE',
  'Central',
  '🏛️',
  0, 1, 0,
  'Union Public Service Commission Civil Services Examination (UPSC CSE) is conducted in three stages (Prelims, Mains, and Interview) to select candidates for IAS, IPS, IFS, and other Group A central services.',
  '["2026","2025","2024","2023","2022"]'::jsonb,
  '["History","Art & Culture","Geography","Environment & Ecology","Economy","Indian Polity","Science & Technology","International Relations","Ethics","Defense & Security"]'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  popular_years = EXCLUDED.popular_years,
  updated_at    = CURRENT_TIMESTAMP;

INSERT INTO vaultcore.papers (slug, exam_slug, exam_name, title, year, shift, description, questions, subjects, negative_marking, duration_minutes, max_marks)
VALUES (
  'upsc-cse-prelims-2026-gs1',
  'upsc-cse',
  'Union Public Service Commission Civil Services Examination',
  'Civil Services (Preliminary) Examination 2026 — General Studies Paper I',
  '2026',
  'Set A',
  'UPSC Civil Services Preliminary Examination 2026, General Studies Paper I. 100 questions, 200 marks, 120 minutes. Negative marking 0.67 per wrong answer. Held on 24 May 2026.',
  100,
  '["History","Art & Culture","Geography","Environment & Ecology","Economy","Indian Polity","Science & Technology","International Relations","Ethics","Defense & Security"]'::jsonb,
  0.67,
  120,
  200
)
ON CONFLICT (slug) DO UPDATE SET
  title       = EXCLUDED.title,
  description = EXCLUDED.description,
  questions   = EXCLUDED.questions,
  updated_at  = CURRENT_TIMESTAMP;

UPDATE vaultcore.papers SET held_on = '2026-05-24' WHERE slug = 'upsc-cse-prelims-2026-gs1';

DELETE FROM vaultcore.questions WHERE paper_slug = 'upsc-cse-prelims-2026-gs1';

INSERT INTO vaultcore.questions
  (slug, exam_slug, paper_slug, exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags)
VALUES

('upsc-cse-pre-2026-gs1-q1','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','History','1',
'Consider the following assertion: In the Pleistocene period either the Yamuna once flowed into the Indus, or the Sutlej flowed into the Yamuna and one major tributary of either had shifted from the Ganga to the Indus or vice versa. Which of the following is/are the basis of the above assertion?
1. The Nadi-Sukta of the Rigveda
2. The explorations of the Sutlej and the Yamuna by Robert Bruce Foote
3. The presence of the same species of dolphins in both the Indus and the Ganga river systems',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 only"},{"key":"C","text":"1 and 2"},{"key":"D","text":"3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q2','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Art & Culture','2',
'What does an empty seat represent in early Buddhist iconography?',
'[{"key":"A","text":"The meditation of the Buddha"},{"key":"B","text":"The Buddha''s First Sermon"},{"key":"C","text":"The Buddha''s Mahaparinibbana"},{"key":"D","text":"The Buddha''s Mahabhinishkramana"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q3','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','History','3',
'Which of the following pairs of ancient and modern names of rivers is/are correctly matched?
1. Vitasta : Chenab
2. Asikni : Jhelum
3. Parushni : Ravi
4. Yavyavati : Beas',
'[{"key":"A","text":"1 and 2"},{"key":"B","text":"3 and 4"},{"key":"C","text":"3 only"},{"key":"D","text":"4 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q4','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Art & Culture','4',
'Which of the following statements on the Amaravati Stupa and its relief sculpture is/are correct?
1. It was located in the lower Krishna valley.
2. In India, it was next only to the Sanchi Stupa in size.
3. The Amaravati school of sculpture made a lasting impact on the later South Indian sculpture, and its products were carried to Sri Lanka and South-east Asia.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 3 only"},{"key":"C","text":"2 and 3 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q5','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','History','5',
'Which of the following pairs of the king and his dynasty in early historical Tamilakam is/are not correctly matched?
1. Senguttuvan : Chera
2. Udiyanjeral : Chola
3. Nedunjeliyan : Pandya',
'[{"key":"A","text":"1 and 2"},{"key":"B","text":"2 only"},{"key":"C","text":"1 and 3"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q6','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','History','6',
'Which of the following factors contributed to the formation of the Forward Bloc by Subhas Chandra Bose in 1939?
1. Bose failed to win the confidence of Mahatma Gandhi.
2. The Congress Left was disunited and failed to support Bose.
3. The Communists did not support Bose in his endeavours.
4. The supporters of M. N. Roy and socialist leaders like Jayaprakash Narayan preferred Congress unity to supporting Bose.',
'[{"key":"A","text":"1, 2 and 3"},{"key":"B","text":"1, 2 and 4"},{"key":"C","text":"1, 3 and 4"},{"key":"D","text":"2 and 4 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q7','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','History','7',
'Consider the following statements regarding the British policy in Awadh immediately after its annexation in 1856:
1. The taluqdars were dispossessed of their estates but allowed to retain their arms and forts.
2. A Summary Revenue Settlement was made in 1856 assuming that the taluqdars were outsiders.
3. The British believed in taking revenue directly from the peasants by removing the taluqdars.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"2 and 3 only"},{"key":"B","text":"1 and 3 only"},{"key":"C","text":"1, 2 and 3"},{"key":"D","text":"2 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q8','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','History','8',
'Consider the following assertion: The genesis of political alliances based on community lay in the very nature of the Montague-Chelmsford Reforms, 1919. Which of the following statements support/supports the above assertion?
1. Reforms retained and extended the principle of separate electorates.
2. Separate electorates were supposed to counter Indian nationalism, which was growing stronger.
3. Deprived classes rallied around the favours inherent in separate electorates.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 and 2 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q9','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Art & Culture','9',
'Pandit Mallikarjun Mansur, the famous classical singer from Karnataka, represented the:',
'[{"key":"A","text":"Agra Gharana"},{"key":"B","text":"Gwalior Gharana"},{"key":"C","text":"Patiala Gharana"},{"key":"D","text":"Jaipur-Atrauli Gharana"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q10','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','History','10',
'In which one among the following texts does the term kshetra-patni (''mistress of the field'') originate?',
'[{"key":"A","text":"Rigveda"},{"key":"B","text":"Atharvaveda"},{"key":"C","text":"Ashtadhyayi"},{"key":"D","text":"Arthashastra"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q11','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Art & Culture','11',
'Which one of the following Carnatic music ragas is similar to Raga Bilawal in Hindustani music?',
'[{"key":"A","text":"Nat Bhairavi"},{"key":"B","text":"Kamavardhini"},{"key":"C","text":"Hanumatodi"},{"key":"D","text":"Dheera Shankarabharanam"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q12','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','History','12',
'The artificially fixed rupee-sterling exchange rate prescribed by the Hilton-Young Commission (1926) was adopted by the British Government for which one of the following reasons?',
'[{"key":"A","text":"Aiding the flow of remittances from India and maintaining India''s creditworthiness"},{"key":"B","text":"Providing support to Indian importers"},{"key":"C","text":"Encouraging export of cotton produce from India"},{"key":"D","text":"Preventing depreciation of the Rupee in terms of gold"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q13','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','History','13',
'Consider the following statements:
I. Pali texts contain the first definite references to coins, e.g., kahapana, nikkha, kamsa, and kakanika.
II. The literary evidence from Pali texts is corroborated by archaeological evidence of punch-marked coins from many sites, most of them made of silver.
The above statements have been associated with which of the following?
1. Emergence of urban life
2. Transition to money economy',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 only"},{"key":"C","text":"Both 1 and 2"},{"key":"D","text":"Neither 1 nor 2"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q14','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Art & Culture','14',
'Which of the following temples has/have a Nagara-style shikhara?
1. Malegitti Shivalaya, Badami
2. Huchimalligudi Temple, Aihole
3. Dashavatara Temple, Deogarh
4. Virupaksha Temple, Pattadakal',
'[{"key":"A","text":"1 and 2"},{"key":"B","text":"2 and 3"},{"key":"C","text":"3 only"},{"key":"D","text":"3 and 4"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q15','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Art & Culture','15',
'Among the four main forms of existence of life recognized in Jainism, which one of the following is not included?',
'[{"key":"A","text":"Deva (gods)"},{"key":"B","text":"Yaksha (demi-gods)"},{"key":"C","text":"Manushya (humans)"},{"key":"D","text":"Tiryancha (animals and plants)"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q16','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Art & Culture','16',
'The Hallisalasya painting in the Bagh Caves represents:',
'[{"key":"A","text":"A joyous folk dance"},{"key":"B","text":"Buddha in a meditative pose"},{"key":"C","text":"The depiction of Shiva and Parvati on Kailasha"},{"key":"D","text":"Samudramanthan (Churning of the Ocean)"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q17','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','History','17',
'Consider the following statements relating to the use of the place-value system in India:
1. The earliest epigraphic use of the place-value system in India is found in the Mankani plates from Gujarat (AD 595 – 596).
2. In the ninth century, place-values become general in inscriptions all over India.
3. The place-values have been found in Sanskrit inscriptions in South-east Asia as early as the seventh century.
Which of the statements given above are correct?',
'[{"key":"A","text":"1 and 2 only"},{"key":"B","text":"1 and 3 only"},{"key":"C","text":"2 and 3 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q18','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','History','18',
'Consider the following statements about the archaeological findings in Harappan towns:
I. There is wide occurrence of spindle-whorls in the houses but absence of spinning wheels.
II. Weights and measurement scales, complete with graduations, have been discovered.
III. There are houses built in large part with baked bricks, around relatively spacious courtyards, with their own wells, bathing platforms, and large rooms.
Which of the following inferences can be drawn from the above statements?
1. Statement I suggests that spinning was a laborious activity done at home.
2. Statement II suggests the extent of the scientific knowledge that the Harappans possessed.
3. Statement III suggests the emergence of a common property system.',
'[{"key":"A","text":"1 and 2 only"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 and 3 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q19','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','History','19',
'Which one of the following statements about the Eka Movement and Bardoli Satyagraha is correct?',
'[{"key":"A","text":"The Eka Movement was throughout supported and organized by the Congress while Bardoli Satyagraha was initially independent of Congress influence and was only in the last stages supported by the Congress."},{"key":"B","text":"The Eka Movement was provided leadership by the taluqdars of Awadh, whereas the Bardoli Satyagraha was a movement of the landless labourers."},{"key":"C","text":"The Bardoli Satyagraha was a campaign against the enhancement of land revenue, while the Eka Movement was a protest against excessive extraction of rents."},{"key":"D","text":"The Eka Movement was located in the Varanasi and Mirzapur districts of the present-day U.P., while the Bardoli Satyagraha took place in Saurashtra."}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q20','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','History','20',
'Consider the following statements about the Rigvedic period:
I. Irrigation from wells allowed agriculture to expand away from flood plains and strips on river margins into the present Punjab and Haryana plains having underground water levels reasonably close to the surface.
II. Draught-animal power was employed to draw up water out of the wells.
Which of the following information support/supports the above statements?
1. There is evidence in the Rigveda of the use of ashma chakra (stone pulley wheel) and ahava (strapped wooden pails) to draw up water.
2. Mention has been made in the Rigveda of the use of implements like parashu/kulisha (axe) and datra/sreni (sickle).
3. There is a history of the use of ox, even before the Rigveda, for ploughing the land and pulling the carts.',
'[{"key":"A","text":"1 and 2 only"},{"key":"B","text":"1, 2 and 3"},{"key":"C","text":"1 and 3 only"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q21','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Geography','21',
'Tungurahua Volcano, which was declared a Global Geopark by UNESCO in 2025, is situated in which one among the following countries?',
'[{"key":"A","text":"Ecuador"},{"key":"B","text":"Peru"},{"key":"C","text":"Bolivia"},{"key":"D","text":"Colombia"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q22','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Environment & Ecology','22',
'With reference to Madhav National Park, which of the following statements is/are correct?
1. It was declared a Tiger Reserve in India in 2025.
2. Sakhya Sagar, which is designated as a Ramsar Site, is situated within this National Park.
3. Its area is shared between Madhya Pradesh and Rajasthan.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 2"},{"key":"C","text":"2 and 3"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q23','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Geography','23',
'With reference to the climate of Andaman and Nicobar Islands, which of the following statements is/are correct?
1. The climate can be defined as a humid, tropical coastal climate.
2. It receives rainfall from both South-west monsoon and North-east monsoon.
3. Maximum precipitation is between December and May.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 2"},{"key":"C","text":"2 and 3"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q24','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Geography','24',
'Which of the following geographical features or phenomena is/are associated with the Peninsular Block of India?
1. Submergence of parts of the western coast due to tectonic activity
2. Presence of residual mountain ranges such as the Veliconda hills and Mahendragiri hills
3. Deep, V-shaped river valleys formed by fast-flowing rivers',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 2"},{"key":"C","text":"2 and 3"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q25','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','25',
'Consider the following statements with reference to the Sagarmala Programme of the Government of India:
I. The Sagarmala Programme seeks to achieve port-led economic growth through cost-effective and sustainable coastal infrastructure.
II. The success of the Sagarmala Programme is reflected in significant growth in coastal and inland waterway shipping, along with improved global port rankings.
III. Sagarmala 2.0 aims to position India as a global maritime innovation hub aligned with Atmanirbhar Bharat and Viksit Bharat 2047 visions.
Which of the following relationships among the above statements is/are correct?
1. Statement II validates the effectiveness of the strategies envisioned in statement I.
2. Statement III extends the objectives of statement I by embedding them into a future-oriented innovation framework.
3. Statement I contradicts statement III by focusing only on traditional infrastructure instead of modern innovation.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 2"},{"key":"C","text":"2 and 3"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q26','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Environment & Ecology','26',
'Consider the following statements about Rhynchostylis retusa (Foxtail orchid):
1. It is an epiphytic orchid.
2. The species is endemic to North-east India.
3. It is the State flower of Arunachal Pradesh and Assam.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 3"},{"key":"C","text":"2 and 3"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q27','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Art & Culture','27',
'Which one of the following statements with regard to the Moidams, built by the Tai-Ahom kingdom and inscribed as a World Heritage Site by UNESCO, is/are correct?
1. They acted as army fortresses.
2. They were recreation centres of the Royals and Nobles.
3. They were burial grounds of the Royals and Nobles.
4. They were battle drill centres of the Royals and Nobles.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 3"},{"key":"C","text":"3 only"},{"key":"D","text":"2 and 4"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q28','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Environment & Ecology','28',
'At the United Nations Ocean Conference (UNOC) held in June, 2025 in France, the Food and Agricultural Organization (FAO) of the United Nations demonstrated its leading voice on marine and ocean issues, especially on sustainable fisheries and aquaculture for resilient livelihood and "Blue Transformation". Which of the following combinations about the "Four Betters" proposed by FAO for "Blue Transformation" is correct?',
'[{"key":"A","text":"Better production, better nutrition, better environment and better ocean"},{"key":"B","text":"Better production, better nutrition, better environment and better life"},{"key":"C","text":"Better coral reefs, better nutrition, better environment and better life"},{"key":"D","text":"Better estuaries, better nutrition, better environment and better mangrove vegetation"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q29','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Geography','29',
'Which of the following statements with reference to Lake Turkana is/are correct?
1. It is the largest desert lake in the world.
2. The lake is situated in South Sudan along the eastern fringe of the Sahara desert.
3. The lake is listed as a UNESCO World Heritage Site and is also referred to as the ''Jade Sea''.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 3 only"},{"key":"C","text":"2 and 3 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q30','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Environment & Ecology','30',
'Which one of the following is the first Plan Vivo certified Reducing Emissions from Deforestation and Forest Degradation (REDD+) project in India?',
'[{"key":"A","text":"Uttarakhand REDD+ project"},{"key":"B","text":"ICFRE-ICIMOD Transboundary REDD+ project in North-Eastern Himalayas"},{"key":"C","text":"Khasi Hills Community REDD+ project"},{"key":"D","text":"Sikkim Mamley Kamrang Community REDD+ project"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q31','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Environment & Ecology','31',
'Consider the following statements with reference to India''s response to climate change:
I. India''s Long-Term Low Emission Development Strategy (LT-LEDS) is a crucial tool for achieving net-zero emissions by 2070.
II. India''s 4th Biennial Update Report (BUR-4) submitted in December, 2024 recorded around 8% decrease in Greenhouse gas emissions in 2020 over 2019.
III. Climate-resilient development necessarily depends on quick and short-term achievement of emission reduction targets.
Which of the following relationships among the above statements is/are correct?
1. Statement I is empirically supported by statement II.
2. Statement III contradicts the approach implicit in statement I.
3. Statement I and statement III together establish the premise of long-term sustainability.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 2"},{"key":"C","text":"2 and 3"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q32','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Environment & Ecology','32',
'With respect to the Western Hoolock Gibbons, which of the following statements is/are correct?
1. A Sanctuary in North-east India is home to this ape species listed as Endangered in the International Union for Conservation of Nature (IUCN) Red List.
2. They have specialized brachiation and can easily swing between trees.
3. They possess a strong and heavy build like gorillas, yet are remarkably agile tree climbers.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 2"},{"key":"C","text":"2 and 3"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q33','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Environment & Ecology','33',
'Which of the following best explain(s) the rationale for protecting mangrove ecosystems in the context of climate resilience?
1. Mangroves reduce tidal energy and store freshwater, making them ideal sites for paddy cultivation in saline estuarine belts.
2. Their salt-sensitive roots filter seawater, making mangroves key to converting coastal land into freshwater aquaculture zones.
3. By withstanding tidal surges and offering biomass resources, mangroves function both as natural bio-shields and livelihood bases for rural communities.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 2"},{"key":"C","text":"2 and 3"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q34','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','34',
'In what way(s) does the Vizhinjam International Seaport represent a structural shift in India''s maritime trade and logistics policy?
1. By functioning exclusively as a domestic cargo hub to reduce reliance on coastal shipping and eliminate the need for foreign collaborations.
2. By focusing primarily on passenger cruise tourism and heritage shipping to increase Kerala''s profile as a maritime heritage destination.
3. By leveraging its natural deep draft and strategic location to reduce dependence on foreign trans-shipment ports, enhance revenue retention, and reposition India in regional maritime trade.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 2"},{"key":"C","text":"2 and 3"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q35','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Geography','35',
'Identify the river of the Indian sub-continent on the basis of the following information:
1. It has an antecedent drainage system.
2. It flows through three countries.
3. It originates in the Tibetan Plateau and is an important river for irrigation.
4. It does not form distributaries.',
'[{"key":"A","text":"Brahmaputra"},{"key":"B","text":"Indus"},{"key":"C","text":"Sutlej"},{"key":"D","text":"Teesta"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q36','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Geography','36',
'Which of the following with reference to Indian States is/are not correct?
1. Uttar Pradesh shares its boundary with the highest number of other Indian States.
2. Rajasthan shares the longest international border among all Indian States.
3. Sikkim is the only State that shares its boundary with just one other Indian State.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 2"},{"key":"C","text":"2 and 3"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q37','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Environment & Ecology','37',
'Which of the following statements with regard to the arrival of Amur Falcons at Doyang Lake in Nagaland each year from Mongolia is/are correct?
1. It showcases how sustained local conservation efforts can contribute to the arrival and protection of international migratory birds.
2. It reflects the global success of advanced tracking technologies that guide migratory birds back to their stopover sites.
3. It confirms that Amur Falcons have adapted to permanent residency in India due to favourable habitat changes.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 2"},{"key":"C","text":"2 and 3"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q38','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Agriculture','38',
'Which among the following is/are the objective(s) of the Rainfed Area Development (RAD) initiative under the National Mission for Sustainable Agriculture (NMSA)?
1. Encouraging monoculture in rainfed areas
2. Increasing rice cultivation in irrigated regions
3. Enhancing productivity and minimising climatic risks through Integrated Farming Systems (IFS)',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 2"},{"key":"C","text":"2 and 3"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q39','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','39',
'Which of the following is/are the most significant implication(s) of obtaining Oeko-Tex certification for Eri Silk in the global textile industry?
1. It allows Indian exporters to compete in high-end markets that prioritise chemical-free products.
2. It confirms that Eri Silk meets international safety, environmental, and quality standards, enabling its entry into premium eco-conscious markets.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 only"},{"key":"C","text":"Both 1 and 2"},{"key":"D","text":"Neither 1 nor 2"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q40','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Geography','40',
'Ships from which of the following countries have to cross the Strait of Hormuz to reach out to the Indian Ocean?
1. Bahrain
2. Syria
3. Qatar
4. Egypt',
'[{"key":"A","text":"1 and 2"},{"key":"B","text":"1 and 3"},{"key":"C","text":"2 and 3"},{"key":"D","text":"3 and 4"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q41','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','International Relations','41',
'Match List I (INTERPOL Notice) with List II (Description):
List I                  List II
A. Silver Notice   — 1. To seek information on unidentified bodies
B. Blue Notice     — 2. To collect additional information about a person''s identity, location, or activities in relation to a criminal investigation
C. Black Notice    — 3. To provide warning about a person''s criminal activities, where the person is considered to be a possible threat to public safety
D. Green Notice    — 4. To identify and trace criminal assets',
'[{"key":"A","text":"A-3, B-1, C-2, D-4"},{"key":"B","text":"A-3, B-2, C-1, D-4"},{"key":"C","text":"A-4, B-2, C-1, D-3"},{"key":"D","text":"A-4, B-1, C-2, D-3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q42','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Environment & Ecology','42',
'Which of the following statements in relation to NIRANTAR (National Institute for Research and Application of Natural Resources to Transform, Adapt and Build Resilience), a platform of institutions under the Ministry of Environment, Forest and Climate Change, is/are correct?
1. Ecosystem Survey and Analysis is a vertical under this platform, the lead institute of which is Botanical Survey of India, Kolkata.
2. Research and Management of Ecosystem Service is a vertical under this platform, the lead institute of which is Central Zoo Authority, New Delhi.
3. Capacity Development Support is a vertical under this platform, the lead institute of which is Indian Institute of Forest Management, Bhopal.',
'[{"key":"A","text":"1, 2 and 3"},{"key":"B","text":"1 and 3 only"},{"key":"C","text":"2 only"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q43','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','International Relations','43',
'The Chancellor of the Federal Republic of Germany visited India in January, 2026. Which of the following is/are not correct in terms of outcomes of this visit?
1. Signing of a Memorandum of Understanding between the All India Institute of Ayurveda and the University of Hamburg
2. Signing of a Memorandum of Understanding on Youth Hockey Development between Hockey India and the German Hockey Federation
3. Establishment of a bilateral dialogue mechanism on the Indo-Pacific
4. Opening of an Honorary Consul of Germany in Lucknow',
'[{"key":"A","text":"2 and 3"},{"key":"B","text":"1 and 4"},{"key":"C","text":"3 and 4"},{"key":"D","text":"1 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q44','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','44',
'Which of the following statements about DHRUV64 is/are correct?
1. It is the third chip fabricated under the DIR-V Programme with an overall aim to enable the creation of microprocessors for India.
2. It is India''s first homegrown 1.0 GHz, 64-bit dual-core microprocessor.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 only"},{"key":"C","text":"Both 1 and 2"},{"key":"D","text":"Neither 1 nor 2"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q45','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','45',
'The Bureau of Indian Standard (BIS) recently introduced a national standard to test and assess bomb disposal system. Which of the following statements with regard to this system is/are correct?
1. The new standard is known as IS 19445 : 2025.
2. It will improve interoperability of equipment across agencies.
3. It was developed by TBRL, DRDO in collaboration with the 30th Central Scientific Research Institute, Russia.',
'[{"key":"A","text":"1, 2 and 3"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 and 2 only"},{"key":"D","text":"1 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q46','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','46',
'X, born in the UK, was conferred the Nobel Prize in 2025. He was a professor in an American university when this prize was announced. Identify X:',
'[{"key":"A","text":"Michel H. Devoret"},{"key":"B","text":"Richard Robson"},{"key":"C","text":"John Clarke"},{"key":"D","text":"Joel Mokyr"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q47','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Sports','47',
'Which of the following statements with regard to the Grand Slam Tennis Tournaments is/are correct?
1. The tournaments have a shared governance structure establishing the partnership among the four Grand Slam tournaments.
2. They are open for entry to all internationally ranked tennis players above the age of 14.
3. There is a limitation on the number of ''Wild Cards'' a player may receive to compete in a Grand Slam Tournament.',
'[{"key":"A","text":"1 and 2 only"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q48','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','48',
'Which one of the following pairs of semiconductor plants in India and their locations is not correctly matched?',
'[{"key":"A","text":"CG Power and Industrial Solutions Pvt. Ltd. in partnership with Renesas Electronics and STARS Microelectronics : Gujarat"},{"key":"B","text":"Tata Semiconductor Assembly and Test Pvt. Ltd. : Assam"},{"key":"C","text":"HCL-Foxconn Joint Venture India Chip Ltd. : Madhya Pradesh"},{"key":"D","text":"SicSem Pvt. Ltd. : Odisha"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q49','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','49',
'Which of the following statements with regard to India''s indigenous new high resolution weather model, the ''Bharat Forecast System,'' is/are correct?
1. Its objective is to generate forecasts at the Panchayats cluster level.
2. It was developed by IIT Delhi.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 only"},{"key":"C","text":"Both 1 and 2"},{"key":"D","text":"Neither 1 nor 2"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q50','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Art & Culture','50',
'Consider the following statements with regard to the film ''Boong'':
1. The film has recently won the British Academy of Film and Television Arts (BAFTA) Award in the Children''s and Family Film category.
2. The film is directed by Lakshmipriya Devi.
3. This is the first Indian film to win a BAFTA award in the Children''s and Family Film category.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"1, 2 and 3"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 and 2 only"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q51','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','51',
'Which of the following statements regarding the features of blockchain technology are correct?
1. Records stored in the database may be made visible to relevant stakeholders without risk of alteration.
2. Copies of the entire database are stored on multiple computers on a network, syncing within seconds.
3. Consortium blockchain is a blend of public and private blockchains allowing selective data access.
4. Mathematical algorithms make it impossible to change or delete any data once recorded and accepted.',
'[{"key":"A","text":"1 and 3"},{"key":"B","text":"2 and 4 only"},{"key":"C","text":"1, 2 and 4"},{"key":"D","text":"1 and 4 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q52','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','52',
'An e-commerce revenue model where the seller has control over pricing but doesn''t keep products in stock and instead transfers customer orders and shipment details to a third-party supplier, who then ships the goods directly to the customer, is called:',
'[{"key":"A","text":"Dropshipping Model"},{"key":"B","text":"Affiliate Revenue Model"},{"key":"C","text":"Transaction Fee Revenue Model"},{"key":"D","text":"Agency Revenue Model"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q53','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','53',
'Which one of the following correctly represents the three key sub-indices of the Financial Inclusion Index (FI-Index) of the Reserve Bank of India (RBI)?',
'[{"key":"A","text":"Credit access, Insurance depth, and Pension coverage"},{"key":"B","text":"Banking access, GDP contribution, and Financial literacy"},{"key":"C","text":"Access, Usage, and Quality"},{"key":"D","text":"Access, Affordability, and Transparency"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q54','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','54',
'Which one of the following best describes the key objective of India''s ''Open Network for Digital Commerce'' (ONDC) initiative?',
'[{"key":"A","text":"To allow government control over all digital commerce transactions"},{"key":"B","text":"To replace private e-commerce players"},{"key":"C","text":"To break the dominance of large e-commerce platforms by enabling interoperability across networks"},{"key":"D","text":"To mandate UPI-based payments for all online transactions"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q55','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','55',
'Which one of the following statements about Unified Payments Interface (UPI) and Central Bank Digital Currency (Digital Rupee) is not correct?',
'[{"key":"A","text":"UPI is a real-time payment system but Digital Rupee is akin to sovereign paper currency."},{"key":"B","text":"In case of UPI, settlement for end users happens instantly as the money gets immediately debited or credited but in case of Digital Rupee, there is no settlement as the wallet balance gets transferred to another wallet."},{"key":"C","text":"UPI transactions are recorded by banks and reflected in bank statements but in case of Digital Rupee, no data is captured in bank statements as transactions are from one wallet to another."},{"key":"D","text":"In both the cases (UPI and Digital Rupee), the liability lies with the users and their respective banks."}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q56','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','56',
'Which of the following statements about Real-World Assets (RWA) Tokenization are correct?
1. Tokenization is the process of turning real world assets into digital tokens using blockchain technology.
2. Tokenization of real world assets offers 24×7 access, promoting financial inclusion.
3. Tokenization of real world assets will allow the access to high growth investment opportunities for individuals in India.',
'[{"key":"A","text":"1, 2 and 3"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 and 2 only"},{"key":"D","text":"1 and 3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q57','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','57',
'A bond whose proceeds are used only to finance or refinance a combination of both environmental and social projects is called:',
'[{"key":"A","text":"Green Bond"},{"key":"B","text":"Social Bond"},{"key":"C","text":"Sustainability Bond"},{"key":"D","text":"Sovereign Bond"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q58','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','58',
'Which of the following statements about M1xchange''s role in Micro, Small & Medium Enterprises (MSMEs) financing is/are correct?
1. M1xchange provides collateral based loans to MSMEs.
2. M1xchange facilitates discounting of invoices and Bills of Exchange for MSMEs.
3. M1xchange functions as a credit rating agency for MSMEs.',
'[{"key":"A","text":"1, 2 and 3"},{"key":"B","text":"2 only"},{"key":"C","text":"2 and 3 only"},{"key":"D","text":"1 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q59','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','59',
'Which one of the following best describes the ''Crowding Out Effect'' in the context of fiscal policy?',
'[{"key":"A","text":"A situation where private investment increases due to increased Government spending"},{"key":"B","text":"A situation where Government borrowing leads to higher interest rates, which reduces private investment"},{"key":"C","text":"A situation where an increase in taxes leads to increased private sector investment"},{"key":"D","text":"A situation where Government spending has no impact on aggregate demand"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q60','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','60',
'Which of the following statements about Rare Earth Elements (REEs) and Critical Minerals is/are correct?
1. Modern technological innovations including Artificial Intelligence, robotics and space exploration extensively utilise Rare Earth Elements (REEs).
2. China has the highest share in mining of REEs followed by India.
3. The Government of India launched the National Critical Mineral Mission (NCMM) in 2025 to establish a robust framework for self-reliance in the critical mineral sector.
4. Rare Earth Elements are a set of 13 metallic elements.',
'[{"key":"A","text":"1 and 3 only"},{"key":"B","text":"3 only"},{"key":"C","text":"1, 3 and 4"},{"key":"D","text":"1, 2 and 4"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q61','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','61',
'Which of the following statements about insurance in aviation sector is/are correct?
1. ''Aviation Hull Insurance'' covers the physical aircraft, including the body, engine, and on-board equipment.
2. Under the Montreal Convention, adopted in 1999 by over 130 countries, including India, airlines are strictly liable to pay compensation to the family/nominee of every deceased passenger without requiring the family to prove fault.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 only"},{"key":"C","text":"Both 1 and 2"},{"key":"D","text":"Neither 1 nor 2"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q62','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','62',
'Which of the following statements about Crowdfunding is/are correct?
1. Crowdfunding is solicitation of funds (small amount) from multiple investors through a web-based platform or social networking site for a specific project.
2. Small and Medium Enterprises (SMEs) are able to raise funds at lower cost of capital without undergoing rigorous procedures.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 only"},{"key":"C","text":"Both 1 and 2"},{"key":"D","text":"Neither 1 nor 2"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q63','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','63',
'With reference to different Committees in India, consider the following details:
1. R. N. Malhotra Committee | Comprehensive reforms of Insurance sector in India | Insurance Regulatory and Development Authority of India
2. L. C. Gupta Committee | Preparing a roadmap for the introduction of derivatives trading in India | Securities and Exchange Board of India
3. Urjit R. Patel Committee | Preparing a roadmap for reforming bank lending to the Housing sector | Reserve Bank of India
4. Y. H. Malegam Committee | Reforming the regulatory framework governing the Microfinance Industry | Reserve Bank of India
In how many of the above rows are the given details correctly matched?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"Only three"},{"key":"D","text":"All four"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q64','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','64',
'Consider the following statements about the Non-Banking Financial Companies (NBFCs) in India:
1. NBFCs cannot accept demand deposits.
2. All the NBFCs operating in India have to be registered with the RBI.
3. NBFCs form part of the payment and settlement system and can issue cheque drawn on itself.
4. Deposit insurance facility of Deposit Insurance and Credit Guarantee Corporation (DICGC) is not available to the depositors of deposit taking NBFCs.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"1 and 4"},{"key":"B","text":"1, 2 and 3"},{"key":"C","text":"4 only"},{"key":"D","text":"2, 3 and 4"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q65','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Economy','65',
'Consider the following statements about Multidimensional Poverty Index (MPI):
1. MPI is calculated using Alkire-Foster methodology.
2. MPI calculated by NITI Aayog has a total of twelve indicators.
3. Maternal Health and Bank Account are common indicators in the MPI of NITI Aayog and MPI of United Nations Development Programme (UNDP).
Which of the statements given above is/are correct?',
'[{"key":"A","text":"1 and 2 only"},{"key":"B","text":"1, 2 and 3"},{"key":"C","text":"1 and 3 only"},{"key":"D","text":"2 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q66','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','66',
'Which of the following statements with regard to genetic medicine is/are correct?
1. Genetic medicines correct/compensate for the faulty genes responsible for disease.
2. Engineered viruses and lipid nanoparticles are used as carriers of the genetic medicine.
3. Genetic medicines alter the entire DNA sequence.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 and 2 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q67','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','67',
'Which of the following statements with regard to Large Language Models (LLMs) used in machine learning is/are correct?
1. LLMs assign probabilities to the next possible words and then pick the one with the highest probability.
2. LLMs process data through mathematical optimization to minimise prediction errors.
3. LLMs produce unbiased outputs.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"1 and 2 only"},{"key":"C","text":"2 and 3 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q68','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','68',
'Which of the following statements with regard to stealth technology is/are correct?
1. Stealth objects have a very small radar cross-section and are coated with Radar Absorbing Material.
2. Stealth objects can be detected using specific frequencies.
3. Stealth objects are coated with metamaterials to increase the scattering of electromagnetic radiation.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 and 2 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q69','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','69',
'Which of the following statements with regard to Black Boxes used in modern aircrafts is/are correct?
1. They carry a beacon emitting red light pulses to facilitate underwater detection.
2. They record both the cockpit voice and flight data.
3. Their memory units are made using either stainless steel or titanium.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 and 2 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q70','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','70',
'Which of the following statements with regard to Green Hydrogen is/are correct?
1. It is decarbonized hydrogen obtained from natural gas reforming combined with carbon capture and storage (CCS).
2. It is produced using electrolysis of water with electricity generated by renewable energy.
3. National Green Hydrogen Mission of India aims for abatement of nearly 50 MMT of annual greenhouse gas emissions by 2030.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"2 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q71','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','71',
'Consider the following statements with regard to involvement of private entities in India''s space programme:
1. The Indian National Space Promotion and Authorisation Centre (IN-SPACe) is an autonomous agency formed to facilitate participation of private entities.
2. Agnikul Cosmos launched the world''s first flight using 3D-printed rocket engine.
3. Skyroot Aerospace has developed liquid fuel for GSLV.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 and 2 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q72','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','72',
'Which of the following statements with regard to drone swarms is/are correct?
1. They use Terahertz band of frequency to communicate with the command centre.
2. Individual drones in the swarm can communicate with other drones in the swarm.
3. GPS Spoofing is a commonly used technique to counter drone swarm attack.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 and 2 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q73','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','73',
'Which of the following statements with regard to GenomeIndia Project is/are correct?
1. It is a part of the Human Genome Project.
2. The project is funded by the Department of Biotechnology (DBT), Government of India.
3. Its primary aim is to build a catalogue of genetic diversity of the Indian population.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 and 2 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q74','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','74',
'Which of the following statements with regard to the National Quantum Mission (NQM) is/are correct?
1. It aims at developing intermediate-scale quantum computers with 50 – 1000 physical qubits.
2. Its implementation includes setting up of four Thematic Hubs (T-Hubs) in academic and national R&D institutes across India.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 only"},{"key":"C","text":"Both 1 and 2"},{"key":"D","text":"Neither 1 nor 2"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q75','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','75',
'Which of the following statements with regard to India''s Deep Ocean Mission is/are correct?
1. It was launched by the Ministry of Ports, Shipping and Waterways, Government of India.
2. Matsya-6000 has been designed to carry 3 people for deep sea exploration.
3. Samudrayaan is a project under this mission.',
'[{"key":"A","text":"1 only"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 and 2 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q76','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Ethics','76',
'Mr. X, a senior officer, was overseeing a critical vaccination programme during a pandemic. He found that a private service provider responsible for vaccine distribution was compromising on quality to make profits. Despite immense pressure to manage the issue due to vested interests, he raised his voice based on the principles of public administration which he learnt during various training programmes attended across his career. He reported the issue to the appropriate vigilance authority and halted the contract to ensure citizen welfare.
Which one among the following principles of public administration was most strongly demonstrated by Mr. X''s actions?',
'[{"key":"A","text":"Esprit de corps"},{"key":"B","text":"Equity"},{"key":"C","text":"Accountability"},{"key":"D","text":"Delegation"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q77','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Ethics','77',
'In a multi-ethnic district where both economic competition and historical grievances frequently led to community tensions, a flashpoint has arisen with a Government decision to allocate land for a waste management facility near a tribal hamlet, sparking protests by the tribal community, which claimed that the land was sacred and critical to their cultural identity. At the same time, urban residents and local industries supported the project, citing severe solid waste challenges and health concerns due to lack of a proper disposal site. The conflict has escalated with road blockades, social media campaigns, and allegations of police excesses.
As a responsible Government official, you are tasked with resolving the situation through mediation, ensuring a sustainable outcome that balances environmental needs, tribal rights, and urban public health.
Consider the following statements with reference to the above:
1. A successful conflict resolution process must begin with acknowledging the cultural concerns of the protesting tribal community before discussing technical alternatives.
2. The Government should move ahead with the project without delay to address urban health concerns, which outweigh the sentiments of a small group.
3. Creating a multi-stakeholder dialogue platform — including tribal leaders, environmental experts, and municipal representatives — to build mutual understanding and help de-escalate tensions.
4. Conducting an independent Environmental and Social Impact Assessment (ESIA) and sharing findings transparently with both sides to facilitate evidence-based decision-making.
Which of the statements given above would contribute to the resolution process?',
'[{"key":"A","text":"1, 3 and 4 only"},{"key":"B","text":"2, 3 and 4 only"},{"key":"C","text":"1 and 2 only"},{"key":"D","text":"1, 2, 3 and 4"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q78','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Ethics','78',
'Ms. X is a mid-level civil service official working in the urban development department of a major city. Recently, she was involved in approving a contract for a public infrastructure project — a new community park. During the approval process, she received a piece of confidential information indicating that one of the shortlisted contractors had a history of poor workmanship and allegations of corruption in other cities, though nothing had been legally proven. The Head of the Department, Mr. Y, advised her not to disclose this information to the project committee or the public because it could delay the project and damage the city''s reputation. However, Ms. X believed that withholding such information compromised transparency and public trust.
What amongst the following should Ms. X do now?
1. Immediately disclose the information to the project committee and the public
2. Recommend removing the contractor from the shortlist to protect the project''s integrity
3. Propose a ''limited disclosure'' to an oversight committee, while keeping the information confidential from the public for the time being',
'[{"key":"A","text":"1 and 2 only"},{"key":"B","text":"3 only"},{"key":"C","text":"2 and 3 only"},{"key":"D","text":"1, 2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q79','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Indian Polity','79',
'''X'' was addressing a seminar on the meaning of the term ''law'' as provided under Article 13, Part III of the Constitution of India. ''X'' explained that the meaning of the term ''law'' in the Constitution of India was very comprehensive. It included ordinances, orders and even rules and regulations. ''Y'' pointed out that the term ''law'' in Article 13 also included custom or usage having in the territory of India the force of law, to which ''X'' was not convinced.
Based on the above, select the correct conclusion from the options given below:',
'[{"key":"A","text":"''X'' is correct in the interpretation of law, including the view on non-inclusion of custom."},{"key":"B","text":"The view of ''Y'' that ''law'' included custom is not correct."},{"key":"C","text":"The views of both ''X'' and ''Y'' are correct."},{"key":"D","text":"The view of only ''Y'' is correct."}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q80','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Indian Polity','80',
'Consider the following statements with reference to the Constitution of India:
1. There is no Article in the Constitution of India that specifies that the Constitution of India will be officially called the ''Constitution of India''.
2. There is no Article in the Constitution of India that specifies that the Indian Independence Act, 1947 and the Government of India Act, 1935 stand repealed.
3. There is no Article in the Constitution of India that mentions 26th January, 1950 as the date of the commencement of the Constitution of India.
Which one of the following conclusions based on the above statements is correct?',
'[{"key":"A","text":"All three statements are correct."},{"key":"B","text":"There is no correct statement."},{"key":"C","text":"There are two correct statements that include statement 3."},{"key":"D","text":"There is only one correct statement."}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q81','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Indian Polity','81',
'Which of the following statements with regard to the persons with disabilities in India is/are correct?
1. The Rights of Persons with Disabilities Act, an Act passed by the Parliament of India in 2018, mandates reservation in education and employment, places a legal duty on Governments to ensure accessibility and non-discrimination.
2. The Sugamya Bharat Abhiyan focuses on achieving universal accessibility for Persons with Disabilities across three key domains — built infrastructure, transport systems and information and communication technology.
3. The National Divyangjan Finance and Development Corporation (NDFDC) is a public sector organisation set up by the Ministry of Corporate Affairs as a not-for-profit company to promote entrepreneurship among Persons with Disabilities (PwDs).',
'[{"key":"A","text":"1 and 2"},{"key":"B","text":"2 only"},{"key":"C","text":"1 and 3"},{"key":"D","text":"1 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q82','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Indian Polity','82',
'Consider the following statements about the provisions pertaining to the Scheduled Castes and the Scheduled Tribes in India:
1. Provisions regarding the administration of the Tribal Areas in the States of Assam, Meghalaya, Tripura and Mizoram are given in the Fifth Schedule of the Constitution of India.
2. Some tribes of India are entitled to exemption from paying Income Tax on certain incomes.
3. The Constitution of India provides for reservation of seats in Panchayats for women belonging to the Scheduled Castes and the Scheduled Tribes.
Which one of the following conclusions based on the above statements is correct?',
'[{"key":"A","text":"There are two correct statements, that include statement 2."},{"key":"B","text":"There are two correct statements, that are statements 1 and 3."},{"key":"C","text":"There is only one correct statement."},{"key":"D","text":"All three statements are correct."}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q83','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Indian Polity','83',
'Consider the following statements in respect of questions asked by the Members in the Parliament of India:
1. Unstarred questions are those to which a Member desires an oral answer in the House.
2. Starred questions are those to which a Member desires a written answer.
3. No supplementary question can be asked on an unstarred question.
Which one of the following conclusions based on the above statements is correct?',
'[{"key":"A","text":"All the three statements are correct."},{"key":"B","text":"There are two correct statements, that include statement 2."},{"key":"C","text":"There is only one correct statement."},{"key":"D","text":"There is no correct statement."}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q84','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Indian Polity','84',
'Consider the following statements about the Committee on the Welfare of Scheduled Castes and Scheduled Tribes of the Parliament of India:
1. Although members of this Committee are elected from both Houses of Parliament, the Chairperson of this Committee is appointed by the Chairman of the Rajya Sabha.
2. Twenty members are elected by the Rajya Sabha and ten members by the Lok Sabha.
3. No Minister, except for the Union Minister of Social Justice and Empowerment, is eligible to be a member of this Committee.
4. Members are elected for a fixed term of two years from the date they enter their office.
Which one of the following conclusions based on the above statements is correct?',
'[{"key":"A","text":"There are four correct statements."},{"key":"B","text":"There is only one correct statement, that is statement 2."},{"key":"C","text":"There are two correct statements, that include statement 1."},{"key":"D","text":"There is no correct statement."}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q85','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Defense & Security','85',
'Consider the following statements about Mission Sudarshan Chakra of India:
1. It aims to enhance India''s air defence, ballistic missile defence and aerial offensive capabilities.
2. This Mission is being designed to enhance rapid, precise, and powerful defence responses, reinforcing India''s strategic autonomy.
3. One of the aims of this Mission is to cover all public places of India by an expanded nationwide security shield by 2035.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"1, 2 and 3"},{"key":"B","text":"1 and 2 only"},{"key":"C","text":"2 and 3 only"},{"key":"D","text":"1 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q86','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Geography','86',
'Consider the following statements about river bridges connecting India with neighbouring countries:
1. ''Maitri Setu'', built over Feni river, connects Ramgarh in India with Sabroom in Bangladesh.
2. Jhulaghat suspension bridge connects India with Myanmar.
3. Mechi bridge and its approaches connect Panitanki Bypass in India with Kakarvitta in Nepal.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"1 and 2"},{"key":"B","text":"2 and 3"},{"key":"C","text":"1 only"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q87','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Indian Polity','87',
'Which of the following statements about a Zero First Information Report (Zero FIR) under the Bharatiya Nagarik Suraksha Sanhita (BNSS), 2023 is/are correct?
1. A Zero FIR can be lodged at a police station, even though the place of commission of a cognizable/non-cognizable offence is outside the territorial jurisdiction of that police station.
2. The Officer-in-Charge of the police station where a Zero FIR has been lodged may, with the permission of the competent authority, initiate a preliminary enquiry.
3. Under Zero FIR, it is obligatory for the informant to furnish information electronically.',
'[{"key":"A","text":"1, 2 and 3"},{"key":"B","text":"2 and 3 only"},{"key":"C","text":"1 only"},{"key":"D","text":"2 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q88','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Indian Polity','88',
'With reference to the organisations under the Government of India, consider the following details:
1. Central Economic Intelligence Bureau (CEIB) | To coordinate between various law enforcement agencies | Ministry of Home Affairs
2. Serious Fraud Investigation Office (SFIO) | To investigate complex corporate frauds | Ministry of Finance
3. Central Bureau of Investigation (CBI) | To preserve values in public life and ensure the health of the national economy | Ministry of Personnel, Public Grievances and Pension
In how many of the above rows are the given details correctly matched?',
'[{"key":"A","text":"Only one"},{"key":"B","text":"Only two"},{"key":"C","text":"All three"},{"key":"D","text":"None"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q89','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','International Relations','89',
'Which of the following international conventions have not been ratified by India?
1. Employment Policy Convention
2. Abolition of Forced Labour Convention
3. International Convention on the Protection of the Rights of All Migrant Workers and Members of Their Families
4. Geneva Convention Relative to the Protection of Civilian Persons in Time of War
5. Convention on Reduction of Statelessness',
'[{"key":"A","text":"2 and 4"},{"key":"B","text":"1 and 2"},{"key":"C","text":"3 and 4 only"},{"key":"D","text":"3, 4 and 5"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q90','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Science & Technology','90',
'Consider the following statements with respect to the AI Impact Summit, 2026 held in New Delhi:
1. The Summit''s intellectual framework was based on three foundational Sutras: People, Planning, and Progress.
2. The Preamble of the Summit stresses Democratising AI Resources, which acknowledges the Charter for Democratic Diffusion of AI as a binding framework to support locally relevant innovation and strengthen resilient AI ecosystems while respecting national laws.
3. The New Delhi Declaration on AI Impact was structured around seven Chakras (Pillars), which included Access for Social Empowerment, AI for Science, and Secure and Trusted AI.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"1, 2 and 3"},{"key":"B","text":"1 and 2 only"},{"key":"C","text":"2 and 3 only"},{"key":"D","text":"3 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q91','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','International Relations','91',
'Which of the following connectivity projects is/are a part of cooperation between India and the ASEAN member countries?
1. Kaladan Multi-Modal Transit Transport Project
2. IMT Trilateral Highway
3. Agartala-Akhaura Rail Line',
'[{"key":"A","text":"1 and 2"},{"key":"B","text":"2 and 3"},{"key":"C","text":"1 and 3"},{"key":"D","text":"2 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q92','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','International Relations','92',
'Match List I (Project Supported by India) with List II (Country):
List I                                              List II
A. Mangdechhu Hydroelectric Project            — 1. Maldives
B. Restoration of Stor Palace                  — 2. Afghanistan
C. District Hospital at Dickoya                — 3. Bhutan
D. Institute of Security and Law Enforcement Studies — 4. Sri Lanka',
'[{"key":"A","text":"A-1, B-4, C-2, D-3"},{"key":"B","text":"A-3, B-2, C-4, D-1"},{"key":"C","text":"A-3, B-4, C-2, D-1"},{"key":"D","text":"A-1, B-2, C-4, D-3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q93','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Defense & Security','93',
'Which of the following items of defence hardware is/are manufactured in India?
1. Su-30 MKI Fighter Jets
2. T-90 MK-III Tanks
3. Akula Class Submarine',
'[{"key":"A","text":"1 and 2"},{"key":"B","text":"1 and 3"},{"key":"C","text":"1 only"},{"key":"D","text":"2 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q94','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','International Relations','94',
'Consider the following statements about platforms for multilateral co-operation:
1. The ''Colombo Process'' is a regional consultative process in which member states take binding decisions by consensus.
2. The ''Abu Dhabi Dialogue'' is a voluntary non-binding consultative process among Asian countries of labour origin and destination to facilitate regional cooperation on contractual labour mobility.
3. The ''Global Forum for Migration and Development'', created upon the proposal of a former UN Secretary General, is a voluntary forum whose decisions are non-binding in nature.
Which of the statements given above is/are correct?',
'[{"key":"A","text":"1, 2 and 3"},{"key":"B","text":"1 and 3 only"},{"key":"C","text":"2 and 3 only"},{"key":"D","text":"2 only"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q95','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','International Relations','95',
'Consider the following UN organisations/agencies:
1. World Food Programme
2. United Nations Children''s Fund
3. United Nations High Commissioner for Refugees
4. International Labour Organisation
How many of the above has/have been awarded the Nobel Prize twice?',
'[{"key":"A","text":"1"},{"key":"B","text":"2"},{"key":"C","text":"3"},{"key":"D","text":"4"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q96','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','International Relations','96',
'Match List I (UN Peacekeeping Operation) with List II (Period of Operation):
List I              List II
A. UNMIL       — 1. 2007 – 2010
B. MINURCAT    — 2. 2002 – 2005
C. MINUSTAH    — 3. 2003 – 2018
D. UNMISET     — 4. 2004 – 2017',
'[{"key":"A","text":"A-3, B-4, C-1, D-2"},{"key":"B","text":"A-3, B-1, C-4, D-2"},{"key":"C","text":"A-2, B-1, C-4, D-3"},{"key":"D","text":"A-2, B-4, C-1, D-3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q97','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','International Relations','97',
'Match List I (BIMSTEC Centre/Establishment) with List II (Location):
List I                                   List II
A. BIMSTEC Cultural Industries Observatory  — 1. NOIDA
B. BIMSTEC Energy Centre                    — 2. Bengaluru
C. BIMSTEC Centre for Weather and Climate   — 3. Colombo
D. BIMSTEC Technology Transfer Facility     — 4. Thimphu',
'[{"key":"A","text":"A-3, B-2, C-1, D-4"},{"key":"B","text":"A-3, B-1, C-2, D-4"},{"key":"C","text":"A-4, B-2, C-1, D-3"},{"key":"D","text":"A-4, B-1, C-2, D-3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q98','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Defense & Security','98',
'Which one of the following pairs is not correctly matched?
(Indian Army Corps — Headquarters)',
'[{"key":"A","text":"3 Corps — Dimapur"},{"key":"B","text":"4 Corps — Tezpur"},{"key":"C","text":"14 Corps — Leh"},{"key":"D","text":"33 Corps — Srinagar"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q99','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','Indian Polity','99',
'Which of the following statements with respect to the Revamped Rashtriya Gram Swaraj Abhiyan (RGSA) is/are correct?
1. The period of its implementation is 1st April, 2021 to 31st March, 2026.
2. The key objective of the Revamped RGSA is to develop the governance capabilities of the Panchayati Raj Institutions to deliver on the Sustainable Development Goals.
3. The share of the Central funding for the Revamped RGSA is 100% for all States and Union Territories.',
'[{"key":"A","text":"1 and 2"},{"key":"B","text":"2 only"},{"key":"C","text":"1 and 3"},{"key":"D","text":"2 and 3"}]'::jsonb,
'','','','[]'::jsonb),

('upsc-cse-pre-2026-gs1-q100','upsc-cse','upsc-cse-prelims-2026-gs1','Union Public Service Commission Civil Services Examination','2026','GS Paper I 2026','International Relations','100',
'Which of the following countries are members of the European Union?
1. Belarus
2. Poland
3. Germany
4. Switzerland',
'[{"key":"A","text":"1, 2 and 4"},{"key":"B","text":"1 and 4 only"},{"key":"C","text":"2 and 3"},{"key":"D","text":"2 and 4 only"}]'::jsonb,
'','','','[]'::jsonb);

COMMIT;
