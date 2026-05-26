-- RSMSSB Patwari 2025, 17 Aug 2025, Shift 1, booklet SPZ8.
-- Adds Rajasthan/RSMSSB to the States category and stores bilingual
-- Hindi/English question text in vaultcore.questions.translations.
--
-- Answer key was not present in the source text supplied for this import,
-- so answer_key/answer are intentionally marked Pending.

ALTER TABLE vaultcore.questions
  ADD COLUMN IF NOT EXISTS translations JSONB NOT NULL DEFAULT '{}'::jsonb;

INSERT INTO vaultcore.exams (
  slug, name, short_name, category, icon, total_questions, papers, mocks,
  description, popular_years, subjects
)
VALUES (
  'rssb',
  'Rajasthan Staff Selection Board',
  'RSSB',
  'States',
  '📋',
  150,
  1,
  0,
  'Rajasthan Staff Selection Board (RSSB) conducts competitive examinations for recruitment to non-gazetted posts in Rajasthan government departments, including Patwari, Junior Assistant, VDO, CET, and other grade-III state service posts.',
  '["2025"]'::jsonb,
  '["Reasoning","Quantitative Aptitude","Computer Awareness","Rajasthan GK","Indian Polity","Indian History","Geography","Science","English Language","Hindi Language"]'::jsonb
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  short_name = EXCLUDED.short_name,
  category = EXCLUDED.category,
  icon = EXCLUDED.icon,
  total_questions = GREATEST(vaultcore.exams.total_questions, EXCLUDED.total_questions),
  papers = GREATEST(vaultcore.exams.papers, EXCLUDED.papers),
  mocks = EXCLUDED.mocks,
  description = EXCLUDED.description,
  popular_years = EXCLUDED.popular_years,
  subjects = EXCLUDED.subjects,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO vaultcore.papers (
  slug, exam_slug, exam_name, title, year, shift, description, questions,
  subjects, negative_marking, source_url, duration_minutes, max_marks, held_on
)
VALUES (
  'rsmssb-patwari-2025-aug17-shift1-spz8',
  'rsmssb',
  'RSMSSB',
  'RSMSSB Patwari 2025 (17 Aug, Shift 1) - SPZ8',
  '2025',
  'Shift 1',
  'RSMSSB Patwari examination paper held on 17 Aug 2025, Shift 1, booklet code SPZ8. The source booklet is bilingual Hindi-English with 150 questions, 3 hours, 300 marks and one-third negative marking.',
  150,
  '["Reasoning","Quantitative Aptitude","Computer Awareness","Rajasthan GK","Indian Polity","Indian History","Geography","Science","English Language","Hindi Language"]'::jsonb,
  0.67,
  'https://www.adda247.com/jobs/wp-content/uploads/2025/08/18104720/Rajasthan-patwari-question-paper-held-on-17-aug-2025-S1.pdf',
  180,
  300,
  DATE '2025-08-17'
)
ON CONFLICT (slug) DO UPDATE SET
  exam_slug = EXCLUDED.exam_slug,
  exam_name = EXCLUDED.exam_name,
  title = EXCLUDED.title,
  year = EXCLUDED.year,
  shift = EXCLUDED.shift,
  description = EXCLUDED.description,
  questions = EXCLUDED.questions,
  subjects = EXCLUDED.subjects,
  negative_marking = EXCLUDED.negative_marking,
  source_url = EXCLUDED.source_url,
  duration_minutes = EXCLUDED.duration_minutes,
  max_marks = EXCLUDED.max_marks,
  held_on = EXCLUDED.held_on,
  updated_at = CURRENT_TIMESTAMP;

WITH source_questions AS (
  SELECT *
  FROM (VALUES
    (1, 'Reasoning',
     'देश के पास जल संसाधन विकसित करने के लिए पर्याप्त धनराशि नहीं है।',
     'The country does not have enough funds to develop water resources.',
     '["निश्चित गलत","संभावित सही","संभावित गलत","निश्चित सही"]'::jsonb,
     '["Definitely false","Probably true","Probably false","Definitely true"]'::jsonb),
    (2, 'Reasoning',
     'बाढ़ आने से जल संसाधनों में वृद्धि होती है।',
     'Occurrence of floods adds to the water resources.',
     '["निश्चित गलत","संभावित सही","संभावित गलत","निश्चित सही"]'::jsonb,
     '["Definitely false","Probably true","Probably false","Definitely true"]'::jsonb),
    (3, 'Reasoning',
     'वर्षा जल संग्रहण की जल संसाधन वृद्धि में कोई भूमिका नहीं है।',
     'Rainwater harvesting plays no role in increasing water resources.',
     '["संभावित सही","संभावित गलत","निश्चित गलत","निश्चित सही"]'::jsonb,
     '["Probably true","Probably false","Definitely false","Definitely true"]'::jsonb),
    (4, 'Reasoning',
     'उत्तर की ओर मुँह किए हुए 5 लड़कियों की एक पंक्ति में, रीता, लता के दाईं ओर दूसरे स्थान पर बैठी है और अलका, सीमा के बाईं ओर तीसरे स्थान पर बैठी है। सीमा पंक्ति के किसी भी अंतिम छोर पर नहीं बैठी है। पंक्ति के मध्य में कौन बैठी है?',
     'In a row of 5 girls facing North, Rita is sitting second to the right of Lata and Alka is sitting third to the left of Seema. Seema is not sitting at either of the extreme ends of the row. Who is sitting in the middle of the row?',
     '["रीता","लता","सीमा","अलका"]'::jsonb,
     '["Rita","Lata","Seema","Alka"]'::jsonb),
    (5, 'Reasoning',
     'रीना अपने घर से कॉलेज जा रही है। वह उत्तर की ओर 500 मीटर चलती है, फिर मंदिर से ठीक बाईं ओर मुड़ती है तथा 700 मीटर और चलती है। दाईं ओर मुड़ते हुए, वह 2.5 किमी दूर स्थित बस स्टॉप के लिए रिक्शा लेती है। फिर वह बस पकड़ती है और अपने कॉलेज तक पहुँचने के लिए बाईं ओर 3.3 किमी की यात्रा करती है। रीना के कॉलेज और घर के बीच की न्यूनतम हवाई दूरी है:',
     'Reena is travelling to her college from her home. She walks 500 m towards the North, then takes a sharp left from the temple and walks another 700 m. Taking a right turn, she takes a rickshaw for the bus stop, which is located 2.5 km away. She then catches a bus and travels 3.3 km towards the left to reach her college. The shortest aerial distance between Reena''s college and her home is:',
     '["4 किमी","5 किमी","7 किमी","3.5 किमी"]'::jsonb,
     '["4 km","5 km","7 km","3.5 km"]'::jsonb),
    (6, 'Reasoning',
     'C, H, I, P, S और Y एक नियमित षट्कोणीय मेज़ के केंद्र की ओर मुख करके बैठे हैं। P, Y के दायीं ओर दूसरे स्थान पर बैठा है। C और S के मध्य एकमात्र व्यक्ति बैठा है। H के सामने कौन बैठा है?',
     'C, H, I, P, S and Y are sitting around a regular hexagonal table facing the centre. P is sitting second to the right of Y. I is the only person sitting between C and S. Who is sitting opposite to H?',
     '["C","S","I","Y"]'::jsonb,
     '["C","S","I","Y"]'::jsonb),
    (7, 'Reasoning',
     'दी गयी श्रृंखला में उस विकल्प का चयन कीजिये जो वह संख्या दर्शाता है जो कि 2 और 3 से पूर्ण भाज्य है और उससे आगे विषम संख्या और पीछे सम संख्या आती है। 26, 27, 36, 6, 6, 5, 6, 6, 36, 37, 24, 12, 26, 15, 18, 22, 25, 12, 24, 21, 42, 36',
     'In the given series, choose the option that indicates the numbers that are exactly divisible by both 2 and 3, and are also preceded by an odd number and succeeded by an even number. 26, 27, 36, 6, 6, 5, 6, 6, 36, 37, 24, 12, 26, 15, 18, 22, 25, 12, 24, 21, 42, 36',
     '["5","6","8","3"]'::jsonb,
     '["5","6","8","3"]'::jsonb),
    (8, 'Reasoning',
     'यदि किसी निश्चित भाषा में, ORANGE को QTCPIG के रूप में कूटबद्ध किया जाता है, तो YCVGTOGNQP किस शब्द का कूट है?',
     'If in a certain language, ORANGE is coded as QTCPIG, then YCVGTOGNQP is the code for which word?',
     '["WATERFILTER","WATERAPPLE","WATERMELON","WATERPISTON"]'::jsonb,
     '["WATERFILTER","WATERAPPLE","WATERMELON","WATERPISTON"]'::jsonb),
    (9, 'Reasoning',
     'एक लड़का अपने दोस्त से मिलने सुबह 8:30 बजे आता है, वह फिर 9:15 बजे आता है फिर तीसरी बार 10:15 बजे आता है और चौथी बार 11:30 बजे आता है। वह फिर कब आएगा?',
     'A boy comes to meet his friend in the morning at 8:30 AM, he again comes at 9:15 AM then he comes third time at 10:15 AM and the fourth time he comes at 11:30 AM. When will he come again?',
     '["दोपहर 12:30 बजे","दोपहर 01:00 बजे","दोपहर 01:15 बजे","दोपहर 12:45 बजे"]'::jsonb,
     '["12:30 PM","01:00 PM","01:15 PM","12:45 PM"]'::jsonb),
    (10, 'Reasoning',
     'शब्द और संख्या व्यवस्था मशीन के दिए गए इनपुट Strike 82 Reference 25 Depends 38 Of 53 Wind 36 के लिए चरण I में Wind के दाईं ओर की संख्याओं का योग क्या है?',
     'For the word and number arrangement input Strike 82 Reference 25 Depends 38 Of 53 Wind 36, what is the sum of the numbers that are towards the right of Wind in Step I?',
     '["112","118","120","110"]'::jsonb,
     '["112","118","120","110"]'::jsonb),
    (11, 'Reasoning',
     'शब्द और संख्या व्यवस्था मशीन में चरण III में दाएं छोर से तीसरे पद के बाएं से दूसरा पद कौन सा है?',
     'In the word and number arrangement machine, which element is second to the left of the third element from the right end in Step III?',
     '["Depends","Wind","Of","53"]'::jsonb,
     '["Depends","Wind","Of","53"]'::jsonb),
    (12, 'Reasoning',
     'शब्द और संख्या व्यवस्था मशीन में चरण V में दायें छोर से तीसरे पद के बायें से दूसरा पद कौन सा है?',
     'In the word and number arrangement machine, which element is second to the left of the third element from the right end in Step V?',
     '["Wind","Depends","82","38"]'::jsonb,
     '["Wind","Depends","82","38"]'::jsonb),
    (13, 'Computer Awareness',
     'कंप्यूटर शब्दावली में FTP का पूर्ण रूप क्या है?',
     'What is the full form of FTP in computer terminology?',
     '["फाइल ट्रांसफर प्रोटोकॉल","फ़ाइल ट्रांसफर्ड प्रोटोकॉल","फॉर्म ट्रांसफर प्रोटोकॉल","फ़ाइल ट्रांसमिशन प्रोटोकॉल"]'::jsonb,
     '["File Transfer Protocol","File Transferred Protocol","Form Transfer Protocol","File Transmission Protocol"]'::jsonb),
    (14, 'Computer Awareness',
     'प्रेजेंटेशन की समीक्षा करते समय प्रूफिंग अनुभाग में निम्नलिखित में से किस कमांड का उपयोग नहीं किया जाता है?',
     'Which of the following commands is not used in the proofing section while reviewing a presentation?',
     '["किसी विशेष शब्द का सही उच्चारण खोजने के लिए वॉयस बटन","किसी विशेष विषय या शब्द पर जानकारी खोजने के लिए रिसर्च बटन","किसी विशेष शब्द के लिए पर्यायवाची और विलोम शब्द खोजने के लिए थिसॉरस बटन","वर्तनी त्रुटियों की जांच के लिए वर्तनी बटन"]'::jsonb,
     '["Voice button to find the correct pronunciation of a particular word","Research button to find information on a particular topic or word","Thesaurus button to find synonyms and antonyms for a particular word","Spelling button to check spelling errors"]'::jsonb),
    (15, 'Computer Awareness',
     'स्प्रेडशीट में सेल डेटा का कौन सा प्रकार सामान्यतः प्रयुक्त नहीं होता है?',
     'Which is not a commonly used type of cell data in Spreadsheet?',
     '["न्यूमेरिक वैल्यू","डेट और टाइम","यूजर ऑथेंटिकेशन","लेबल और फॉर्मूला"]'::jsonb,
     '["Numeric value","Date and time","User authentication","Label and Formula"]'::jsonb),
    (16, 'Quantitative Aptitude',
     'वर्ष 2023 में, एक कॉलेज में 5000 छात्र थे। छात्रों की संख्या प्रति वर्ष 24% की दर से बढ़ जाती है। तो वर्ष 2025 में कॉलेज में कितने विद्यार्थी होंगे?',
     'In the year 2023, there were 5000 students in a college. The number of students is increased by 24% every year. How many students will there be in the college in the year 2025?',
     '["9763","7688","4232","7244"]'::jsonb,
     '["9763","7688","4232","7244"]'::jsonb),
    (17, 'Reasoning',
     'कथन: जो लोग रिश्वतखोरी के खिलाफ बहुत ज्यादा बोलते हैं, ये वे लोग हैं जिन्होंने खुद रिश्वत ली है। निष्कर्ष: I. सभी लोग भ्रष्ट हैं। II. यह कहना जितना आसान है, करना उतना आसान नहीं है। कौन सा निष्कर्ष अनुसरण करता है?',
     'Statement: People who speak too much against bribery are those who had taken it themselves. Conclusions: I. All people are corrupt. II. It is easier said than done. Which conclusion follows?',
     '["केवल निष्कर्ष II अनुसरण करता है","न तो निष्कर्ष I और न ही II अनुसरण करता है","दोनों निष्कर्ष I और II अनुसरण करते हैं","केवल निष्कर्ष I अनुसरण करता है"]'::jsonb,
     '["Only conclusion II follows","Neither conclusion I nor II follows","Both conclusions I and II follow","Only conclusion I follows"]'::jsonb),
    (18, 'Quantitative Aptitude',
     'एक वस्तु को ₹100 में बेचने पर, एक व्यक्ति को ₹15 का लाभ होता है। दी गई वस्तु के लिए लाभ प्रतिशत क्या है?',
     'By selling an article for ₹100, a man gains ₹15. What is the gain percentage for the article?',
     '["11 16/17%","8 10/17%","17 11/17%","15%"]'::jsonb,
     '["11 16/17%","8 10/17%","17 11/17%","15%"]'::jsonb),
    (19, 'Quantitative Aptitude',
     'एक पुस्तकालय में रविवार को औसतन 252 आगंतुक आते हैं, और अन्य दिनों में 120 आगंतुक आते हैं। जून महीने में, जो रविवार से शुरू हो रहा है, प्रति दिन आगंतुकों की औसत संख्या क्या है?',
     'A library has an average of 252 visitors on Sundays, and 120 on other days. What is the average number of visitors per day in the month of June, beginning with a Sunday?',
     '["172","139","142","184"]'::jsonb,
     '["172","139","142","184"]'::jsonb),
    (20, 'Reasoning',
     'निम्नलिखित ज्यामितिय आकृतियों को उनके कोणों की संख्या के अनुसार आरोही क्रम में व्यवस्थित कीजिये: i. सप्तभुज ii. त्रिभुज iii. षट्भुज iv. दशभुज v. पंचभुज vi. चतुर्भुज',
     'Arrange the following geometrical figures in ascending order based on the number of their angles: i. Heptagon ii. Triangle iii. Hexagon iv. Decagon v. Pentagon vi. Quadrilateral',
     '["ii, vi, v, i, iii, iv","ii, v, vi, iii, i, iv","ii, vi, v, iii, i, iv","iv, i, iii, v, ii, vi"]'::jsonb,
     '["ii, vi, v, i, iii, iv","ii, v, vi, iii, i, iv","ii, vi, v, iii, i, iv","iv, i, iii, v, ii, vi"]'::jsonb)
  ) AS q(question_no, subject, hi_question, en_question, hi_options, en_options)
),
numbered AS (
  SELECT
    question_no,
    subject,
    hi_question,
    en_question,
    hi_options,
    en_options,
    jsonb_build_object(
      'en', jsonb_build_object('question', en_question, 'options', en_options),
      'hi', jsonb_build_object('question', hi_question, 'options', hi_options)
    ) AS translations
  FROM source_questions
)
INSERT INTO vaultcore.questions (
  slug, exam_slug, paper_slug, exam_name, year, paper, subject, question_no,
  question, options, answer_key, answer, explanation, tags, translations
)
SELECT
  'rsmssb-patwari-2025-aug17-s1-spz8-q' || question_no,
  'rsmssb',
  'rsmssb-patwari-2025-aug17-shift1-spz8',
  'RSMSSB',
  '2025',
  'RSMSSB Patwari 2025 Shift 1 SPZ8',
  subject,
  question_no::text,
  en_question,
  (
    SELECT jsonb_agg(jsonb_build_object('key', chr(64 + ordinality::int), 'text', value))
    FROM jsonb_array_elements_text(en_options) WITH ORDINALITY
  ),
  'Pending',
  'Pending official key',
  'Answer key and explanation were not included in the supplied source text.',
  jsonb_build_array('RSMSSB', 'Patwari', '2025', 'Shift 1', 'SPZ8', subject),
  translations
FROM numbered
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
  translations = EXCLUDED.translations,
  updated_at = CURRENT_TIMESTAMP;

-- Keep aggregate counts in sync after this paper import.
UPDATE vaultcore.papers
SET questions = (
  SELECT COUNT(*)
  FROM vaultcore.questions
  WHERE paper_slug = 'rsmssb-patwari-2025-aug17-shift1-spz8'
)
WHERE slug = 'rsmssb-patwari-2025-aug17-shift1-spz8';

UPDATE vaultcore.exams
SET
  papers = (SELECT COUNT(*) FROM vaultcore.papers WHERE exam_slug = 'rsmssb'),
  total_questions = (SELECT COUNT(*) FROM vaultcore.questions WHERE exam_slug = 'rsmssb'),
  updated_at = CURRENT_TIMESTAMP
WHERE slug = 'rsmssb';
