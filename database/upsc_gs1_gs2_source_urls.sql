-- Set official UPSC PDF download URLs for GS1 and GS2 papers
UPDATE vaultcore.papers
SET source_url = 'https://upsc.gov.in/sites/default/files/QP-CSP-25-GENERAL-STUDIES-PAPER-I-26052025.pdf'
WHERE slug = 'upsc-cse-prelims-2025-gs1';

UPDATE vaultcore.papers
SET source_url = 'https://upsc.gov.in/sites/default/files/QP-CSP-25-GENERAL-STUDIES-PAPER-II-26052025.pdf'
WHERE slug = 'upsc-cse-prelims-2025-gs2';
