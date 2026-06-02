-- Q86: fix answer D -> B (parallel structure error in part 2)
UPDATE vaultcore.questions SET
  answer_key  = 'B',
  answer      = '(2)',
  explanation = 'The error is in part (2) due to a violation of parallel structure. The sentence uses the correlative construction "is not [A] but [B]". Part (1) has a noun phrase [A]: "its proposed realignment of fiscal powers per se". Part (2) has a noun clause [B]: "that it presumes" -- which does not match. Both should be noun phrases. Correct: "but its presumption, without empirical substantiation, of a fiscal equivalence among states whose developmental baselines are incommensurable by any normative metric."'
WHERE paper_slug = 'ssc-cgl-2025-sep12-shift1' AND question_no = '86';

-- Q88: already correct (A), just update explanation with official reasoning
UPDATE vaultcore.questions SET
  explanation = '"Introit" in the original sentence refers to a liturgical psalm sung during a religious ceremony (priest approaching the altar). In option A, "introit" is used in a secular/non-liturgical context -- a child singing during an intermission (a theatrical break) -- shifting its meaning to a general introductory musical piece. This contextual shift in meaning makes it a homonym. Options B, C, D all retain the strict liturgical meaning of the word.'
WHERE paper_slug = 'ssc-cgl-2025-sep12-shift1' AND question_no = '88';
