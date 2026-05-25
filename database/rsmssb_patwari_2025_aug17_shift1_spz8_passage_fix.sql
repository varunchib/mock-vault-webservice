-- Correct passage-based bilingual storage for RSMSSB Patwari 2025 SPZ8.
-- Keeps question/options in normal fields and stores shared passage separately
-- in translations.{en,hi}.passage for UI rendering.

ALTER TABLE vaultcore.questions
  ADD COLUMN IF NOT EXISTS translations JSONB NOT NULL DEFAULT '{}'::jsonb;

WITH passage AS (
  SELECT
    'हमारे देश के जल संसाधनों का पूर्ण रूप से उपयोग नहीं हो पा रहा है। इस अपर्याप्त उपयोग का मुख्य कारण पूँजी और तकनीकी की कमी है। हमारे जल संसाधनों का एक बड़ा हिस्सा बाढ़ और सिंचाई तथा घरेलू कार्यों में जल के अनुचित उपयोग के कारण व्यर्थ चला जाता है। हम नदियों पर बाँध बनाकर और लोगों में जल अपव्यय न करने के प्रति जागरूकता फैलाने की नीति अपनाकर जल संसाधनों का पूर्ण उपयोग कर सकते हैं। इसके अतिरिक्त, वर्षा जल संचयन प्रणाली के प्रभावी क्रियान्वयन से भी जल संसाधनों में वृद्धि हो सकती है।'::text AS hi_passage,
    'The water resources of our country are very much underutilized. The main reason of this underutilization is the lack of capital and technology. A large portion of our water resources is wasted due to floods and unwise use of water for irrigation as well as domestic purposes. We can make full use of water resources by building dams on rivers and by adopting policies of spreading awareness among people not to waste water. In addition, effective implementation of rainwater harvesting system adds to water resources.'::text AS en_passage
),
q AS (
  SELECT *
  FROM (VALUES
    (1, 'देश के पास जल संसाधन विकसित करने के लिए पर्याप्त धनराशि नहीं है।', 'The country does not have enough funds to develop water resources.', '["निश्चित गलत","संभावित सही","संभावित गलत","निश्चित सही"]'::jsonb, '["Definitely false","Probably true","Probably false","Definitely true"]'::jsonb),
    (2, 'बाढ़ आने से जल संसाधनों में वृद्धि होती है।', 'Occurrence of floods adds to the water resources.', '["निश्चित गलत","संभावित सही","संभावित गलत","निश्चित सही"]'::jsonb, '["Definitely false","Probably true","Probably false","Definitely true"]'::jsonb),
    (3, 'वर्षा जल संग्रहण की जल संसाधन वृद्धि में कोई भूमिका नहीं है।', 'Rainwater harvesting plays no role in increasing water resources.', '["संभावित सही","संभावित गलत","निश्चित गलत","निश्चित सही"]'::jsonb, '["Probably true","Probably false","Definitely false","Definitely true"]'::jsonb)
  ) AS v(question_no, hi_question, en_question, hi_options, en_options)
)
UPDATE vaultcore.questions target
SET
  question = q.en_question,
  options = (
    SELECT jsonb_agg(jsonb_build_object('key', chr(64 + ordinality::int), 'text', value))
    FROM jsonb_array_elements_text(q.en_options) WITH ORDINALITY
  ),
  translations = jsonb_build_object(
    'en', jsonb_build_object('passage', passage.en_passage, 'question', q.en_question, 'options', q.en_options),
    'hi', jsonb_build_object('passage', passage.hi_passage, 'question', q.hi_question, 'options', q.hi_options)
  ),
  updated_at = CURRENT_TIMESTAMP
FROM q, passage
WHERE target.slug = 'rsmssb-patwari-2025-aug17-s1-spz8-q' || q.question_no;

WITH passage AS (
  SELECT 'Did you know that the world''s first official airmail delivery took place in India in 1911, only 8 years after the invention of airplanes?

On February 18, 1911, French pilot Henri Pequet carried the first official mail flown by airplane. Pequet carried a sack with about 6,000 cards and letters on his Humber biplane. The flight covered a distance of five miles, from Allahabad polo field to Naini across the Yamuna river. All mails received a special parcel depicting an airplane, mountains, and "First Aerial Post, 1911, U.P. Exhibition Allahabad" written on it.

On October 1, 2024, India Post celebrated 170 years of service. Originally started by the British East India Company and known as Company Mail, India Post was brought under the Crown as a service in 1854 by Lord Dalhousie, the Governor-General of India from 1848 to 1856. However, the history of postal systems in India goes back to the Maurya period, particularly the reign of Chandragupta Maurya circa 300 BCE.

Some historians believe that Chandragupta introduced an early postal system in India, using carrier pigeons to communicate between the different provinces of his vast empire stretching from Karnataka in the South to Afghanistan in the North, and Nagaland in the East to Eastern Iran in the West. This early postal system was most probably introduced to India by Alexander III of Macedon, who used it widely during his military campaigns after adopting it from the ancient Persians, who trained and used carrier pigeons as messengers as early as the 5th Century BCE. Carrier pigeons remained the primary mode of long-distance communication in India over the next thousand years. They were used extensively by rulers from the Maurya emperor Ashoka (302-234 BCE) to the Mughal emperor Babur (1483-1530 CE).'::text AS en_passage
),
q AS (
  SELECT *
  FROM (VALUES
    (121, 'Four statements about the world''s first official airmail delivery are given below. Choose the incorrect option.', '["The flight travelled from Allahabad polo field to Naini.","The plane carried 6,000 cards and letters.","The flight covered a distance of eight miles.","Pilot Henri Pequet carried the mail by airplane."]'::jsonb),
    (122, 'Which of the following statements is NOT true about the reign of Chandragupta Maurya?', '["He is said to have introduced an early postal system in India.","His empire stretched to Eastern Iran in the West.","His empire stretched from Sikkim in Eastern India to Iraq in the west.","His empire stretched from Karnataka in the South to Afghanistan in the North."]'::jsonb),
    (123, 'From whom did Alexander III of Macedon adopt the system of using carrier pigeons as messengers?', '["Ancient Egyptians","Aristotle","Maurya Emperor Ashoka","Ancient Persians"]'::jsonb),
    (124, 'What was India Post known as earlier?', '["The Crown Mail","Company Mail","Humber Biplane Mail","East India Company Postal Service"]'::jsonb),
    (125, 'How many years has India Post been in service for?', '["170 years","Since 1 Oct, 2024","150 years","Since 1921"]'::jsonb)
  ) AS v(question_no, en_question, en_options)
)
UPDATE vaultcore.questions target
SET
  question = q.en_question,
  options = (
    SELECT jsonb_agg(jsonb_build_object('key', chr(64 + ordinality::int), 'text', value))
    FROM jsonb_array_elements_text(q.en_options) WITH ORDINALITY
  ),
  translations = jsonb_build_object(
    'en', jsonb_build_object('passage', passage.en_passage, 'question', q.en_question, 'options', q.en_options)
  ),
  updated_at = CURRENT_TIMESTAMP
FROM q, passage
WHERE target.slug = 'rsmssb-patwari-2025-aug17-s1-spz8-q' || q.question_no;
