-- JKPSC JKCCE Prelims 2025 GS Paper I (Set B) — Explanations

BEGIN;

UPDATE vaultcore.questions SET explanation = ans.explanation
FROM (VALUES

('jkpsc-jkcce-2025-pre-gs1-q1',
'CPCB prescribes ambient noise limits by area type. Silence zones (around hospitals, courts, educational institutions) have the strictest night-time limit of 40 dB, which falls in the "less than 40 dB" bracket relative to commercial (55 dB) and residential (45 dB) night limits.'),

('jkpsc-jkcce-2025-pre-gs1-q2',
'The Richter scale measures the magnitude (energy released) of an earthquake. The Modified Mercalli Intensity (MMI) scale measures the intensity of ground shaking and destruction at a specific location — it directly quantifies the amount of damage caused.'),

('jkpsc-jkcce-2025-pre-gs1-q3',
'Global Warming Potential (GWP, 100-year): CO₂ (III) = 1 (baseline) < Methane (I) ≈ 25–28 < Nitrous Oxide (IV) ≈ 265–298 < Fluorinated gases (II) = thousands to tens of thousands. Correct increasing order: III < I < IV < II.'),

('jkpsc-jkcce-2025-pre-gs1-q4',
'The Physical Quality of Life Index (PQLI), developed by Morris D. Morris, uses three indicators: (1) infant mortality rate, (2) life expectancy at age one, and (3) basic literacy rate. Income per capita/standard of living is used in HDI and similar indices, NOT in PQLI. So only I and II are components of PQLI.'),

('jkpsc-jkcce-2025-pre-gs1-q5',
'Currency depreciation does not always improve trade balance — the Marshall-Lerner condition must be satisfied, and the J-curve effect means short-run deterioration is common. Assertion (A) is therefore too absolute to be true. Reason (R) correctly defines real exchange rate. Both are true but R does not explain why A holds (or fails).'),

('jkpsc-jkcce-2025-pre-gs1-q6',
'Statement I is incorrect: the Exchange Rate Mechanism (ERM) is a European Union mechanism (formerly European Monetary System), not an IMF instrument. Statement II is correct: under a flexible exchange rate system, market forces automatically adjust the exchange rate, reducing the need for large foreign exchange reserves to finance balance-of-payments deficits.'),

('jkpsc-jkcce-2025-pre-gs1-q7',
'The Union Budget 2025-26 set a target of 100 GW of nuclear power capacity by 2047, reflecting India''s ambition to diversify its clean energy mix under the Viksit Bharat 2047 framework.'),

('jkpsc-jkcce-2025-pre-gs1-q8',
'All five government initiatives — PM SHRI (model schools), STARS (strengthening assessment systems), DIKSHA (digital learning platform), ULLAS (adult literacy through NEP), and PM POSHAN (school meals/nutrition) — are aligned with and aim to implement the objectives of NEP 2020.'),

('jkpsc-jkcce-2025-pre-gs1-q9',
'NISHTHA (teacher training), Vidya Pravesh (play-based school readiness), and DIETs (District Institutes of Education and Training for teacher education) are NEP-aligned sub-schemes under Samagra Shiksha. Rani Laxmibai Balika Vidyalaya is not an NEP 2020-aligned sub-scheme under this programme.'),

('jkpsc-jkcce-2025-pre-gs1-q10',
'As per Union Budget 2025-26 (% of GDP): Fiscal Deficit = 4.4% (iv-b), Revenue Deficit = 1.5% (iii-d), Effective Revenue Deficit = 0.3% (ii-a), Primary Deficit = 0.8% (i-c). Primary Deficit = Fiscal Deficit minus interest payments, so it is the smallest.'),

('jkpsc-jkcce-2025-pre-gs1-q11',
'ESIC e-initiatives include E-Pehchan (biometric identity cards for insured persons), E-Biz Platform (online employer registration and compliance), ABHA Number Creation (health account linking), and UPI-based payment app for insured persons. GIS-based maps are not a designated ESIC e-initiative.'),

('jkpsc-jkcce-2025-pre-gs1-q12',
'Standard pillars of health policy: preventive care (I), early detection of ailments (II), free/low-cost treatment and medicines (III), and expansion of health technology (V). "Availability of doctors in urban areas" (IV) contradicts universal access principles — the focus is on rural and underserved areas, not urban concentration.'),

('jkpsc-jkcce-2025-pre-gs1-q13',
'India''s top five trade partners by total trade value in FY 2024-25 in decreasing order: USA (II) > China (III) > UAE (I) > Russia (IV) > Saudi Arabia (V). The USA surpassed China as India''s largest trading partner in recent years.'),

('jkpsc-jkcce-2025-pre-gs1-q14',
'PM e-Bus Sewa (2023) is a centrally sponsored scheme (I ✓) targeting 10,000 electric buses with Rs. 20,000 crore central assistance (II ✓), open to cities with population 3–40 lakh per Census 2011 (III ✓). However, the scheme is valid until March 2037, not 2047 (IV ✗).'),

('jkpsc-jkcce-2025-pre-gs1-q15',
'Recovery to pre-pandemic GDP levels (constant prices): China (2020, first major economy to recover), India (2021), United Kingdom (2022), Japan (2023). Correct match: 1-India-ii(2021), 2-China-i(2020), 3-Japan-iv(2023), 4-UK-iii(2022).'),

('jkpsc-jkcce-2025-pre-gs1-q16',
'SDG numbers and names: Goal 4 = Quality Education (ii), Goal 5 = Gender Equality (i), Goal 6 = Clean Water and Sanitation (iv), Goal 10 = Reduced Inequalities (iii). Correct match: 1-ii, 2-i, 3-iv, 4-iii.'),

('jkpsc-jkcce-2025-pre-gs1-q17',
'Under Pradhan Mantri Awaas Yojana-Gramin (PMAY-G), approximately 2.69 crore houses were completed from 2016 to January 2025, against a target of 2.95 crore houses under Phase I and Phase II.'),

('jkpsc-jkcce-2025-pre-gs1-q18',
'Finance Commission Chairpersons: 10th (1995–2000) — KC Pant ✓, 12th (2005–10) — Dr. C. Rangarajan ✓, 13th (2010–15) — Vijay Kelkar ✓, 14th (2015–20) — Dr. YV Reddy ✓. All four pairs are correctly matched.'),

('jkpsc-jkcce-2025-pre-gs1-q19',
'The Government of India Act, 1919 (Montagu-Chelmsford Reforms) first provided for the establishment of a Public Service Commission in India. The actual commission was created later under the Government of India Act, 1935, but the statutory provision was first made in the 1919 Act.'),

('jkpsc-jkcce-2025-pre-gs1-q20',
'Correct list assignments: Education (I) is in the Concurrent List (added by 42nd Amendment, 1976) ✓; Income Tax (II) is in the Union List (Entry 82), NOT Concurrent ✗; Public Health (III) is in the State List ✓; Census (IV) is in the Union List ✓. Statements I, III, and IV are correctly matched.'),

('jkpsc-jkcce-2025-pre-gs1-q21',
'Under Article 143, the Supreme Court may give its opinion on a Presidential reference but is not obligated to — it can decline (Statement I: correct). The advisory opinion is NOT binding on the President or any court (Statement II: incorrect). Hence Statement I is correct, Statement II is incorrect.'),

('jkpsc-jkcce-2025-pre-gs1-q22',
'The Advocate General (Article 165): appointed by the Governor (I ✓), holds office at the Governor''s pleasure (II ✓). However, remuneration is determined by the Governor, not the State Legislature (III ✗). Only Statement III is NOT correct.'),

('jkpsc-jkcce-2025-pre-gs1-q23',
'Warrant of Precedence (India): Chief Justice of India (I) ranks 6th, Union Cabinet Ministers (IV) rank 9th, Chief Election Commissioner (III) ranks around 18th, Cabinet Secretary (II) ranks 19th or lower. Descending precedence: I > IV > III > II.'),

('jkpsc-jkcce-2025-pre-gs1-q24',
'Under the Lokpal and Lokayuktas Act, 2013 (Section 14), Lokpal''s jurisdiction covers the Prime Minister (I, with restrictions), Union Ministers (II), and officials of the Central Government (IV). Members of Parliament (III) are not directly under Lokpal for their conduct inside Parliament, which is protected by constitutional parliamentary privileges.'),

('jkpsc-jkcce-2025-pre-gs1-q25',
'Article 111 on Presidential assent to bills: the President may give assent (I ✓) or withhold assent (II ✓). However, Article 109(5) specifically prohibits the President from returning a Money Bill for reconsideration (III ✗). Only I and II apply to Money Bills.'),

('jkpsc-jkcce-2025-pre-gs1-q26',
'The Prime Minister is the ex-officio Chairperson of NITI Aayog, not "appointed" to the position by the PM — Assertion A is incorrect. Reason R is correct: NITI Aayog was established on 1 January 2015 through an executive resolution of the Government of India, replacing the Planning Commission.'),

('jkpsc-jkcce-2025-pre-gs1-q27',
'Salaries charged on the Consolidated Fund of India (not subject to vote of Parliament): Judges of the Supreme Court (Article 125) ✓, Comptroller and Auditor General (Article 148) ✓, Chief Election Commissioner (Article 324) ✓. All three are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q28',
'Presidential veto powers in India: Absolute Veto (1 ✓), Suspensive Veto (2 ✓), Pocket Veto (3 ✓ — informally, when President neither assents nor returns indefinitely). Line-Item Veto (4) does NOT exist in the Indian Constitution — Presidents cannot reject specific provisions/items in a bill. Three pairs are correctly matched.'),

('jkpsc-jkcce-2025-pre-gs1-q29',
'The 91st Constitutional Amendment Act, 2003 inserted Article 75(1A), capping the total number of Union Ministers (including the Prime Minister) at 15% of the total membership of the Lok Sabha. This aimed to curb the proliferation of ministers.'),

('jkpsc-jkcce-2025-pre-gs1-q30',
'Statement I: Article 239A was NOT added by the 37th Amendment — it was inserted by the 14th Constitutional Amendment Act, 1962 to allow creation of a legislature for Puducherry. Statement II: After J&K Reorganisation Act, 2019, J&K became a UT with a legislature, making Article 239A applicable. Only Statement II is correct.'),

('jkpsc-jkcce-2025-pre-gs1-q31',
'Vice Presidents of India: S. Radhakrishnan (I ✓, 1st VP 1952–62), Zakir Hussain (II ✓, 2nd VP 1962–67). Fakhruddin Ali Ahmed (III) was the 5th President, NOT VP. Giani Zail Singh (IV) was the 7th President, NOT VP. Only I and II served as Vice Presidents.'),

('jkpsc-jkcce-2025-pre-gs1-q32',
'Among the four states listed, President''s Rule has been imposed most frequently in Uttar Pradesh (I), followed by Karnataka (IV), Tamil Nadu (II), and Madhya Pradesh (III), in descending order of frequency.'),

('jkpsc-jkcce-2025-pre-gs1-q33',
'Rajya Sabha seats (ascending order): Punjab (III) = 7 seats, Rajasthan (II) = 10 seats, Karnataka (IV) = 12 seats, West Bengal (I) = 16 seats. Correct ascending sequence: III — II — IV — I.'),

('jkpsc-jkcce-2025-pre-gs1-q34',
'State formation: Arunachal Pradesh — The State of Arunachal Pradesh Act was enacted in 1986 (effective February 20, 1987), so 1986 is considered correct (I ✓). Telangana was formed in June 2014 (not 2013) ✗, Goa attained statehood in May 1987 (not 1986) ✗, Uttarakhand became a state in November 2000 (not 2001) ✗. Only pair I is correctly matched.'),

('jkpsc-jkcce-2025-pre-gs1-q35',
'In the first general elections held in 1951-52, the Election Commission of India recognised 14 national parties that participated in the Lok Sabha elections.'),

('jkpsc-jkcce-2025-pre-gs1-q36',
'Article 243 J of the Indian Constitution provides for the audit of accounts of Panchayats. The state legislature is empowered to make provisions regarding the maintenance and audit of Panchayat accounts.'),

('jkpsc-jkcce-2025-pre-gs1-q37',
'Dominant caste-state associations: Lingayats (I) in Karnataka ✓, Patidars/Patels (II) in Gujarat ✓, Kammas (IV) in Andhra Pradesh ✓. Vokkalingas (III) are dominant in Karnataka, NOT Tamil Nadu ✗. Statements I, II, and IV are correctly matched.'),

('jkpsc-jkcce-2025-pre-gs1-q38',
'Blue Flag Certification: It is indeed awarded by the Foundation for Environmental Education (FEE), headquartered in Denmark (I ✓). Chandrabhaga Beach in Odisha''s Konark was the first Indian beach to receive the Blue Flag Certification in 2020 (II ✓). Both statements are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q39',
'The Kondh tribes of Odisha practice "Dongar" (also called "Podu") cultivation — a form of shifting cultivation in forested hill areas. This traditional practice is under threat due to monocropping of Eucalyptus, which degrades the mixed forest ecosystem the Kondhs depend on.'),

('jkpsc-jkcce-2025-pre-gs1-q40',
'The revised criteria for Classical Language status include: high antiquity (1500-2000 years) of early texts (I ✓), ancient literature considered a valuable heritage (II ✓), and an original literary tradition not borrowed from another community (III ✓). A minimum of 50 million current speakers (IV) is NOT a criterion — classical status is based on antiquity and literary heritage, not current speaker count.'),

('jkpsc-jkcce-2025-pre-gs1-q41',
'Under India''s National Quantum Mission: IISc Bengaluru leads the Quantum Computing Hub (1-i), IIT Madras leads the Quantum Communication Hub (2-ii), IIT Bombay leads the Quantum Sensing and Metrology Hub (3-iv), and IIT Delhi leads the Quantum Materials and Devices Hub (4-iii).'),

('jkpsc-jkcce-2025-pre-gs1-q42',
'Gaganyaan Mission: Statement I is incorrect — Gaganyaan targets a Low Earth Orbit (~400 km altitude), NOT geostationary orbit (~36,000 km). Statements II (two uncrewed missions followed by one crewed) and III (LVM3-derived human-rated launch vehicle) are correct. Only Statement I is incorrect.'),

('jkpsc-jkcce-2025-pre-gs1-q43',
'Nipah Virus (NiV): It is a paramyxovirus (NOT an orthopoxvirus, making I incorrect). It is zoonotic — transmitted from fruit bats to humans, sometimes via intermediate hosts like pigs (II ✓). PCR is the preferred diagnostic test (III ✓). Average incubation period is 4–14 days (IV ✓). Three statements (II, III, IV) are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q44',
'All four Indian humanitarian operations are correctly matched: Operation Dost — Turkey-Syria earthquake relief (2023), Operation Ganga — evacuation from Ukraine conflict (2022), Operation Kaveri — evacuation from Sudan conflict (2023), Operation Ajay — rescue from Israel-Hamas conflict zones (2023). All four pairs are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q45',
'Hugging Face''s AI model hub supports Natural Language Processing (I ✓), Audio Processing (III ✓), and Computer Vision (IV ✓). Quantum Computing (II) is not part of the Hugging Face platform — it is a distinct hardware/software paradigm outside Hugging Face''s ML ecosystem.'),

('jkpsc-jkcce-2025-pre-gs1-q46',
'PM Modi''s global awards: Grand Cross of the Order of Honour — Greece (1-ii), Grand Companion of the Order of Logohu — Papua New Guinea (2-iv), Order of the Holy Apostle Andrew the First — Russia (3-i), Grand Cross of the Legion of Honour — France (4-iii).'),

('jkpsc-jkcce-2025-pre-gs1-q47',
'Article 19(2) lists valid grounds for restricting freedom of speech and expression. All four mentioned — sovereignty and integrity of India (I), public order (II), contempt of court (III), and defamation (IV) — are explicitly listed under Article 19(2). Additional grounds include security of state, friendly relations with foreign states, decency/morality, and incitement to offences.'),

('jkpsc-jkcce-2025-pre-gs1-q48',
'As of 2025, the Shanghai Cooperation Organisation (SCO) has 10 member states (including India, China, Russia, Pakistan, Iran, Belarus, and four Central Asian states), 2 observer states (Afghanistan, Mongolia), and 14 dialogue partners.'),

('jkpsc-jkcce-2025-pre-gs1-q49',
'J&K Energy Development Agency (JAKEDA) mission/vision: I (Lead the energy transition ✓), II (speed up transition to "full/complete" renewable energy — the word "partial" makes II incorrect ✗), III (build a culture of excellence ✓), IV (maintain highest standards of quality and sustainability ✓). Statements I, III, and IV are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q50',
'Indian classical music Gharana associations: Channulal Mishra — Banaras Gharana (1-iv), Krishnarao Shankar Pandit — Gwalior Gharana (2-iii), Pandit Bhimsen Joshi — Kirana Gharana (3-ii), Pandit Yashpal — Agra Gharana (4-i).'),

('jkpsc-jkcce-2025-pre-gs1-q51',
'Mirabai Chanu achievements: She won the IWF World Championship gold in 2017 (II ✓), silver in 2022 (III ✓), and a silver medal at the IWF World Championship 2025 (I ✓). She did NOT win gold at the Paris Olympics 2024 — she finished 4th (IV ✗). Statements I, II, and III are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q52',
'IVC facts: Statement I is incorrect — Mohenjo-Daro was the more elaborately planned city, not Harappa. Statement II is correct — the Great Bath was located on the Citadel mound at Mohenjo-Daro. Statement III is incorrect — the granary at Harappa is significant but not definitively the largest structure. Only Statement II is correct.'),

('jkpsc-jkcce-2025-pre-gs1-q53',
'Buddhist Councils: 1st — Rajgriha ✓, 2nd — Vaishali ✓, 3rd — Pataliputra (NOT Kashmir, so pair 3 is incorrectly matched ✗), 4th — Kashmir (NOT Pataliputra, so pair 4 is incorrectly matched ✗). Two pairs (3rd and 4th) have swapped venues and are incorrectly matched.'),

('jkpsc-jkcce-2025-pre-gs1-q54',
'During Mughal Emperor Jahangir''s reign (1605-1627), the British East India Company established its factory at Surat (1612-13) — only one location among the three listed. Madras (Fort St. George) was established in 1639 under Shah Jahan, and Bombay was acquired in 1661 during Aurangzeb''s period. Only Surat (I) was established during Jahangir''s reign.'),

('jkpsc-jkcce-2025-pre-gs1-q55',
'Pietra dura (inlay work with semi-precious stones) technique was used in: Taj Mahal (I ✓ — extensively throughout the mausoleum), Agra Fort (II ✓ — in the Khas Mahal and Sheesh Mahal), and Red Fort (III ✓ — in the Diwan-i-Khas and Rang Mahal). Shalimar Bagh (IV) is a Mughal garden without significant pietra dura work. Three monuments used this technique.'),

('jkpsc-jkcce-2025-pre-gs1-q56',
'Foreign accounts on Vijayanagara: Abdur Razzaq (I, Persian ambassador, 1443) ✓, Domingo Paes (II, Portuguese traveller, early 16th c.) ✓, Ibn Battuta (III, Moroccan traveller, mid-14th c. — he visited South India during Vijayanagara''s early period) ✓, Niccolo de Conti (IV, Italian merchant, early 15th c.) ✓. All four provide contemporary evidence.'),

('jkpsc-jkcce-2025-pre-gs1-q57',
'Cripps Mission (1942): Provinces could opt out of the proposed Indian Union (I ✓) and a Constituent Assembly would draft the constitution after the war (II ✓). Statement III is an oversimplification — the Muslim League mainly rejected the proposal because it didn''t guarantee immediate Pakistan, not just lack of explicit recognition. Only I and II are fully correct.'),

('jkpsc-jkcce-2025-pre-gs1-q58',
'Government of India Act, 1935: Provincial autonomy with ministries responsible to elected legislatures (I ✓), Governor-General retained sweeping overriding powers (II ✓). Statement III is incorrect — bicameral legislatures were established only in 6 provinces (Bengal, Bombay, Madras, Bihar, UP, Assam), NOT in all provinces. Only I and II are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q59',
'Lahore Congress Session, 1929: Presided over by Jawaharlal Nehru (NOT Subhas Chandra Bose — Statement I ✗). Purna Swaraj (Complete Independence) resolution was adopted (II ✓). 26 January 1930 was declared Independence Day (III ✓). The INC boycotted the Round Table Conference — it did NOT approve participation (IV ✗). Statements II and III are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q60',
'Pabna Agrarian Revolt (1873-76) in Bengal was led by peasant leaders including Ishan Chandra Roy, Sambhunath Pal, and Sham Sudar Pal. Bankim Chandra Chatterjee wrote about the revolt but was not its leader. Ishwar Chandra Vidyasagar (a social reformer) and Ram Mohan Roy (died 1833, decades before the revolt) were not associated with it. Three personalities from the list were associated with the revolt.'),

('jkpsc-jkcce-2025-pre-gs1-q61',
'Correct journal-founder pairs: Kesari was founded by Bal Gangadhar Tilak (not Surendranath Banerjee — pair 1 ✗), Bengalee was founded by Surendranath Banerjee (not Tilak — pair 2 ✗), Sudharak was associated with Gopal Krishna Gokhale (pair 3 ✓), Indian Mirror was founded by Devendranath Tagore/Manmathanath Ghosh (Keshab Chandra Sen was associated but not the founder — pair 4 ✗). Only one pair (Sudharak-Gokhale) is correctly matched.'),

('jkpsc-jkcce-2025-pre-gs1-q62',
'Glucose is a monosaccharide with 6 carbon atoms (making it a hexose) and an aldehyde group (–CHO) at carbon-1 (making it an aldose). Combined: glucose is an aldohexose. Fructose, by contrast, has a ketone group and is a ketohexose.'),

('jkpsc-jkcce-2025-pre-gs1-q63',
'Ramcharita (not Ramcharitamanas) was written by Sandhyakaranandin, a 12th-century Sanskrit poet from Bengal. It is a historical poem describing the life and campaigns of the Pala king Ramapala. Tulsidas wrote the Ramcharitamanas (16th century).'),

('jkpsc-jkcce-2025-pre-gs1-q64',
'According to tradition and historical records, saffron cultivation in Kashmir was introduced by Mijjhantika (also spelled Madhyantika), a Buddhist missionary sent to Kashmir by Emperor Ashoka to propagate Buddhism. He is credited with bringing saffron (Crocus sativus) to the Kashmir Valley.'),

('jkpsc-jkcce-2025-pre-gs1-q65',
'According to the 1st Water Census of J&K, majority of water bodies are in rural areas ✓, more than 50% are publicly owned ✓, and there are more than 10,000 water bodies in the UT ✓. The claim that "more than half of water bodies are lakes" is incorrect — ponds and tanks dominate, not lakes. This makes Statement B (option B) the incorrect statement.'),

('jkpsc-jkcce-2025-pre-gs1-q66',
'Statement 1 is incorrect — the 4th Global Coral Bleaching Event (2024) DID impact Indian reefs (Andaman & Nicobar, Lakshadweep, Gulf of Mannar, Gulf of Kachchh). Statement 2 is correct — MPAs exist across India to restrict human activities and aid reef recovery. Statement 3 is incorrect — corals ARE protected under Schedule I of the Wildlife (Protection) Act, 1972. Only Statement 2 is correct.'),

('jkpsc-jkcce-2025-pre-gs1-q67',
'The equator in Africa passes through Gabon, Republic of Congo, DR Congo, Uganda, Kenya, and Somalia. Cameroon lies entirely north of the equator (between 2°N and 13°N latitude); the equator does not pass through Cameroon.'),

('jkpsc-jkcce-2025-pre-gs1-q68',
'The NAVYA (Nurturing Aspirations through Vocational training for Young Adolescent Girls) initiative is implemented in Baramulla district of Jammu & Kashmir, targeting skill development and vocational training for adolescent girls in the district.'),

('jkpsc-jkcce-2025-pre-gs1-q69',
'Surinsar-Mansar Lake (J&K): It was designated a Ramsar site in 2005 (Statement 1 ✓). The lake does host migratory birds — Statement 2 is incorrect ✗. It has rich aquatic biodiversity (Statement 3 ✓). Statements 1 and 3 are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q70',
'India''s longitudinal extent is approximately 68°7''E (westernmost point near Rann of Kachchh, Gujarat) to 97°25''E (easternmost point in Arunachal Pradesh — Kibithu). The latitudinal extent is 8°4''N to 37°6''N.'),

('jkpsc-jkcce-2025-pre-gs1-q71',
'Human Poverty Index (UNDP): HPI-1 measures poverty in developing countries across longevity, knowledge, and standard of living (I ✓). HPI-2 measures poverty in industrialised countries with an added social exclusion dimension (II ✓). HPI was replaced by the Multidimensional Poverty Index (MPI) from the 2010 Human Development Report (III ✓). All three statements are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q72',
'Indigenous cattle breeds and regions: Bargur — Tamil Nadu (a-iii) ✓, Hallikar — Karnataka (b-i) ✓, Vechur — Kerala (c-ii) ✓ (world''s smallest cattle breed), Bachaur — Bihar (d-iv) ✓.'),

('jkpsc-jkcce-2025-pre-gs1-q73',
'The recently discovered site of Sivagalai in Tamil Nadu made news when archaeologists conducted the first-ever scientific (AMS radiocarbon) dating of a terracotta sarcophagus, along with Harappan-period trade evidence in the form of carnelian beads pointing to contacts with northern regions during the Harappan civilisation.'),

('jkpsc-jkcce-2025-pre-gs1-q74',
'Chronological order of Biosphere Reserve establishment in India: Gulf of Mannar, Tamil Nadu (1989) → Simlipal, Odisha (1994) → Pachmarhi, Madhya Pradesh (1999) → Agasthyamalai, Kerala/Tamil Nadu (2001) → Kachchh, Gujarat (2008).'),

('jkpsc-jkcce-2025-pre-gs1-q75',
'Operation Megh Rahat (September 2014) was a major HADR operation by the Indian Army in Jammu & Kashmir during the devastating floods (NOT earthquake — Statement II is incorrect). It involved large-scale deployment of troops, helicopters, and engineering task forces to rescue over 2 lakh civilians and restore infrastructure (I ✓, III ✓). Statements I and III are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q76',
'Assertion: Heavier objects fall faster — this is INCORRECT (disproved by Galileo and Newton; all objects fall at the same rate in vacuum). Reason: Acceleration due to gravity is independent of mass — this is CORRECT (g ≈ 9.8 m/s² regardless of mass). A is not correct but R is correct.'),

('jkpsc-jkcce-2025-pre-gs1-q77',
'Statement I: Reflection and refraction are optical phenomena ✓. Statement II: Reflection does NOT involve a change in the speed of light — only refraction changes the speed of light as it passes from one medium to another. So Statement II is incorrect ✗. Statement III: Refraction bends (changes the direction of) light ✓. Only I and III are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q78',
'Bacteria are unicellular living organisms that can reproduce independently by binary fission (B ✓). Viruses are not independently living — they cannot reproduce without a host cell (A ✗). Neither viruses nor bacteria are multicellular (C ✗). Most viruses are visible only under an electron microscope, not a standard light microscope (D ✗).'),

('jkpsc-jkcce-2025-pre-gs1-q79',
'All three enzyme-substrate pairs are biologically correct: Amylase acts on carbohydrates (starch), Lipase acts on fats (lipids), and Pepsin acts on proteins. All three matches are accurately stated. (Note: the official answer key designates option A — verify with official JKPSC key if discrepancy exists.)'),

('jkpsc-jkcce-2025-pre-gs1-q80',
'Statement I: Genetic traits are carried by DNA ✓. Statement II: RNA is typically single-stranded, NOT double-stranded — DNA is double-stranded (Statement II is incorrect ✗). Statement III: Mitosis produces genetically identical daughter cells, enabling growth and tissue repair ✓. Statements I and III are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q81',
'Plant hormones and functions: Auxin — phototropism and growth regulation ✓, Cytokinin — promotes cell division and delays senescence ✓, Gibberellin — promotes stem elongation and seed germination ✓, Abscisic acid — promotes seed dormancy and stomatal closure ✓. All four pairs are correctly matched.'),

('jkpsc-jkcce-2025-pre-gs1-q82',
'A satellite in circular orbit moves at constant speed (magnitude of velocity is unchanged) but its direction changes continuously as it follows the circular path. Since velocity is a vector (speed + direction), the continuously changing direction means velocity is not constant, and there is centripetal acceleration directed towards the Earth.'),

('jkpsc-jkcce-2025-pre-gs1-q83',
'Posthumous Nobel Prizes: Erik Axel Karlfeldt (I) received the 1931 Nobel Prize in Literature posthumously (he died in April 1931, the prize was announced in November). Dag Hammarskjöld (II) received the 1961 Nobel Peace Prize posthumously. Pierre Curie (III) received the 1903 Nobel Prize in Physics while alive (he died in 1906) — NOT posthumously. Only I and II were awarded posthumously.'),

('jkpsc-jkcce-2025-pre-gs1-q84',
'The SA node (Sinoatrial node), located in the right atrium, initiates the electrical impulse that triggers each heartbeat. It is the natural pacemaker of the heart. The AV node (atrioventricular node) acts as a secondary/backup pacemaker. The Bundle of His and Purkinje fibers conduct the impulse to the ventricles.'),

('jkpsc-jkcce-2025-pre-gs1-q85',
'Statement I: DEG is indeed an industrial solvent used in antifreeze, brake fluid, and textile/dye manufacturing ✓. Statement II: DEG is NOT a standard ingredient in e-cigarette liquid — propylene glycol (PG) and vegetable glycerin (VG) are the standard base liquids; DEG is a harmful contaminant that has caused poisoning incidents when used in counterfeit products ✗. Only Statement I is correct.'),

('jkpsc-jkcce-2025-pre-gs1-q86',
'Statement I: Static electricity is a stationary buildup of charge — it does not flow through wires like current electricity ✓. Statement II: Lightning is a massive discharge of static electricity between clouds and the ground ✓. Statement III: Electric current is the flow of charges — it is dynamic (moving), NOT static ✗. Only Statements I and II are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q87',
'Pure water has a pH of exactly 7 at 25°C (298 K) — this is the standard reference temperature at which [H⁺] = [OH⁻] = 10⁻⁷ mol/L. At higher temperatures, water dissociates more, lowering the pH below 7 even though it remains neutral (e.g., pH ≈ 6.14 at 100°C).'),

('jkpsc-jkcce-2025-pre-gs1-q88',
'Statement I: Diamond and graphite are allotropes of carbon — both consist of pure carbon atoms arranged differently ✓. Statement II: Diamond is an electrical insulator (all four valence electrons are in covalent bonds, none are free), while graphite is a good conductor (each carbon has one delocalized electron in pi bonds). Both being conductors is incorrect ✗. Only Statement I is correct.'),

('jkpsc-jkcce-2025-pre-gs1-q89',
'During Operation Sindoor (May 2025), the Akashteer automated air defence control system was integrated with the indigenous Akash Surface-to-Air Missile (SAM) system to provide automated, rapid response against low-level aerial threats including drones and missiles.'),

('jkpsc-jkcce-2025-pre-gs1-q90',
'Lion-tailed Macaque (Macaca silenus): It is strictly arboreal — it lives and forages almost exclusively in trees (I ✓). It is endemic to the Western Ghats of India (II ✓). It is classified as "Endangered" (not Critically Endangered) on the IUCN Red List — Statement III is partially incorrect. However, it IS protected under Schedule I of WPA. Statements I and II are fully correct.'),

('jkpsc-jkcce-2025-pre-gs1-q91',
'Semelparous species reproduce only once in their lifetime: Pacific salmon (III ✓ — die after spawning) and Bamboo (IV ✓ — monocarpic, flowers once then dies). Pelagic fishes (I) and oysters (II) are typically iteroparous — they spawn multiple times throughout their lives. Correct answer: III and IV.'),

('jkpsc-jkcce-2025-pre-gs1-q92',
'Recent coral reef patch discoveries in India: Malvan and Redi (both in Maharashtra coastal areas, II ✓) and Gaveshani Bank (off Karnataka coast near Karwar, III ✓) have been reported. Ratnagiri and South Bombay are not among the confirmed recent discoveries. Statements II and III are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q93',
'States approved for Plastic Parks under the Ministry of Chemicals and Petrochemicals: Uttarakhand (I ✓), Madhya Pradesh (III ✓), and Jharkhand (IV ✓). Maharashtra (II) is not among the states with approved Plastic Parks. Statements I, III, and IV are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q94',
'Brood parasitism (laying eggs in another species'' nest): Indigobird (I ✓ — parasitizes finches), Common Cuckoo (II ✓ — the classic example), Honeyguide (III ✓ — parasitizes bee-eaters), Cowbirds (VI ✓ — well-known brood parasites of the Americas). Eagles (IV) and Pigeons (V) raise their own young and do not practice brood parasitism.'),

('jkpsc-jkcce-2025-pre-gs1-q95',
'Deep Ocean Mission: Launched in 2021 under the Ministry of Earth Sciences (MoES) to sustainably harness ocean resources and strengthen the Blue Economy (I ✓). India''s first manned submersible vehicle MATSYA 6000 is being developed under the Samudrayaan Project, which is part of the Deep Ocean Mission (II ✓). Both statements are correct.'),

('jkpsc-jkcce-2025-pre-gs1-q96',
'Correctly matched extinct species: Dodo — Mauritius (1-1 ✓), Steller''s sea cow — Russia/Commander Islands (4-4 ✓). Quagga was a South African zebra subspecies — NOT from Australia (pair 2 ✗). Thylacine (Tasmanian Tiger) was from Australia — NOT Africa (pair 3 ✗). Only pairs 1 and 4 are correctly matched.'),

('jkpsc-jkcce-2025-pre-gs1-q97',
'The International Big Cat Alliance (IBCA) became a treaty-based intergovernmental organization after ratification by five founding countries: India, Liberia, Eswatini, Somalia, and Nicaragua. India is the host country and was the driving force behind IBCA''s formation to protect the seven big cat species globally.'),

('jkpsc-jkcce-2025-pre-gs1-q98',
'Statement I is incorrect — carbon pricing is a policy tool that assigns financial cost to ALL greenhouse gas emissions (primarily CO₂, not primarily methane). Methane is one of many covered gases but is not the primary focus. Statement II is correct — by making emitters pay for environmental damage, carbon pricing creates economic incentives to reduce emissions. Only Statement II is correct.'),

('jkpsc-jkcce-2025-pre-gs1-q99',
'Statement I: Bt. cotton (Bollgard) is the only GM crop approved for commercial cultivation in India (since 2002) ✓. Statement II: India is not the third-largest cotton producer — India is consistently among the top 1-2 producers globally (often the largest or second-largest after China); the USA ranks lower than India ✗. Only Statement I is correct.'),

('jkpsc-jkcce-2025-pre-gs1-q100',
'Statement I: The Montreux Record is maintained under the Ramsar Convention as part of the Ramsar List of Wetlands of International Importance — it lists wetlands where ecological character has changed, is changing, or is likely to change ✓. Statement II is incorrect — Chilika Lake (Odisha) was removed from the Montreux Record in 2002 after conservation efforts improved its condition. Currently, only Keoladeo National Park (Rajasthan) from India remains on the Montreux Record. Only Statement I is correct.')

) AS ans(slug, explanation)
WHERE vaultcore.questions.slug = ans.slug;

COMMIT;
