-- Q51: fractions in ascending order
UPDATE vaultcore.questions SET
  question    = 'Arrange the fractions $\frac{5}{9}$, $\frac{4}{7}$, $\frac{3}{5}$, and $\frac{2}{3}$ in ascending order.',
  options     = '[{"key":"A","text":"$\\frac{3}{5},\\ \\frac{4}{7},\\ \\frac{2}{3},\\ \\frac{5}{9}$"},{"key":"B","text":"$\\frac{5}{9},\\ \\frac{4}{7},\\ \\frac{3}{5},\\ \\frac{2}{3}$"},{"key":"C","text":"$\\frac{2}{3},\\ \\frac{3}{5},\\ \\frac{4}{7},\\ \\frac{5}{9}$"},{"key":"D","text":"$\\frac{4}{7},\\ \\frac{5}{9},\\ \\frac{2}{3},\\ \\frac{3}{5}$"}]',
  answer      = '$\frac{5}{9},\ \frac{4}{7},\ \frac{3}{5},\ \frac{2}{3}$',
  explanation = 'Convert to decimals: 5/9 ≈ 0.556, 4/7 ≈ 0.571, 3/5 = 0.600, 2/3 ≈ 0.667. Ascending order: $\frac{5}{9} < \frac{4}{7} < \frac{3}{5} < \frac{2}{3}$.'
WHERE paper_slug = 'ssc-cgl-2025-sep12-shift1' AND question_no = '51';

-- Q52: mixed number simplification
UPDATE vaultcore.questions SET
  question    = 'Simplify: $\left(2\dfrac{1}{2} + 3.6\right) - 1.9$',
  explanation = '$2\frac{1}{2} = 2.5$. So $(2.5 + 3.6) - 1.9 = 6.1 - 1.9 = 4.2$.'
WHERE paper_slug = 'ssc-cgl-2025-sep12-shift1' AND question_no = '52';

-- Q53: complex nested fraction expression
UPDATE vaultcore.questions SET
  question    = 'Evaluate: $7\dfrac{1}{4} - \left[\dfrac{5}{6} \div \left\{\dfrac{1}{3} - \left(\dfrac{1}{2} \times \left(\dfrac{3}{4} - \dfrac{1}{4}\right)\right)\right\}\right]$',
  options     = '[{"key":"A","text":"$-3\\dfrac{1}{4}$"},{"key":"B","text":"$3\\dfrac{1}{4}$"},{"key":"C","text":"$-2\\dfrac{3}{4}$"},{"key":"D","text":"$2\\dfrac{3}{4}$"}]',
  answer      = '$-2\dfrac{3}{4}$',
  explanation = 'Step 1: $\frac{3}{4} - \frac{1}{4} = \frac{1}{2}$. Step 2: $\frac{1}{2} \times \frac{1}{2} = \frac{1}{4}$. Step 3: $\frac{1}{3} - \frac{1}{4} = \frac{4-3}{12} = \frac{1}{12}$. Step 4: $\frac{5}{6} \div \frac{1}{12} = \frac{5}{6} \times 12 = 10$. Step 5: $7\frac{1}{4} - 10 = \frac{29}{4} - 10 = \frac{29-40}{4} = -\frac{11}{4} = -2\frac{3}{4}$.'
WHERE paper_slug = 'ssc-cgl-2025-sep12-shift1' AND question_no = '53';
