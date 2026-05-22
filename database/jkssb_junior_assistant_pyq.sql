-- JKSSB Junior Assistant PYQ | 80 Questions | Negative Marking: 0.25
-- Source: jkssbedge.com/jkssb-junior-assistant-pyq/

INSERT INTO vaultcore.papers (slug, exam_slug, exam_name, title, year, shift, description, questions, subjects, negative_marking, updated_at)
VALUES (
  'jkssb-junior-assistant-pyq',
  'jkssb',
  'JKSSB',
  'JKSSB Junior Assistant PYQ',
  '',
  '',
  'JKSSB Junior Assistant Previous Year Question Paper. 80 questions covering English, Computer Awareness, Mathematics, Reasoning, General Knowledge and J&K GK.',
  80,
  '["English","Computer Awareness","Mathematics","Reasoning","General Knowledge","J&K GK"]'::jsonb,
  0.25,
  CURRENT_TIMESTAMP
)
ON CONFLICT (slug) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  questions = EXCLUDED.questions,
  subjects = EXCLUDED.subjects,
  negative_marking = EXCLUDED.negative_marking,
  updated_at = CURRENT_TIMESTAMP;

DELETE FROM vaultcore.questions WHERE paper_slug = 'jkssb-junior-assistant-pyq';

INSERT INTO vaultcore.questions (slug, exam_slug, paper_slug, exam_name, year, paper, subject, question_no, question, options, answer_key, answer, explanation, tags, updated_at) VALUES

('jkssb-junior-assistant-pyq-1','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','1',
'Arrange the following segments to form two meaningful sentences: P: Mornings at her grandmother''s house  Q: Baked bread filled the kitchen  R: The aroma of freshly  S: It reminded her of childhood',
'[{"key":"A","text":"SQRP"},{"key":"B","text":"RQSP"},{"key":"C","text":"SPRQ"},{"key":"D","text":"QRPS"}]'::jsonb,
'B','RQSP','Correct sequence: "The aroma of freshly baked bread filled the kitchen. It reminded her of childhood mornings at her grandmother''s house."','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-2','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','2',
'Find the error in the underlined parts: "His perspicacious (a)/ observations would have revealed (b)/ insights that had (c)/ previously gone unnoticed (d)."',
'[{"key":"A","text":"His perspicacious"},{"key":"B","text":"Observations would have revealed"},{"key":"C","text":"Insights that had"},{"key":"D","text":"Previously gone unnoticed"}]'::jsonb,
'B','Observations would have revealed','The conditional "would have revealed" is incorrect here; simple past "revealed" is the correct form.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-3','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','3',
'Convert to indirect speech: He said, "I am going to the market now."',
'[{"key":"A","text":"He said that he was going to the market then."},{"key":"B","text":"He said that he is going to the market now."},{"key":"C","text":"He says that he is going to the market now."},{"key":"D","text":"He said that I was going to the market then."}]'::jsonb,
'A','He said that he was going to the market then.','In indirect speech, present tense changes to past tense and "now" changes to "then".','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-4','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','4',
'Fill in the blank: We _____ have locked the gate. Then the dog wouldn''t have got out.',
'[{"key":"A","text":"ought to"},{"key":"B","text":"would"},{"key":"C","text":"may"},{"key":"D","text":"have to"}]'::jsonb,
'A','ought to','Ought to have + past participle expresses obligation or duty in the past that was not fulfilled.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-5','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','5',
'Fill in the blanks: Sudha is studying in _____ Canadian University. From there, it will take _____ hour for her to reach the airport.',
'[{"key":"A","text":"an, a"},{"key":"B","text":"the, an"},{"key":"C","text":"the, a"},{"key":"D","text":"a, an"}]'::jsonb,
'D','a, an','"a" Canadian (consonant sound /k/); "an" hour (silent h, vowel sound /aʊ/).','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-6','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','6',
'[Passage: A group of friends go on a hiking trip carrying bags, crossing terrain and enjoying the view.] What is the meaning of the idiom "a piece of cake" as used in the passage?',
'[{"key":"A","text":"A quirky experience"},{"key":"B","text":"A strenuous task"},{"key":"C","text":"A facile task"},{"key":"D","text":"A bizarre event"}]'::jsonb,
'C','A facile task','"A piece of cake" means something very easy to do. Facile means easily achieved.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-7','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','7',
'[Passage: A group of friends go on a hiking trip using pronouns we, our, and them.] Which pronoun is NOT used in the passage?',
'[{"key":"A","text":"We"},{"key":"B","text":"They"},{"key":"C","text":"Our"},{"key":"D","text":"She"}]'::jsonb,
'D','She','The passage describes a group activity using "we", "our" and references others as "they". The pronoun "she" does not appear.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-8','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','8',
'[Passage: A group of friends go on a hiking trip.] Which of the following words from the passage has a homophone?',
'[{"key":"A","text":"Bags"},{"key":"B","text":"Across"},{"key":"C","text":"Hear"},{"key":"D","text":"View"}]'::jsonb,
'C','Hear','"Hear" has the homophone "Here" — they sound identical but have different meanings and spellings.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-9','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','9',
'Select the correctly punctuated sentence:',
'[{"key":"A","text":"Jaya said, ''They were getting really excited and were shouting \"Come on!\"''"},{"key":"B","text":"Jaya said They were getting really excited and were shouting \"Come on!\""},{"key":"C","text":"Jaya said, ''they were getting really excited and were shouting'' \"Come on!\""},{"key":"D","text":"Jaya said, ''they were getting really excited and were shouting'' Come on."}]'::jsonb,
'A','Jaya said, ''They were getting really excited and were shouting "Come on!"''','Option A correctly uses outer single quotes for the reported speech and inner double quotes for the exclamation, with correct capitalisation.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-10','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','10',
'Choose the synonym of "Gallant":',
'[{"key":"A","text":"Valiant"},{"key":"B","text":"Coward"},{"key":"C","text":"Craven"},{"key":"D","text":"Timid"}]'::jsonb,
'A','Valiant','Gallant and Valiant both mean brave and heroic. Coward, Craven, and Timid are antonyms.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-11','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','11',
'Choose the antonym of "Idiosyncrasy":',
'[{"key":"A","text":"Erraticism"},{"key":"B","text":"Conformity"},{"key":"C","text":"Peculiarity"},{"key":"D","text":"Oddity"}]'::jsonb,
'B','Conformity','Idiosyncrasy means a peculiar habit or characteristic. Its antonym is conformity — adhering to accepted norms.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-12','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','12',
'What is the meaning of the idiom "By the skin of your teeth"?',
'[{"key":"A","text":"Be in a comfortable situation"},{"key":"B","text":"Do more than you can actually do"},{"key":"C","text":"Spoil someone''s praise moment"},{"key":"D","text":"Narrowly avoiding something"}]'::jsonb,
'D','Narrowly avoiding something','The idiom means to barely escape or succeed by a very small margin.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-13','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','13',
'Fill in the blanks: She stood _____ the window, lost in thought _____ her future plans for the upcoming year.',
'[{"key":"A","text":"by, about"},{"key":"B","text":"beside, towards"},{"key":"C","text":"by, towards"},{"key":"D","text":"beside, about"}]'::jsonb,
'A','by, about','"Stand by the window" (near the window) and "think about plans" are the correct preposition collocations.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-14','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','14',
'Fill in the blanks: The team worked tirelessly _____ the guidance of their coach to improve their performance _____ the challenging season.',
'[{"key":"A","text":"by, about"},{"key":"B","text":"under, towards"},{"key":"C","text":"under, during"},{"key":"D","text":"by, during"}]'::jsonb,
'C','under, during','"Under the guidance" (working below someone''s direction) and "during the season" (throughout a period) are correct.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-15','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','15',
'Convert to passive voice: "They are organizing a farewell party next week."',
'[{"key":"A","text":"A farewell party is being organized next week."},{"key":"B","text":"A farewell party is being organized by them next week."},{"key":"C","text":"A farewell party was organized by them next week."},{"key":"D","text":"A farewell party will be organized by them next week."}]'::jsonb,
'B','A farewell party is being organized by them next week.','Active present continuous → passive: object becomes subject, "is being organized" is used, and agent "by them" is retained.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-16','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Quantitative Aptitude','16',
'Find the wrong number in the series: 336, 272, 321, 286, 310, 294',
'[{"key":"A","text":"272"},{"key":"B","text":"286"},{"key":"C","text":"321"},{"key":"D","text":"310"}]'::jsonb,
'B','286','Pattern: 336-64(8²)=272, 272+49(7²)=321, 321-36(6²)=285 (not 286), 285+25(5²)=310, 310-16(4²)=294. So 286 should be 285.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-17','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Quantitative Aptitude','17',
'Find the last term in the series: 234, 117, 351, 87.75, 438.75, ?',
'[{"key":"A","text":"143.75"},{"key":"B","text":"117.25"},{"key":"C","text":"93.50"},{"key":"D","text":"73.125"}]'::jsonb,
'D','73.125','Pattern: ÷2, ×3, ÷4, ×5, ÷6. So 438.75 ÷ 6 = 73.125.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-18','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','18',
'What is the correct relationship between bits and bytes?',
'[{"key":"A","text":"1 bit = 8 bytes"},{"key":"B","text":"1 byte = 8 bits"},{"key":"C","text":"1 bit = 4 bytes"},{"key":"D","text":"1 byte = 4 bits"}]'::jsonb,
'B','1 byte = 8 bits','A byte consists of 8 bits. This is the fundamental unit relationship in digital storage.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-19','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','19',
'What was the name of the first supercomputer developed by C-DAC, Pune?',
'[{"key":"A","text":"Param 8000"},{"key":"B","text":"Mihir 2000"},{"key":"C","text":"Virgo 8000"},{"key":"D","text":"SAGA-220"}]'::jsonb,
'A','Param 8000','PARAM 8000 was India''s first supercomputer, developed by C-DAC (Centre for Development of Advanced Computing), Pune in 1991.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-20','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','20',
'Which of the following is a product of Meta Platforms Inc.?',
'[{"key":"A","text":"Instagram"},{"key":"B","text":"Azure"},{"key":"C","text":"Skype"},{"key":"D","text":"Github"}]'::jsonb,
'A','Instagram','Meta Platforms Inc. owns Instagram, Facebook, and WhatsApp. Azure is Microsoft, Skype is Microsoft, and GitHub is Microsoft.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-21','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','21',
'Which of the following is NOT an e-commerce website?',
'[{"key":"A","text":"AJIO"},{"key":"B","text":"Amazon"},{"key":"C","text":"Facebook"},{"key":"D","text":"Bookmyshow"}]'::jsonb,
'C','Facebook','Facebook is a social media/networking platform, not an e-commerce website. AJIO, Amazon, and BookMyShow are e-commerce/online service platforms.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-22','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','22',
'Match the computer generations with their characteristics: (i) First  (ii) Second  (iii) Third  (iv) Fourth  (v) Fifth | 1. Microprocessors  2. Vacuum tubes  3. Transistors  4. AI / Parallel processing  5. Integrated circuits',
'[{"key":"A","text":"i-2, ii-3, iii-1, iv-4, v-5"},{"key":"B","text":"i-4, ii-5, iii-1, iv-3, v-2"},{"key":"C","text":"i-2, ii-3, iii-5, iv-1, v-4"},{"key":"D","text":"i-2, ii-1, iii-4, iv-5, v-3"}]'::jsonb,
'C','i-2, ii-3, iii-5, iv-1, v-4','1st: Vacuum tubes, 2nd: Transistors, 3rd: Integrated circuits (ICs), 4th: Microprocessors, 5th: AI and parallel processing.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-23','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','23',
'Which of the following statements about a Device Driver are correct? 1. It is a hardware device  2. It acts as a translator between hardware and OS  3. It instructs the computer how to communicate with hardware  4. Examples include printer driver',
'[{"key":"A","text":"1 and 3"},{"key":"B","text":"1, 2 and 3"},{"key":"C","text":"2, 3 and 4"},{"key":"D","text":"1, 2, 3 and 4"}]'::jsonb,
'C','2, 3 and 4','A device driver is software (not hardware), so statement 1 is incorrect. Statements 2, 3, and 4 are all correct.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-24','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','24',
'Which of the following is an example of an internal hardware device?',
'[{"key":"A","text":"Video card"},{"key":"B","text":"Touchpad"},{"key":"C","text":"Webcam"},{"key":"D","text":"Microphone"}]'::jsonb,
'A','Video card','A video card (GPU) is installed inside the computer case on the motherboard. Touchpad, webcam, and microphone are external peripheral devices.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-25','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','25',
'What is the primary feature of a Direct Memory Access (DMA) controller?',
'[{"key":"A","text":"Transfers data to main memory without CPU intervention"},{"key":"B","text":"Coordinates communication between computer and network devices"},{"key":"C","text":"Provides a graphical interface for users"},{"key":"D","text":"Manages the CPU''s clock speed"}]'::jsonb,
'A','Transfers data to main memory without CPU intervention','DMA allows peripherals to directly access main memory without involving the CPU for each transfer, significantly improving system performance.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-26','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','26',
'Which of the following is NOT a real-time operating system?',
'[{"key":"A","text":"RTLinux"},{"key":"B","text":"Palm OS"},{"key":"C","text":"QNX"},{"key":"D","text":"VxWorks"}]'::jsonb,
'B','Palm OS','Palm OS is a mobile operating system for PDAs. RTLinux, QNX, and VxWorks are dedicated real-time operating systems (RTOS).','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-27','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','27',
'Match the keyboard shortcuts: (i) Replace  (ii) Insert Hyperlink  (iii) Paste  (iv) Cut | 1. Ctrl+K  2. Ctrl+H  3. Ctrl+X  4. Ctrl+V',
'[{"key":"A","text":"i-1, ii-2, iii-3, iv-4"},{"key":"B","text":"i-4, ii-2, iii-1, iv-3"},{"key":"C","text":"i-2, ii-1, iii-4, iv-3"},{"key":"D","text":"i-3, ii-1, iii-4, iv-2"}]'::jsonb,
'C','i-2, ii-1, iii-4, iv-3','Ctrl+H = Replace, Ctrl+K = Hyperlink, Ctrl+V = Paste, Ctrl+X = Cut.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-28','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','28',
'What is the primary feature of Microsoft Access?',
'[{"key":"A","text":"Web development framework"},{"key":"B","text":"Spreadsheet application"},{"key":"C","text":"Graphic design software"},{"key":"D","text":"Database management system"}]'::jsonb,
'D','Database management system','Microsoft Access is a relational database management system (RDBMS) that allows users to create and manage databases.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-29','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','29',
'Match the PowerPoint shortcuts: (i) F5  (ii) Shift+F5  (iii) Alt+F5  (iv) Esc | 1. Start slideshow from beginning  2. Start from current slide  3. Presenter view  4. End presentation',
'[{"key":"A","text":"i-1, ii-2, iii-3, iv-4"},{"key":"B","text":"i-3, ii-2, iii-1, iv-4"},{"key":"C","text":"i-2, ii-1, iii-4, iv-3"},{"key":"D","text":"i-3, ii-1, iii-4, iv-2"}]'::jsonb,
'A','i-1, ii-2, iii-3, iv-4','F5 = Start from beginning, Shift+F5 = Start from current slide, Alt+F5 = Presenter view, Esc = End/exit presentation.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-30','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','30',
'Which of the following statements about the Slide Master in PowerPoint is NOT true?',
'[{"key":"A","text":"Changes to slide master affect all slides"},{"key":"B","text":"You can create multiple slide masters"},{"key":"C","text":"You cannot modify font and background in slide master"},{"key":"D","text":"You can create custom layouts using slide master"}]'::jsonb,
'C','You cannot modify font and background in slide master','In Slide Master view, you CAN modify fonts, backgrounds, colors, and layouts — that is in fact its primary purpose.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-31','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','31',
'Which of the following statements about email protocols is NOT true?',
'[{"key":"A","text":"POP3 enables access to email directly on the server without downloading"},{"key":"B","text":"IMAP allows users to access and manage emails on multiple devices"},{"key":"C","text":"SMTP is used for sending outgoing email"},{"key":"D","text":"Email clients use SSL/TLS for encryption"}]'::jsonb,
'A','POP3 enables access to email directly on the server without downloading','POP3 downloads emails from the server to the local device and typically deletes them from the server. It is IMAP that allows access on the server without downloading.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-32','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','32',
'[Passage: An Indian friend of the author had returned from a Continental (European) holiday. He was plunged in despair despite having had a wonderful time, while the author, in whom "the Englishman came out strong", told him to buck up.] Why was the Indian friend plunged in despair?',
'[{"key":"A","text":"He spent a lot of money"},{"key":"B","text":"He felt he would never be so happy again"},{"key":"C","text":"He was hopeless about life"},{"key":"D","text":"He experienced racial discrimination"}]'::jsonb,
'B','He felt he would never be so happy again','The Indian friend was despairing because the holiday had been so perfect that he feared he could never replicate that happiness.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-33','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','33',
'[Passage: An Indian friend and an English author contrast their emotional responses after a Continental holiday.] What is the author''s primary intention in writing the passage?',
'[{"key":"A","text":"To praise the Englishman''s character"},{"key":"B","text":"To ridicule Indian traditions"},{"key":"C","text":"To contrast Indian and English character"},{"key":"D","text":"To show the Indian is sorrowful by nature"}]'::jsonb,
'C','To contrast Indian and English character','The passage uses the two characters'' contrasting reactions to the same holiday experience to highlight differences in Indian and English emotional temperament.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-34','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','34',
'[Passage: An Indian friend goes on a Continental holiday.] What does the word "Continent" refer to in the context of the passage?',
'[{"key":"A","text":"Europe"},{"key":"B","text":"Africa"},{"key":"C","text":"South America"},{"key":"D","text":"Russia"}]'::jsonb,
'A','Europe','In British English usage, "the Continent" traditionally refers to mainland Europe, as opposed to the British Isles.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-35','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','35',
'[Passage: The author says "in me the Englishman came out strong" when responding to his Indian friend''s despair after a holiday.] What does "in me the Englishman came out strong" imply?',
'[{"key":"A","text":"He started following Indian traditions"},{"key":"B","text":"The Englishman went out of him"},{"key":"C","text":"He was a physically strong Englishman"},{"key":"D","text":"He displayed typical English character and restraint"}]'::jsonb,
'D','He displayed typical English character and restraint','The phrase implies the author exhibited the stereotypical English trait of emotional restraint and practicality rather than sharing in his friend''s despair.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-36','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','English','36',
'[Passage: The English author told his despairing Indian friend to "buck up".] What does the phrase "buck up" mean in the passage?',
'[{"key":"A","text":"Shut up"},{"key":"B","text":"Cheer up"},{"key":"C","text":"Buckle yourself up"},{"key":"D","text":"Stand up"}]'::jsonb,
'B','Cheer up','"Buck up" is an informal expression meaning to become more cheerful or to make an effort to improve one''s mood.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-37','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','General Knowledge','37',
'Which was Gandhiji''s first successful Satyagraha after returning from South Africa?',
'[{"key":"A","text":"Chauri Chaura"},{"key":"B","text":"Champaran"},{"key":"C","text":"Bardoli"},{"key":"D","text":"Dandi"}]'::jsonb,
'B','Champaran','The Champaran Satyagraha (1917) in Bihar was Gandhi''s first major civil disobedience movement in India, fighting for the rights of indigo farmers.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-38','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','General Knowledge','38',
'Which of the following statements about Indian tribes is correct?',
'[{"key":"A","text":"Tharu tribes are found only in Uttarakhand"},{"key":"B","text":"Irula, Chenchu, Sumali are found in Kerala"},{"key":"C","text":"Garasia tribes are found in Goa"},{"key":"D","text":"Gaddi tribes are found in J&K and Himachal Pradesh"}]'::jsonb,
'D','Gaddi tribes are found in J&K and Himachal Pradesh','The Gaddi are a pastoral tribe found in the Chamba and Kangra valleys of Himachal Pradesh and parts of Jammu & Kashmir.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-39','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','39',
'Where is the Salal Hydroelectric Project located?',
'[{"key":"A","text":"Punjab"},{"key":"B","text":"Jammu and Kashmir"},{"key":"C","text":"Himachal Pradesh"},{"key":"D","text":"Uttarakhand"}]'::jsonb,
'B','Jammu and Kashmir','The Salal Hydroelectric Project is located on the Chenab River in the Reasi district of Jammu & Kashmir.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-40','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','40',
'Where is the Kiru Hydroelectric Power Project located?',
'[{"key":"A","text":"Arunachal Pradesh"},{"key":"B","text":"Chhattisgarh"},{"key":"C","text":"Jammu and Kashmir"},{"key":"D","text":"Andhra Pradesh"}]'::jsonb,
'C','Jammu and Kashmir','The Kiru Hydroelectric Power Project (624 MW) is located on the Chenab River in Kishtwar district, Jammu & Kashmir.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-41','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','General Knowledge','41',
'Which of the following states does NOT share a border with Myanmar?',
'[{"key":"A","text":"Nagaland"},{"key":"B","text":"Arunachal Pradesh"},{"key":"C","text":"Mizoram"},{"key":"D","text":"Assam"}]'::jsonb,
'D','Assam','India shares its border with Myanmar through Arunachal Pradesh, Nagaland, Manipur, and Mizoram. Assam does not share a border with Myanmar.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-42','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','General Knowledge','42',
'What is the name of the coast along Tamil Nadu and Andhra Pradesh?',
'[{"key":"A","text":"Northern Circar"},{"key":"B","text":"Malabar"},{"key":"C","text":"Konkan"},{"key":"D","text":"Coromandel"}]'::jsonb,
'D','Coromandel','The Coromandel Coast runs along the southeastern coast of India, covering Tamil Nadu and southern Andhra Pradesh, facing the Bay of Bengal.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-43','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','General Knowledge','43',
'Which Indian state shares borders with three countries — Nepal, Bhutan, and China?',
'[{"key":"A","text":"Meghalaya"},{"key":"B","text":"Mizoram"},{"key":"C","text":"Sikkim"},{"key":"D","text":"Assam"}]'::jsonb,
'C','Sikkim','Sikkim borders Nepal to the west, China (Tibet) to the north and east, and Bhutan to the east, making it the only Indian state bordering all three countries.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-44','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','44',
'Which of the following lakes is located in Jammu and Kashmir?',
'[{"key":"A","text":"Phulhar Lake"},{"key":"B","text":"Kolleru Lake"},{"key":"C","text":"Anchar Lake"},{"key":"D","text":"Hamirsar Lake"}]'::jsonb,
'C','Anchar Lake','Anchar Lake is a freshwater lake near Sopore in Baramulla district, Jammu & Kashmir. Kolleru is in Andhra Pradesh; Hamirsar is in Gujarat; Phulhar is in Uttar Pradesh.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-45','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','45',
'The Zojila Pass connects which two places?',
'[{"key":"A","text":"Leh and Kargil"},{"key":"B","text":"Leh and Srinagar"},{"key":"C","text":"Kashmir and Tibet"},{"key":"D","text":"Nepal and Tibet"}]'::jsonb,
'B','Leh and Srinagar','Zojila Pass (altitude ~3,528 m) on NH1 connects Srinagar in the Kashmir Valley with Leh in Ladakh.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-46','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','General Knowledge','46',
'Which Indian state has the longest coastline?',
'[{"key":"A","text":"Gujarat"},{"key":"B","text":"Maharashtra"},{"key":"C","text":"Tamil Nadu"},{"key":"D","text":"Odisha"}]'::jsonb,
'A','Gujarat','Gujarat has the longest coastline of ~1,600 km among all Indian states, including the Kathiawar peninsula and the Gulf of Kutch.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-47','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','47',
'Where is Indira Col, the northernmost point of India, located?',
'[{"key":"A","text":"Jammu and Kashmir"},{"key":"B","text":"Ladakh"},{"key":"C","text":"Himachal Pradesh"},{"key":"D","text":"Arunachal Pradesh"}]'::jsonb,
'B','Ladakh','Indira Col (Indira Pass) is located in the Siachen Glacier region in Ladakh, at approximately 5,764 m altitude, and is India''s northernmost point.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-48','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','48',
'The Kashida embroidery is famous in which state/UT?',
'[{"key":"A","text":"Punjab"},{"key":"B","text":"West Bengal"},{"key":"C","text":"Jammu and Kashmir"},{"key":"D","text":"Rajasthan"}]'::jsonb,
'C','Jammu and Kashmir','Kashida is a traditional form of embroidery originating from Kashmir, known for its intricate floral and paisley patterns on shawls and garments.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-49','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','49',
'Which of the following is NOT a folk dance of Jammu and Kashmir?',
'[{"key":"A","text":"Dhumal"},{"key":"B","text":"Hafiza"},{"key":"C","text":"Rouf"},{"key":"D","text":"Dangi"}]'::jsonb,
'D','Dangi','Dangi is a folk dance from Gujarat/Rajasthan. Dhumal, Hafiza, and Rouf are traditional folk dances of Jammu and Kashmir.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-50','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','50',
'Which of the following is NOT a principal language of Jammu and Kashmir?',
'[{"key":"A","text":"Urdu"},{"key":"B","text":"Gojari"},{"key":"C","text":"Koshur"},{"key":"D","text":"Monpa"}]'::jsonb,
'D','Monpa','Monpa is a language spoken in Arunachal Pradesh. Urdu (official), Gojari, and Koshur (Kashmiri) are principal languages of Jammu & Kashmir.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-51','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','51',
'Which is the deepest lake in Jammu and Kashmir?',
'[{"key":"A","text":"Wular Lake"},{"key":"B","text":"Nigeen Lake"},{"key":"C","text":"Mansar Lake"},{"key":"D","text":"Manasbal Lake"}]'::jsonb,
'D','Manasbal Lake','Manasbal Lake, located in Ganderbal district, is considered the deepest lake in Jammu and Kashmir with a depth of about 13 metres.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-52','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','52',
'On which date did Jammu and Kashmir officially become a Union Territory?',
'[{"key":"A","text":"31-08-2019"},{"key":"B","text":"31-10-2019"},{"key":"C","text":"31-12-2019"},{"key":"D","text":"31-07-2019"}]'::jsonb,
'B','31-10-2019','Following the Jammu and Kashmir Reorganisation Act, 2019, J&K was bifurcated into two UTs — Jammu & Kashmir and Ladakh — on 31 October 2019.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-53','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','53',
'Which is the coldest inhabited place in India?',
'[{"key":"A","text":"Reasi"},{"key":"B","text":"Drass"},{"key":"C","text":"Anantnag"},{"key":"D","text":"Gulmarg"}]'::jsonb,
'B','Drass','Drass in Kargil district, Ladakh, is the coldest inhabited place in India and the second coldest inhabited place in the world, with temperatures dropping to -45°C.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-54','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','54',
'Which is India''s longest road tunnel?',
'[{"key":"A","text":"Shyama Prasad Mukherjee Tunnel"},{"key":"B","text":"Atal Tunnel"},{"key":"C","text":"Kuthiran Tunnel"},{"key":"D","text":"Banihal Qazigund Road Tunnel"}]'::jsonb,
'A','Shyama Prasad Mukherjee Tunnel','The Shyama Prasad Mukherjee Tunnel (formerly Banihal-Qazigund Tunnel), at about 11.2 km, is one of India''s longest road tunnels connecting Banihal in Jammu to Qazigund in Kashmir.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-55','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','55',
'Which town in Jammu and Kashmir is known as the "Apple Town"?',
'[{"key":"A","text":"Sopore"},{"key":"B","text":"Shopian"},{"key":"C","text":"Jammu"},{"key":"D","text":"Pahalgam"}]'::jsonb,
'A','Sopore','Sopore in Baramulla district is known as the "Apple Town of Asia" due to its vast apple orchards and being the largest apple market in Asia after Shimla.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-56','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','J&K GK','56',
'Which Mughal ruler gave Kashmir the title "Paradise of Earth"?',
'[{"key":"A","text":"Jahangir"},{"key":"B","text":"Aurangzeb"},{"key":"C","text":"Ashoka"},{"key":"D","text":"Shah Jahan"}]'::jsonb,
'A','Jahangir','Emperor Jahangir was so enchanted by Kashmir''s beauty that he famously said: "If there is a paradise on earth, it is this, it is this, it is this."','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-57','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Mathematics','57',
'All natural numbers and zero together are called:',
'[{"key":"A","text":"Rational numbers"},{"key":"B","text":"Integers"},{"key":"C","text":"Whole numbers"},{"key":"D","text":"Prime numbers"}]'::jsonb,
'C','Whole numbers','Whole numbers = {0, 1, 2, 3, ...}. They include all natural numbers (1, 2, 3, ...) and zero.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-58','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Mathematics','58',
'P and Q are positive integers where P × Q = 64. Which of the following CANNOT be the value of P + Q?',
'[{"key":"A","text":"16"},{"key":"B","text":"20"},{"key":"C","text":"35"},{"key":"D","text":"65"}]'::jsonb,
'C','35','Factor pairs of 64: (1,64)→65, (2,32)→34, (4,16)→20, (8,8)→16, (32,2)→34. No pair sums to 35.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-59','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Mathematics','59',
'In a class, 40% of students play football, 50% play cricket, and 18% play neither. What percentage of students play both football and cricket?',
'[{"key":"A","text":"8%"},{"key":"B","text":"12%"},{"key":"C","text":"16%"},{"key":"D","text":"28%"}]'::jsonb,
'A','8%','Using the formula: n(F∪C) = n(F) + n(C) - n(F∩C). Those who play at least one sport = 100-18 = 82%. So 82 = 40+50-n(both), n(both) = 90-82 = 8%.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-60','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Mathematics','60',
'What is 20% of 25% of 300?',
'[{"key":"A","text":"45"},{"key":"B","text":"15"},{"key":"C","text":"55"},{"key":"D","text":"90"}]'::jsonb,
'B','15','25% of 300 = 75. 20% of 75 = 15.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-61','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Mathematics','61',
'The average of 12 numbers — 3, 11, 7, 9, 15, 13, 8, 19, 17, 21, 14, x — is 12. Find x.',
'[{"key":"A","text":"17"},{"key":"B","text":"15"},{"key":"C","text":"27"},{"key":"D","text":"7"}]'::jsonb,
'D','7','Sum of 12 numbers = 12 × 12 = 144. Sum of known 11 numbers = 3+11+7+9+15+13+8+19+17+21+14 = 137. So x = 144-137 = 7.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-62','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Mathematics','62',
'The average of 100 observations is 35. One observation was misread as 83 instead of 53. What is the correct average?',
'[{"key":"A","text":"35.7"},{"key":"B","text":"36.8"},{"key":"C","text":"35.4"},{"key":"D","text":"34.7"}]'::jsonb,
'D','34.7','Total sum = 100×35 = 3500. Correct sum = 3500 - 83 + 53 = 3470. Correct average = 3470/100 = 34.7.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-63','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Mathematics','63',
'A class of 10 students: 6 students weigh 50 kg, 2 students weigh 51 kg, and 2 students weigh 55 kg. What is the average weight?',
'[{"key":"A","text":"54.1 kg"},{"key":"B","text":"51.2 kg"},{"key":"C","text":"49.3 kg"},{"key":"D","text":"56.4 kg"}]'::jsonb,
'B','51.2 kg','Total = (6×50)+(2×51)+(2×55) = 300+102+110 = 512. Average = 512/10 = 51.2 kg.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-64','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Mathematics','64',
'A radio costs Rs. 600. A 5% transportation charge is added. If the seller wants 15% net profit on total cost, what is the selling price?',
'[{"key":"A","text":"Rs. 724.50"},{"key":"B","text":"Rs. 748.50"},{"key":"C","text":"Rs. 772.50"},{"key":"D","text":"Rs. 796.50"}]'::jsonb,
'A','Rs. 724.50','Transport cost = 5% of 600 = 30. Total cost = 630. Selling price = 630 × 1.15 = Rs. 724.50.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-65','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Mathematics','65',
'Selling an article for Rs. 960 incurs a 4% loss. What is the cost price?',
'[{"key":"A","text":"Rs. 498"},{"key":"B","text":"Rs. 1920"},{"key":"C","text":"Rs. 1000"},{"key":"D","text":"Rs. 1440"}]'::jsonb,
'C','Rs. 1000','SP = CP × (1 - 4/100). 960 = CP × 0.96. CP = 960/0.96 = Rs. 1000.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-66','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Mathematics','66',
'A car is sold for Rs. 64,000 at a 20% loss. What was the cost price?',
'[{"key":"A","text":"Rs. 80,000"},{"key":"B","text":"Rs. 72,000"},{"key":"C","text":"Rs. 1,08,000"},{"key":"D","text":"Rs. 96,000"}]'::jsonb,
'A','Rs. 80,000','SP = CP × (1 - 20/100). 64000 = CP × 0.80. CP = 64000/0.80 = Rs. 80,000.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-67','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Reasoning','67',
'A man goes 5 km East, then turns right and goes 4 km, then turns left and goes 5 km. Which direction is he now facing?',
'[{"key":"A","text":"North"},{"key":"B","text":"East"},{"key":"C","text":"West"},{"key":"D","text":"South"}]'::jsonb,
'B','East','Start facing East → go 5 km East → turn right (now facing South) → go 4 km South → turn left (now facing East) → go 5 km East. Final direction: East.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-68','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Reasoning','68',
'D is to the West of M, R is to the South of D, and K is to the East of R. In which direction is K with respect to D?',
'[{"key":"A","text":"North-East"},{"key":"B","text":"North-West"},{"key":"C","text":"South-West"},{"key":"D","text":"South-East"}]'::jsonb,
'D','South-East','D is the reference. R is directly south of D. K is to the east of R, which puts K south-east of D.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-69','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Reasoning','69',
'A boy starts walking South, turns left and travels some distance, then turns right and travels, then turns left again. What direction is he now facing?',
'[{"key":"A","text":"North"},{"key":"B","text":"East"},{"key":"C","text":"West"},{"key":"D","text":"South-East"}]'::jsonb,
'B','East','South → turn left (now East) → turn right (now South) → turn left (now East). Final direction: East.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-70','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Reasoning','70',
'In a code language, "CLOCK" is written as "XOLXP". How will "LOTUS" be written in the same code?',
'[{"key":"A","text":"OLGFH"},{"key":"B","text":"LOGFH"},{"key":"C","text":"OLGHF"},{"key":"D","text":"OGLFH"}]'::jsonb,
'A','OLGFH','Each letter maps to its reverse alphabet counterpart (A↔Z, B↔Y, ...). L(12)→O(15), O(15)→L(12), T(20)→G(7), U(21)→F(6), S(19)→H(8). LOTUS → OLGFH.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-71','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Reasoning','71',
'In a code, "NEETA" is written as "MVVGZ". What name is coded as "IZHSNR"?',
'[{"key":"A","text":"RASHMI"},{"key":"B","text":"VANDANA"},{"key":"C","text":"KAJAL"},{"key":"D","text":"SHEELA"}]'::jsonb,
'A','RASHMI','Using the same reverse alphabet code (A↔Z, B↔Y...): I→R, Z→A, H→S, S→H, N→M, R→I. IZHSNR → RASHMI.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-72','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Reasoning','72',
'Rajesh, pointing to a woman, says: "The only daughter of her grandfather is my wife." What is Rajesh''s relation to the woman?',
'[{"key":"A","text":"Father"},{"key":"B","text":"Brother"},{"key":"C","text":"Uncle"},{"key":"D","text":"Nephew"}]'::jsonb,
'A','Father','The only daughter of the woman''s grandfather = woman''s mother. Rajesh''s wife = woman''s mother. Therefore Rajesh is the woman''s father.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-73','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Reasoning','73',
'Nikhil, pointing to Sita, says: "I am the only son of her mother''s son." What is Sita''s relation to Nikhil?',
'[{"key":"A","text":"Aunt"},{"key":"B","text":"Niece"},{"key":"C","text":"Grandmother"},{"key":"D","text":"Mother"}]'::jsonb,
'A','Aunt','Her mother''s son = Sita''s brother. Nikhil is the only son of Sita''s brother. Therefore, Sita is Nikhil''s aunt (father''s sister).','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-74','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Reasoning','74',
'A woman says about a man: "He is the only son of my mother''s mother." What is the woman''s relation to the man?',
'[{"key":"A","text":"Aunt"},{"key":"B","text":"Niece"},{"key":"C","text":"Grandmother"},{"key":"D","text":"Mother"}]'::jsonb,
'B','Niece','My mother''s mother = woman''s maternal grandmother. The man is the only son of that grandmother. The woman''s mother is the man''s sister. Therefore the woman is the man''s niece.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-75','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','75',
'IC (Integrated Circuit) chips used in computers are made of which material?',
'[{"key":"A","text":"Silicon"},{"key":"B","text":"Platinum"},{"key":"C","text":"Nickel"},{"key":"D","text":"None of the above"}]'::jsonb,
'A','Silicon','Integrated circuits are fabricated on silicon wafers. Silicon is a semiconductor with properties ideal for IC fabrication.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-76','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','76',
'Which email folder retains copies of messages that have been started but are not ready to send?',
'[{"key":"A","text":"Outbox"},{"key":"B","text":"Inbox"},{"key":"C","text":"Drafts"},{"key":"D","text":"Sent"}]'::jsonb,
'C','Drafts','The Drafts folder stores emails that are being composed but have not yet been sent. Outbox holds emails queued for sending.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-77','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','77',
'Which programming language is used to write macros in Microsoft Excel?',
'[{"key":"A","text":"VB Script"},{"key":"B","text":"Python"},{"key":"C","text":"C++"},{"key":"D","text":"JAVA"}]'::jsonb,
'A','VB Script','Microsoft Excel macros are written in Visual Basic for Applications (VBA), a dialect of Visual Basic Script.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-78','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','78',
'What does the =COUNTIF() function do in MS Excel?',
'[{"key":"A","text":"Counts cells that meet a specified criterion"},{"key":"B","text":"Counts blank cells only"},{"key":"C","text":"Returns a value based on TRUE/FALSE condition"},{"key":"D","text":"Counts only cells containing numbers"}]'::jsonb,
'A','Counts cells that meet a specified criterion','COUNTIF(range, criteria) counts the number of cells in a range that meet a given criterion, such as a specific value or text.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-79','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','79',
'What is a computer firewall?',
'[{"key":"A","text":"Software that enhances computer speed"},{"key":"B","text":"Software that protects from crash due to bugs"},{"key":"C","text":"A system that protects against threats and secures internet network access"},{"key":"D","text":"All of the above"}]'::jsonb,
'C','A system that protects against threats and secures internet network access','A firewall monitors and controls incoming and outgoing network traffic based on security rules, protecting the system from unauthorized access and cyber threats.','{}',CURRENT_TIMESTAMP),

('jkssb-junior-assistant-pyq-80','jkssb','jkssb-junior-assistant-pyq','JKSSB','','JKSSB Junior Assistant PYQ','Computer Awareness','80',
'What is a pre-designed document that includes predefined fonts, layout, and background called?',
'[{"key":"A","text":"Model"},{"key":"B","text":"Prototype"},{"key":"C","text":"Format"},{"key":"D","text":"Template"}]'::jsonb,
'D','Template','A template is a pre-formatted document used as a starting point for new documents, containing predefined fonts, layouts, colors, and backgrounds.','{}',CURRENT_TIMESTAMP);
