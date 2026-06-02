-- Fix 7 placeholder questions in the admin-created paper ssc-cgl-2025-sep12-shift1

UPDATE vaultcore.questions SET
  question    = 'According to the author, why has the gap between education and wisdom widened in recent times?',
  options     = '[{"key":"A","text":"Due to overuse of social media"},{"key":"B","text":"Because wisdom is no longer valued"},{"key":"C","text":"Because of rote learning and algorithmic methods"},{"key":"D","text":"Because people stop learning after school"}]',
  answer_key  = 'C',
  answer      = 'Because of rote learning and algorithmic methods',
  explanation = 'The passage states: "In an era dominated by information overload and algorithmic thinking, the schism between the two has widened. Educational institutions often prioritize rote memorization and standardized testing over critical thinking and moral reasoning." This directly supports option C.',
  tags        = '["Reading Comprehension"]',
  subject     = 'English Language',
  translations = '{"en":{"passage":"While education and wisdom are often conflated in colloquial discourse, a discerning mind perceives a fundamental divergence between the two. Education is the formal acquisition of knowledge, often measured through degrees, academic accolades, and proficiency in structured disciplines. It is delivered through systematic curricula, institutionalized assessment, and theoretical frameworks. However, wisdom transcends this rigidity; it is the judicious application of knowledge to real-life contexts, enriched by experience, introspection, and emotional intelligence. An individual may be extensively educated yet remain bereft of wisdom if they lack the discernment to apply their learning ethically and effectively. Conversely, many wise individuals—farmers, artisans, elders—may not possess formal education, but their decisions exhibit prudence and sagacity cultivated through lived realities. Thus, education equips the mind, but wisdom enriches the soul. In an era dominated by information overload and algorithmic thinking, the schism between the two has widened. Educational institutions often prioritize rote memorization and standardized testing over critical thinking and moral reasoning. Consequently, society produces individuals proficient in problem-solving but deficient in decision-making that requires empathy, patience, or foresight. Wisdom, being innately human, cannot be downloaded or fast-tracked; it is earned through trial, failure, reflection, and a nuanced understanding of human nature. Furthermore, while education is temporally bounded—ending with formal schooling or academic milestones—wisdom is a lifelong pursuit. It does not boast certificates but manifests in humility, ethical consistency, and the ability to navigate ambiguity with grace. Ultimately, the highest form of intelligence lies not merely in knowing what is right, but in consistently choosing to do it, especially when it is inconvenient.","question":"According to the author, why has the gap between education and wisdom widened in recent times?","options":["Due to overuse of social media","Because wisdom is no longer valued","Because of rote learning and algorithmic methods","Because people stop learning after school"]}}'
WHERE slug = 'ssc-cgl-2025-sep12-shift1-q94';

UPDATE vaultcore.questions SET
  question    = 'Choose the most suitable option to replace the highlighted part of the sentence: She has the reputation [to be a kind woman].',
  options     = '[{"key":"A","text":"to have kindness"},{"key":"B","text":"of being a kind woman"},{"key":"C","text":"of being the kind woman"},{"key":"D","text":"to be kind-hearted"}]',
  answer_key  = 'B',
  answer      = 'of being a kind woman',
  explanation = '"Reputation" is followed by "of + gerund", not "to + infinitive". The correct structure is "reputation of being...". Option C is wrong because "the kind woman" implies a specific known person. Option B is the standard collocation.',
  tags        = '["Sentence Improvement","Collocations"]',
  subject     = 'English Language'
WHERE slug = 'ssc-cgl-2025-sep12-shift1-q95';

UPDATE vaultcore.questions SET
  question    = 'Choose the most suitable option to replace the highlighted part of the sentence: The doctor advised him [to avoid eating sweets and doing exercise regularly].',
  options     = '[{"key":"A","text":"avoiding sweets and doing regular exercise"},{"key":"B","text":"to avoid sweets and to exercises regularly"},{"key":"C","text":"to avoid eating sweets and to exercise regularly"},{"key":"D","text":"to not eat sweets and do exercises"}]',
  answer_key  = 'C',
  answer      = 'to avoid eating sweets and to exercise regularly',
  explanation = '"Advised" takes "to + infinitive". The sentence needs parallel infinitive structure: "to avoid eating sweets AND to exercise regularly". Option B has a grammatical error ("to exercises"). Option C correctly uses "to avoid... and to exercise" — parallel infinitives.',
  tags        = '["Sentence Improvement","Parallelism","Infinitives"]',
  subject     = 'English Language'
WHERE slug = 'ssc-cgl-2025-sep12-shift1-q96';

UPDATE vaultcore.questions SET
  question    = 'A sentence is provided in direct speech. From the four given options, choose the one that most accurately conveys the sentence in its corresponding indirect speech. He asked me, "Have you done your homework?"',
  options     = '[{"key":"A","text":"He asked me if I had done my homework."},{"key":"B","text":"He asked me have I done my homework."},{"key":"C","text":"He asked me whether I have done my homework."},{"key":"D","text":"He asked me whether had I done my homework."}]',
  answer_key  = 'A',
  answer      = 'He asked me if I had done my homework.',
  explanation = 'In reported speech, "Have you..." (Present Perfect interrogative) becomes "if/whether I had done..." (Past Perfect). Pronoun shifts from "you" to "I". Word order becomes statement order. Option A correctly applies all these rules.',
  tags        = '["Direct and Indirect Speech","Reported Speech"]',
  subject     = 'English Language'
WHERE slug = 'ssc-cgl-2025-sep12-shift1-q97';

UPDATE vaultcore.questions SET
  question    = 'A sentence is provided in indirect speech. From the four given options, choose the one that most accurately conveys the sentence in its corresponding direct speech. He said that he would join the meeting after lunch.',
  options     = '[{"key":"A","text":"I will join the meeting after lunch, he said."},{"key":"B","text":"I would join the meeting after lunch, he said."},{"key":"C","text":"I shall join the meeting after lunch, he said."},{"key":"D","text":"I can join the meeting after lunch, he said."}]',
  answer_key  = 'A',
  answer      = 'I will join the meeting after lunch, he said.',
  explanation = 'In indirect speech "would" is the past form of "will". Converting back to direct speech: "he said that he would join..." becomes "I will join..." — restoring the original future tense. Option A correctly reverses the backshift.',
  tags        = '["Direct and Indirect Speech","Reported Speech"]',
  subject     = 'English Language'
WHERE slug = 'ssc-cgl-2025-sep12-shift1-q98';

UPDATE vaultcore.questions SET
  question    = 'Rearrange the following sentences in correct order to make a logical passage: 1. A media strategy was framed based on outreach results. 2. Demographic metrics were tracked from campaign dashboards. 3. User interactions were collected across platforms. 4. Analysts segmented users by age and behavior.',
  options     = '[{"key":"A","text":"3-2-4-1"},{"key":"B","text":"2-3-1-4"},{"key":"C","text":"3-1-4-2"},{"key":"D","text":"4-1-2-3"}]',
  answer_key  = 'A',
  answer      = '3-2-4-1',
  explanation = 'Logical sequence: Collect interactions (3) → Track demographic metrics (2) → Segment users by age/behaviour (4) → Frame media strategy based on results (1). Data collection → measurement → analysis → strategy.',
  tags        = '["Sentence Rearrangement","Paragraph Ordering"]',
  subject     = 'English Language'
WHERE slug = 'ssc-cgl-2025-sep12-shift1-q99';

UPDATE vaultcore.questions SET
  question    = 'Rearrange the following sentences to form a coherent paragraph: 1. It is a process that involves the systematic and objective investigation of a subject to discover new facts or to confirm existing ones. 2. Research is a foundational pillar of academic and scientific progress. 3. This can be either theoretical, aiming to expand knowledge, or applied, seeking to solve a practical problem. 4. The findings of this investigation are then documented and peer-reviewed to ensure validity and credibility.',
  options     = '[{"key":"A","text":"2, 1, 3, 4"},{"key":"B","text":"1, 2, 4, 3"},{"key":"C","text":"4, 3, 2, 1"},{"key":"D","text":"3, 4, 1, 2"}]',
  answer_key  = 'A',
  answer      = '2, 1, 3, 4',
  explanation = 'Logical flow: Introduce research as a foundational pillar (2) → Define it as a process of investigation (1) → Classify as theoretical or applied (3) → Describe findings documentation and peer-review (4). General → specific → classification → outcome.',
  tags        = '["Sentence Rearrangement","Paragraph Ordering"]',
  subject     = 'English Language'
WHERE slug = 'ssc-cgl-2025-sep12-shift1-q100';

-- Remove the duplicate paper created in error
DELETE FROM vaultcore.questions WHERE paper_slug = 'ssc-cgl-2025-tier1-sep12-shift1';
DELETE FROM vaultcore.papers   WHERE slug        = 'ssc-cgl-2025-tier1-sep12-shift1';
