-- Leave diagram-based options blank until image assets are added.

WITH diagram_questions AS (
  SELECT *
  FROM (VALUES
    (145, 'दिए गए आकृति आव्यूह को पूरा करने वाली आकृति चुनें।', 'Select the figure that would complete the given figure matrix.'),
    (146, 'नीचे दिए गए आव्यूह को पूरा करने वाली आकृति चुनें।', 'Select the figure that would complete the following matrix.')
  ) AS v(question_no, hi_question, en_question)
)
UPDATE vaultcore.questions target
SET
  question = diagram_questions.en_question,
  options = '[{"key":"A","text":""},{"key":"B","text":""},{"key":"C","text":""},{"key":"D","text":""}]'::jsonb,
  translations = jsonb_build_object(
    'en', jsonb_build_object('question', diagram_questions.en_question, 'options', '["","","",""]'::jsonb),
    'hi', jsonb_build_object('question', diagram_questions.hi_question, 'options', '["","","",""]'::jsonb)
  ),
  tags = jsonb_build_array('RSMSSB', 'Patwari', '2025', 'Shift 1', 'SPZ8', 'Reasoning', 'diagram-pending'),
  updated_at = CURRENT_TIMESTAMP
FROM diagram_questions
WHERE target.slug = 'rsmssb-patwari-2025-aug17-s1-spz8-q' || diagram_questions.question_no;
