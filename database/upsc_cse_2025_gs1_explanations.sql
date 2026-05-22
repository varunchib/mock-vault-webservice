-- UPSC CSE Prelims 2025 GS Paper I — Explanations for all 100 questions

UPDATE vaultcore.questions SET explanation = v.expl
FROM (VALUES
  ('upsc-cse-2025-pre-gs1-q1',
   'Under SEBI''s AIF Regulations, Alternative Investment Funds include Hedge Funds (Cat III) and Venture Capital (Cat I). Bonds and Stocks are conventional investment instruments, not AIFs. Thus only two (Hedge Funds and Venture Capital) qualify.'),

  ('upsc-cse-2025-pre-gs1-q2',
   'RBI earns income from two main sources: interest on government securities held (open market operations) and gains from buying/selling foreign currency (forex reserves management). Pension fund management is done by PFRDA. RBI does not lend to private companies. Currency printing is a cost, not an income stream.'),

  ('upsc-cse-2025-pre-gs1-q3',
   'The Directorate of Enforcement (ED) works under the Department of Revenue, Ministry of Finance — not MHA. So Row I is wrong. DRI (Row II) correctly falls under Dept of Revenue, MoF. DGSM (Row III) description of big-data analytics for tax evasion does not match its actual function of IT infrastructure support. Only one row is correctly matched.'),

  ('upsc-cse-2025-pre-gs1-q4',
   'BRSR (Business Responsibility and Sustainability Report) is mandated by SEBI (not RBI) for the top 1000 listed companies by market capitalisation. BRSR disclosures are largely non-financial — covering environmental, social, and governance (ESG) metrics. So Statement I is incorrect (wrong regulator); Statement II is correct.'),

  ('upsc-cse-2025-pre-gs1-q5',
   'Income from allied activities like poultry farming and wool rearing is NOT automatically tax-exempt under the Income-tax Act — only agricultural income as defined under Section 2(1A) is exempt. However, rural agricultural land is explicitly excluded from the definition of "capital asset" under Section 2(14) of the IT Act. Thus Statement I is incorrect; Statement II is correct.'),

  ('upsc-cse-2025-pre-gs1-q6',
   'India joined the US-led Minerals Security Partnership (MSP) in 2023, making Statement I correct. India is NOT self-sufficient in all 30 identified critical minerals — it imports several like lithium and cobalt, so Statement II is incorrect. The MMDR Amendment Act 2023 empowered the Centre to exclusively auction mining leases for critical minerals, making Statement III correct.'),

  ('upsc-cse-2025-pre-gs1-q7',
   'Bondholders are lenders who receive fixed interest (lower risk), while stockholders are owners who bear residual risk (higher risk). Both Statement II (bondholders are lenders, stockholders are owners) and Statement III (bondholders are prioritised in repayment/liquidation) correctly explain why bondholders face lower risk. Both explain Statement I.'),

  ('upsc-cse-2025-pre-gs1-q8',
   'NSE is the world''s largest derivatives exchange by number of contracts — India accounts for a dominant share of global equity options volume (Statement I correct). India''s stock market capitalisation has at times surpassed Hong Kong''s (Statement II correct). SEBI exists as the regulatory body overseeing options trading and financial advisors, so Statement III is incorrect.'),

  ('upsc-cse-2025-pre-gs1-q9',
   'A circular economy reduces greenhouse gas emissions (Statement I) because it relies on recycling and reuse — thereby reducing raw material extraction (Statement II) and minimising production waste (Statement III). Both II and III are correct explanations for why a circular economy cuts GHG emissions.'),

  ('upsc-cse-2025-pre-gs1-q10',
   'Capital receipts either create a liability (e.g., borrowings) or reduce assets (e.g., disinvestment) — Statement I correct. Borrowings and disinvestment are both capital receipts — Statement II correct. Interest received on loans is a revenue receipt for the government; it does not create a liability — Statement III is incorrect.'),

  ('upsc-cse-2025-pre-gs1-q11',
   'Raja Ram Mohan Roy deeply respected Eastern philosophical traditions — he was a Sanskrit and Vedanta scholar who drew on the Upanishads. He also championed rational and scientific thinking and fought for social equality, opposing practices like sati. Both statements are correct.'),

  ('upsc-cse-2025-pre-gs1-q12',
   'The Non-Cooperation Programme included: boycott of law courts and foreign cloth (I), strict non-violence (II), and establishing panchayats for local dispute settlement (IV). Statement III is wrong — the programme called for the surrender (return) of titles and honours, not merely refraining from using them in public. Thus three items (I, II, IV) were part of the programme.'),

  ('upsc-cse-2025-pre-gs1-q13',
   'Araghatta was the Persian wheel — a large wheel with earthen pots (ghatas) tied to the outer ends of its spokes or rim. Bullocks walked in circles to rotate the wheel, lifting water from wells. It was widely used for irrigation in medieval India.'),

  ('upsc-cse-2025-pre-gs1-q14',
   'Mahendravarman I of the Pallava dynasty (c. 600–630 CE) assumed the titles Mattavilasa (lover of pleasures), Vichitrachitta (of curious mind), and Gunabhara (treasury of virtues). He was also the author of the satirical Sanskrit play Mattavilasa Prahasana.'),

  ('upsc-cse-2025-pre-gs1-q15',
   'The Chinese Buddhist pilgrim Fa-hien (Faxian) visited India between 399 and 414 CE during the reign of Chandragupta II (Vikramaditya), who ruled c. 375–415 CE. Fa-hien''s account describes a prosperous and peaceful India under Gupta rule.'),

  ('upsc-cse-2025-pre-gs1-q16',
   'Rajendra I of the Chola dynasty launched the famous naval expedition (~1025 CE) against the Srivijaya Empire, which controlled the Malay Peninsula, Sumatra, Java, and nearby islands. This was one of the most successful overseas military campaigns in ancient Indian history.'),

  ('upsc-cse-2025-pre-gs1-q17',
   'Asmaka (near Godavari, Deccan) and Kosala (Sarayu river, modern UP/Ayodhya) are correctly paired. Kamboja was a north-western janapada near the Hindukush/Kabul river region, not the Vipas (Beas) — so pair II is wrong. Avanti''s main river was the Shipra/Kshipra, not the Mahanadi — so pair III is wrong. Only two pairs (I and IV) are correct.'),

  ('upsc-cse-2025-pre-gs1-q18',
   'Pandit Vishnu Digambar Paluskar established the first Gandharva Mahavidyalaya in Lahore in 1901 to provide systematic, institutional training in Hindustani classical music. He later opened branches in other cities. Lahore, then part of undivided India, was his first choice.'),

  ('upsc-cse-2025-pre-gs1-q19',
   'Ashokan edicts identify Pradeshika (equivalent to a district magistrate), Rajuka (officer dealing with land records and justice at the village/district level), and Yukta (clerical/revenue official) as officers working at the district level, not at the village or provincial level.'),

  ('upsc-cse-2025-pre-gs1-q20',
   'At the Nagpur Congress (1920) which launched the Non-Cooperation Movement: Statement I is correct — Congress adopted the goal of "Swaraj by legitimate and peaceful means." Statement II is also correct — the movement was to be implemented in stages; civil disobedience and non-payment of taxes would come only in the next phase if Swaraj was not achieved within a year and the government resorted to repression.'),

  ('upsc-cse-2025-pre-gs1-q21',
   'From the list, NATO members are: Bulgaria (2004), Croatia (2009), Sweden (2024), and North Macedonia (2020) — four countries. Austria is neutral and not a NATO member. Serbia is not a NATO member (it has a partnership but not full membership). Thus four of the six listed countries are NATO members.'),

  ('upsc-cse-2025-pre-gs1-q22',
   'The Andes mountain range runs along the western coast of South America. It passes through Venezuela, Colombia, Ecuador, Peru, Bolivia, Chile, and Argentina. From the list: Bolivia (I) — yes; Brazil (II) — no (Andes are on the western coast, Brazil is on the east); Colombia (III) — yes; Ecuador (IV) — yes; Paraguay (V) — no; Venezuela (VI) — yes (marginally in the northwest). Four countries (Bolivia, Colombia, Ecuador, Venezuela) qualify.'),

  ('upsc-cse-2025-pre-gs1-q23',
   'Lake Tanganyika lies between 3°S and 8°S — entirely south of the equator, which does not pass through it. Lake Tonlé Sap is in Cambodia at about 12°N — the equator does not pass through it. Patos Lagoon is in southern Brazil at about 32°S — far south of the equator. The equator passes through none of the three water bodies.'),

  ('upsc-cse-2025-pre-gs1-q24',
   'India is the world''s largest producer (accounting for ~75% of global output) and exporter of turmeric. More than 30 (actually over 50) varieties of turmeric are grown in India. Telangana is the largest producing state, followed by Maharashtra, Karnataka, and Tamil Nadu — all mentioned. All three statements are correct.'),

  ('upsc-cse-2025-pre-gs1-q25',
   'All three are classical evidences of continental drift: the geological rock belt continuity between Brazil and West Africa (I), the hypothesis that Ghana''s gold deposits share origin with the Brazilian plateau (II), and the presence of Gondwana flora/fauna (especially Glossopteris) across six Southern Hemisphere landmasses (India, Africa, South America, Antarctica, Australia, Madagascar) (III). All three are correct.'),

  ('upsc-cse-2025-pre-gs1-q26',
   'Subtropical and temperate regions have more industrial activity, agricultural land, and dry winds — hence more dust in the atmosphere than equatorial (humid, rainwashed) or polar (cold, little activity) regions. Statement I is correct. However, Statement II is incorrect: subtropical regions actually have MORE dry winds (descending air at horse latitudes, trade winds), not less. So only Statement I is correct.'),

  ('upsc-cse-2025-pre-gs1-q27',
   'In January (Northern Hemisphere winter), land masses cool faster than oceans. Colder land pulls isotherms equatorward, while warmer oceans push them poleward — Statement I is correct. This happens because oceans retain heat better than land in winter, making air over oceans warmer than over land — Statement II is correct. Statement II directly explains the isotherm bending described in Statement I.'),

  ('upsc-cse-2025-pre-gs1-q28',
   'Chalk is both porous and permeable — water can pass through it (Statement II correctly explains Statement I for chalk). Clay is porous (has many tiny pores between its fine particles) but its pores are so small and poorly connected that water cannot pass through — making it impermeable despite having porosity. Statement III claiming clay has "no porosity at all" is technically incorrect since clay does have porosity; its impermeability comes from small, poorly connected pores. Both II and III are correct but only Statement II fully explains Statement I.'),

  ('upsc-cse-2025-pre-gs1-q29',
   'Without the atmosphere''s greenhouse effect, Earth''s average surface temperature would be well below freezing (around -18°C) — Statement I correct. The atmosphere absorbs and re-radiates longwave radiation, maintaining Earth''s average temperature of ~15°C — Statement II correct. Greenhouse gases like CO2 and water vapour are particularly effective at absorbing infrared radiation — Statement III correct. All three are correct.'),

  ('upsc-cse-2025-pre-gs1-q30',
   'The Rashtriya Gokul Mission (RGM), launched in 2014, specifically focuses on small and marginal farmers who own the majority of low-producing indigenous cattle (Statement I correct). Its objective is to conserve and develop indigenous cattle and buffalo breeds in a scientific and holistic manner (Statement II correct). Both statements are correct.'),

  ('upsc-cse-2025-pre-gs1-q31',
   'Cement accounts for approximately 8% of global CO2 emissions, well above 5% — Statement I is correct. Cement production involves mixing limestone with clay (silica-bearing) — Statement II is correct. During clinker production, limestone (CaCO3) is heated to produce lime (CaO) + CO2 — this calcination process is the primary source of cement CO2 emissions. Statement III is correct. However, only Statement III (calcination releasing CO2) directly explains Statement I; mixing clay (Statement II) does not cause CO2 emissions. Both II and III are correct, but only III explains I.'),

  ('upsc-cse-2025-pre-gs1-q32',
   'India indeed did not sign the COP28 Declaration on Climate and Health — Statement I is correct. However, the COP28 Climate and Health Declaration is NON-BINDING (like most COP declarations) — Statement II claiming it is binding is incorrect. Statement III suggesting decarbonising India''s health sector could compromise resilience is the actual reason India hesitated. Only Statement III is correct and it explains why India refrained (Statement I).'),

  ('upsc-cse-2025-pre-gs1-q33',
   'Scientific studies confirm Earth''s rotational axis is shifting due to mass redistribution — Statement I is correct. As polar ice melts, water redistributes toward lower latitudes (equator), shifting Earth''s centre of mass and causing axial drift — Statement III is correct and directly explains Statement I. Solar flares/CMEs (Statement II) affect Earth''s magnetosphere, not its rotational axis. Both II and III are correct but only III explains the polar/axis shift.'),

  ('upsc-cse-2025-pre-gs1-q34',
   'Article 6 of the Paris Agreement deals with voluntary cooperative approaches among countries to meet climate targets. Statement I is correct — it is frequently discussed in global climate negotiations. Statement II is correct — Article 6 sets out principles for international carbon markets (especially Article 6.2 and 6.4). Statement III is also correct — Article 6.8 covers non-market approaches as well. All statements are correct, and both II and III explain why Article 6 is so central to global climate discussions.'),

  ('upsc-cse-2025-pre-gs1-q35',
   'The Asian Development Bank (ADB) launched the "Nature Solutions Finance Hub for Asia and the Pacific" to catalyse private finance for nature-based solutions in the region. It leverages ADB''s position to blend public and private capital for biodiversity and climate projects.'),

  ('upsc-cse-2025-pre-gs1-q36',
   'Direct Air Capture (DAC) extracts CO2 directly from ambient air. The captured CO2 can be: (I) stored underground for carbon sequestration; (II) used as feedstock in chemical synthesis including plastics and as a preservative in food processing (carbonation); (III) combined with hydrogen (made from renewables) to create synthetic aviation fuel (e-fuel/SAF). All three uses are correct.'),

  ('upsc-cse-2025-pre-gs1-q37',
   'The Gooty/Peacock tarantula (Poecilotheria metallica) is an arachnid (spider), not a crustacean, and is carnivorous — so Statement I is entirely wrong. It is endemic to a small forest patch near Nandyal in Andhra Pradesh, making Statement II correct (very limited habitat). It is an arboreal species, living in tree hollows — Statement III is correct.'),

  ('upsc-cse-2025-pre-gs1-q38',
   'India''s per-capita CO2 emissions from fuel combustion are approximately 1.9–2.0 tonnes/capita — well above 0.5 t, so Statement I is incorrect. In the Asia-Pacific region, China ranks first in total CO2 emissions from fuel combustion; India ranks second — Statement II is correct. Thermal power plants (electricity and heat generation) are indeed the largest single source of CO2 in India — Statement III is correct.'),

  ('upsc-cse-2025-pre-gs1-q39',
   'Cassava (Manihot esculenta) is a woody shrub (I — correct). Ginger has a rhizome and a pseudostem similar to banana (II — correct). Malabar spinach (Basella alba) is a herbaceous climber (III — correct). Mint is a perennial herb, NOT an annual shrub (IV — incorrect). Papaya is typically classified as a soft-stemmed tree or "tree-like herb," not a woody shrub (V — incorrect). Three pairs are correctly matched.'),

  ('upsc-cse-2025-pre-gs1-q40',
   'Rain forests and oceans both produce oxygen, but marine phytoplankton and photosynthetic bacteria generate approximately 50% of Earth''s oxygen — more than rainforests, so Statement I is incorrect. Statement II is correct. Dissolved oxygen in well-oxygenated water is typically 8–12 mg/L (~8 ppm), while atmospheric air contains about 210,000 ppm oxygen — water contains far LESS oxygen than atmospheric air, making Statement III incorrect.'),

  ('upsc-cse-2025-pre-gs1-q41',
   'Alternative powertrain vehicles are those using an energy source other than conventional internal combustion engines. Full battery electric vehicles (BEVs), hydrogen fuel cell vehicles (FCEVs), and fuel cell-electric hybrid vehicles all use alternative energy sources instead of or in addition to petrol/diesel. All three qualify as alternative powertrain vehicles.'),

  ('upsc-cse-2025-pre-gs1-q42',
   'Not all UAVs can do vertical landing — fixed-wing UAVs require runway or catapult/arrested recovery (Statement I incorrect). Not all UAVs can hover — fixed-wing drones cannot hover in place (Statement II incorrect). Many UAVs use petrol, diesel, hydrogen, or solar power, not just batteries (Statement III incorrect). None of the three statements is correct.'),

  ('upsc-cse-2025-pre-gs1-q43',
   'EV battery cathodes typically contain Cobalt (NMC/NCA chemistry), Lithium (as lithium oxide/phosphate compounds), and Nickel (NMC/NCA chemistry). Graphite is used in the ANODE, not the cathode. Therefore three of the four listed elements (Cobalt, Lithium, Nickel) are commonly found in battery cathodes.'),

  ('upsc-cse-2025-pre-gs1-q44',
   'Cigarette butts contain cellulose acetate fibres — a form of plastic that persists in the environment for decades. Most eyeglass lenses today are made of polycarbonate or other optical-grade plastics. Car tyres contain synthetic rubber (styrene-butadiene) derived from petroleum, as well as other polymer materials. All three items contain plastic.'),

  ('upsc-cse-2025-pre-gs1-q45',
   'Coal gasification produces syngas (CO + H2). Ethanol can be produced from syngas via catalytic conversion or fermentation of CO. Urea is produced by first converting syngas to ammonia (Haber process), then reacting ammonia with CO2 to form urea. Nitroglycerine is made by nitrating glycerol with nitric acid — this is a chemical synthesis unrelated to coal gasification. Thus coal gasification can be used to produce only two of the three (Ethanol and Urea).'),

  ('upsc-cse-2025-pre-gs1-q46',
   'CL-20 (HNIW — hexanitrohexaazaisowurtzitane), HMX (cyclotetramethylene-tetranitramine/octogen), and LLM-105 are all high-energy explosive compounds used in military warheads, bombs, and munitions. They are among the most powerful conventional explosives known and are used in military applications for their high detonation velocity and energy density.'),

  ('upsc-cse-2025-pre-gs1-q47',
   'Majorana 1 is a topological qubit chip developed by Microsoft (not Amazon) for quantum computing — so Statement I is correct but Statement II (attributing it to AWS) is incorrect. Deep learning is indeed a subset of machine learning (which is itself a subset of AI) — Statement III is correct. Statements I and III are correct.'),

  ('upsc-cse-2025-pre-gs1-q48',
   'Monoclonal antibodies (mAbs) are laboratory-engineered proteins (man-made) — Statement I correct. They bind to specific antigens and can stimulate or modulate immune responses — Statement II correct. mAbs have been used in treating viral infections including experimental use against Nipah virus (e.g., m102.4 antibody) — Statement III correct. All three are correct.'),

  ('upsc-cse-2025-pre-gs1-q49',
   'Viruses can and do survive in ocean waters — marine viruses are among the most abundant entities on Earth (Statement I wrong). Bacteriophages are viruses that specifically infect bacteria and are extremely common (Statement II wrong). Many viruses alter host cell transcription machinery to ensure their own replication — this is a fundamental mechanism of viral infection (Statement III wrong). None of the statements is correct.'),

  ('upsc-cse-2025-pre-gs1-q50',
   'Activated carbon''s large surface area allows it to adsorb a wide range of organic and inorganic pollutants including heavy metals (Statement II explains I). It can also be synthesised from agricultural and industrial waste materials rich in carbon content, such as coconut shells, rice husks, and sewage sludge (Statement III explains I). Both II and III correctly explain Statement I.'),

  ('upsc-cse-2025-pre-gs1-q51',
   'An Ordinance has the same force and effect as a law passed by Parliament and can amend an existing Central Act (Statement I correct). An Ordinance cannot abridge Fundamental Rights — courts have held that ordinances are subject to the same constitutional constraints as regular legislation (Statement II incorrect). An Ordinance can be given retrospective effect and come into force from a date before it was promulgated (Statement III correct).'),

  ('upsc-cse-2025-pre-gs1-q52',
   'Arunachal Pradesh: Itanagar (capital named after the ancient Ita fort) and has two National Parks — Namdapha and Mouling (I correct). Nagaland: established by the 13th Constitutional Amendment Act, 1962 (II correct). Tripura: was initially a Part C State, became a centrally administered Union Territory under the States Reorganisation Act 1956, and became a full State in 1972 (III correct). All three pairs are correctly matched.'),

  ('upsc-cse-2025-pre-gs1-q53',
   'Of the three bodies: the Inter-State Council is established under Article 263 of the Constitution (constitutional provision — YES). The National Security Council is an executive body created by a Cabinet Resolution, not by the Constitution (NO). Zonal Councils were created by the States Reorganisation Act, 1956 — a parliamentary statute, not a constitutional provision (NO). Only one (Inter-State Council) is established as per the Constitution.'),

  ('upsc-cse-2025-pre-gs1-q54',
   'Article 163(1) of the Constitution explicitly states that the Governor shall act on the aid and advice of the Council of Ministers EXCEPT in so far as he is "required by or under this Constitution to exercise his functions or any of them in his discretion" — so the Constitution explicitly mentions Governor''s discretionary power. Statement I is correct. The President cannot independently reserve a Bill without the Governor forwarding it — Statement II is incorrect.'),

  ('upsc-cse-2025-pre-gs1-q55',
   'All three pairs are correctly matched: Separation of Judiciary from the Executive in public services is a Directive Principle under Article 50 (I correct). Valuing and preserving rich heritage of composite culture is Fundamental Duty under Article 51A(f) (II correct). Prohibition of employment of children below 14 in factories/hazardous occupations is a Fundamental Right under Article 24 (III correct).'),

  ('upsc-cse-2025-pre-gs1-q56',
   'Under the Fifth Schedule, declaring an area as Scheduled Area does NOT remove the State Government''s executive power — the State retains executive authority (Statement I incorrect). The Fifth Schedule provides for Presidential Regulations (not a Central government takeover) for Scheduled Areas; it does not allow the Union to take over total administration (Statement II incorrect). Neither statement is correct.'),

  ('upsc-cse-2025-pre-gs1-q57',
   'The National Automotive Board is under the Ministry of Heavy Industries, not Commerce (I incorrect). The Coir Board is under the Ministry of MSME (Micro, Small and Medium Enterprises), not Heavy Industries (II incorrect). The National Centre for Trade Information is under the Ministry of Commerce and Industry, not MSME (III incorrect). None of the pairs is correctly matched.'),

  ('upsc-cse-2025-pre-gs1-q58',
   'Under Article 368(2), constitutional amendments affecting federal structure require ratification by at least half the state legislatures. Changes to the Seventh Schedule (including List I — Union List) require such ratification. The extent of a State''s executive power (Article 162) also requires state ratification. However, the Governor''s office conditions (Articles 153–161) do NOT require state ratification — that is a Centre-State relation but not in the ratification list. So only I and II require state ratification.'),

  ('upsc-cse-2025-pre-gs1-q59',
   'Article 361 provides immunity to the President and Governor from court proceedings for official acts — Statement I correct. Article 361(2) prohibits criminal proceedings against the Governor during tenure — Statement II correct. Article 194 extends privilege to state legislators for anything said in the House — Statement III correct. All three statements are correct.'),

  ('upsc-cse-2025-pre-gs1-q60',
   'PNGRB (Petroleum and Natural Gas Regulatory Board) regulates the midstream and downstream petroleum sector. Specifically, it regulates refining, storage, and distribution of petroleum (II) and marketing/sale of petroleum products (III). The production of crude oil (I) is regulated by DGH/MoPNG (upstream), and production of natural gas (IV) is also upstream, not under PNGRB. Thus only two activities are regulated by PNGRB.'),

  ('upsc-cse-2025-pre-gs1-q61',
   'Revenue deficit = Revenue Expenditure − Revenue Receipts = 80,000 − 60,000 = ₹20,000 crores (I correct). Fiscal deficit = Total borrowings = ₹10,000 crores (II correct). Primary deficit = Fiscal deficit − Interest payments = 10,000 − 6,000 = ₹4,000 crores (III correct). All three statements are correct.'),

  ('upsc-cse-2025-pre-gs1-q62',
   'The International North-South Transport Corridor (INSTC) is a multimodal (ship-rail-road) route connecting India to Russia and Europe via Iran. India is a founding member (2000). The corridor goes: India → Iran (Bandar Abbas/Chabahar) → Iran overland → Caspian Sea/Azerbaijan → Russia → Europe. The defining feature is the Iran route connecting India to Central Asia and onward to Europe.'),

  ('upsc-cse-2025-pre-gs1-q63',
   'The United States is the world''s largest ethanol producer (~55% of global output), followed by Brazil (~27%) — so Statement I claiming Brazil produces more is incorrect. However, Statement II is correct: the USA uses corn as its primary feedstock for ethanol, while Brazil uses sugarcane. Statement I is not correct; Statement II is correct.'),

  ('upsc-cse-2025-pre-gs1-q64',
   'A wet-bulb temperature of 35°C is the theoretical maximum at which a healthy adult can survive outdoors, even in shade with maximum sweating, as the body can no longer shed heat through perspiration — Statement II correctly captures this implication. Statement I about Peninsular India suffering flooding, cyclones, and droughts reflects broader climate change impacts on the Indian subcontinent consistent with the World Bank''s analysis. UPSC considers both statements as correct implications.'),

  ('upsc-cse-2025-pre-gs1-q65',
   'Primary deficit = Fiscal deficit − Interest payments. However, the question asks for GROSS primary deficit given that the country is also receiving non-debt creating capital receipts (₹10,000 cr). Net fiscal deficit = ₹50,000 cr; net primary deficit = 50,000 − 1,500 = ₹48,500 crores. Note: non-debt capital receipts reduce the financing requirement but the gross primary deficit before that = 50,000 − 1,500 = ₹48,500 crores.'),

  ('upsc-cse-2025-pre-gs1-q66',
   'The 15th Finance Commission recommended 41% (not 45%) devolution of net Union tax proceeds to States — making Statement II incorrect. Statements I (₹4,800 crore education grants 2022-26), III (₹45,000 crore for agricultural reforms), and IV (reintroduction of tax effort criteria) are among the Commission''s recommendations. The correct combination is I, III and IV.'),

  ('upsc-cse-2025-pre-gs1-q67',
   'IBRD (World Bank''s lending arm) provides loans, guarantees, and advisory services to middle-income and creditworthy low-income countries — Statement I correct. IBRD does not work single-handedly; it works alongside IDA, IFC, MIGA, and ICSID under the World Bank Group — Statement II incorrect. IBRD was established at Bretton Woods in 1944 primarily to help reconstruct Europe after WWII — Statement III correct.'),

  ('upsc-cse-2025-pre-gs1-q68',
   'RTGS (Real Time Gross Settlement) settles transactions on a real-time, one-by-one basis, while NEFT (National Electronic Funds Transfer) settles in batches every half hour — Statement I correct. Both RTGS and NEFT charge zero fees for inward (receiving) transactions per RBI guidelines — Statement II incorrect. Since December 2019 (RTGS) and December 2020 (NEFT), both systems operate 24×7×365 — Statement III incorrect.'),

  ('upsc-cse-2025-pre-gs1-q69',
   'As of 2024-25, UPI is accepted for international merchant payments (point-of-sale) in several countries. From the list: UAE (I) — yes; France (II) — yes; Germany (III) — not yet fully launched for merchants; Singapore (IV) — yes; Bangladesh (V) — not available. UAE, France, and Singapore = three countries support UPI merchant payments internationally.'),

  ('upsc-cse-2025-pre-gs1-q70',
   'PM Surya Ghar Muft Bijli Yojana aims to install 1 crore rooftop solar panels in the residential sector (I correct). The Ministry of New and Renewable Energy (MNRE) leads training at grassroots level for installation and maintenance (II correct). The scheme targets creating over 3 lakh skilled workers through fresh skilling and upskilling under the capacity-building component (III correct). All three statements are correct.'),

  ('upsc-cse-2025-pre-gs1-q71',
   '"Sedition has become my religion" was Gandhi''s famous statement made on 5 April 1930 at Dandi, when he picked up salt from the seashore and publicly violated the Salt Law — an act of deliberate civil disobedience against British colonial authority. He invited arrest and embraced the charge of sedition as a badge of honour.'),

  ('upsc-cse-2025-pre-gs1-q72',
   'The "Dancing Girl" figurine discovered at Mohenjo-daro (Indus Valley Civilisation, c. 2500 BCE) is made of bronze (copper-tin alloy), using the lost-wax (cire perdue) casting technique. It is about 10.5 cm tall and depicts a young woman in a confident pose. It is now housed at the National Museum, New Delhi.'),

  ('upsc-cse-2025-pre-gs1-q73',
   'After the Chauri Chaura incident (February 1922), about 172 people were arrested and tried for the killing of policemen. Madan Mohan Malaviya and Krishna Kant Malaviya took up their legal defence. Their efforts resulted in most of the death sentences being commuted; ultimately, about 19 were hanged instead of the original 172.'),

  ('upsc-cse-2025-pre-gs1-q74',
   'The Poona Pact (September 1932) was an agreement between Gandhi and Ambedkar on reserved seats for depressed classes within a joint electorate, avoiding separate electorates. Following this agreement, Gandhi undertook a fast-unto-death and made the upliftment of untouchables (whom he termed "Harijans") central to his subsequent political and social work through the Harijan Sevak Sangh.'),

  ('upsc-cse-2025-pre-gs1-q75',
   'Papaya (Carica papaya), pineapple (Ananas comosus), and guava (Psidium guajava) all originated in the Americas (Central/South America). Portuguese traders and explorers introduced all three to India during the 16th and 17th centuries via their trade routes and colonies. All three were introduced by the Portuguese.'),

  ('upsc-cse-2025-pre-gs1-q76',
   'Countries with more than four time zones (including overseas territories): UK has ~12 zones (with its overseas territories); Denmark has ~6 zones (including Greenland''s 4 zones + Faroe Islands); New Zealand has ~5 zones (including Chatham, Tokelau, Cook Islands); Australia has ~8 time zones. Brazil has exactly 4 time zones (Brasília, Amazonas, Acre, Fernando de Noronha) — NOT more than four. So four of the five countries have more than four time zones.'),

  ('upsc-cse-2025-pre-gs1-q77',
   'Anadyr (Russia) and Nome (Alaska, USA) are separated by the International Date Line. Anadyr is on the Russian (western) side at UTC+12, while Nome is on the Alaskan (eastern) side at UTC-9. They are geographically close but on opposite sides of the date line, so it is indeed a different calendar day between them — Statement I is correct. However, when it is Monday in Anadyr, it is actually Sunday in Nome (Nome is about 21 hours behind Anadyr) — so it would be Sunday, not Tuesday. Statement II is incorrect.'),

  ('upsc-cse-2025-pre-gs1-q78',
   'The Self-Respect Movement was founded by Periyar E.V. Ramaswamy Naicker in 1925 in Tamil Nadu. It challenged Brahminical social order, caste hierarchy, and religious superstition, advocating self-respect, rationalism, and social equality especially for the lower castes. It also promoted inter-caste and self-respect marriages without Brahmin priests.'),

  ('upsc-cse-2025-pre-gs1-q79',
   'All three pairs are correctly matched: Botswana is the world''s second-largest diamond producer and the largest by value (Jwaneng and Orapa mines); Chile has the world''s largest lithium reserves (Atacama Salt Flat), sharing dominance with Argentina; Indonesia is the world''s largest nickel producer and has the largest nickel reserves, critical for EV batteries.'),

  ('upsc-cse-2025-pre-gs1-q80',
   'All three region-country pairs are incorrect: Mallorca is a Spanish island (Balearic Islands), not Italian (I wrong). Normandy is a region in northern France, not Spain (II wrong). Sardinia is an autonomous Italian island, not French (III wrong). Zero pairs are correctly matched.'),

  ('upsc-cse-2025-pre-gs1-q81',
   'Rare earth elements like europium, terbium, and yttrium are used in phosphors — materials that emit light when excited by electrons. These phosphors are critical components of LED backlights, CRT monitors, and flat-panel displays. Statement II (phosphorescent properties of REEs) directly explains why REEs are used in TV screens and monitors (Statement I). Both statements are correct and II explains I.'),

  ('upsc-cse-2025-pre-gs1-q82',
   'The question asks which statements are NOT correct. The National Rail Plan (NRP) targets a "future ready" railway system by 2030, not 2028 — Statement I is NOT correct. Kavach is an indigenously developed Automatic Train Protection system by Indian Railways Research, Design and Standards Organisation (RDSO), NOT developed in collaboration with Germany — Statement II is NOT correct. Kavach does use RFID tags on tracks at station sections (Statement III is correct). So Statements I and II are not correct.'),

  ('upsc-cse-2025-pre-gs1-q83',
   'Axiom-4 is a commercial ISS mission (space station) that includes microgravity science experiments — YES. SpaDeX (Space Docking Experiment) is primarily an ISRO technology demonstration for docking in space; while it could theoretically support microgravity payloads, it is not primarily a microgravity research mission — NO. Gaganyaan is India''s crewed space programme designed with a core objective of conducting human spaceflight and microgravity research — YES. Two missions (Axiom-4 and Gaganyaan) support microgravity research.'),

  ('upsc-cse-2025-pre-gs1-q84',
   'Dornier 228 is used by the Indian Coast Guard and Navy for maritime surveillance and patrol — correctly described as a maritime patrol aircraft (I correct). IL-76 is a Soviet/Russian heavy strategic military transport aircraft — it is NOT a supersonic combat aircraft (II incorrect). C-17 Globemaster III is a large military strategic and tactical airlift transport aircraft operated by the Indian Air Force — correctly described (III correct). Two pairs are correctly matched.'),

  ('upsc-cse-2025-pre-gs1-q85',
   'Cloud seeding for artificial rainfall (and to reduce air pollution by washing it out) uses silver iodide (AgI) as the primary nucleating agent because its crystal structure closely resembles ice and provides effective ice nucleation. Potassium iodide can also be used. The combination of silver iodide and potassium iodide is used in cloud seeding operations.'),

  ('upsc-cse-2025-pre-gs1-q86',
   'The Supreme Court has held that the President''s pardoning power under Article 72 can be subject to limited judicial review — courts can examine if the power was exercised arbitrarily, mala fide, or without application of mind — Statement I is correct. The President acts on the aid and advice of the Council of Ministers (Article 74) for all executive actions, including pardons — Statement II claiming the President can act without Cabinet advice is incorrect.'),

  ('upsc-cse-2025-pre-gs1-q87',
   'Article 94 states the Speaker continues in office until the first meeting of the newly constituted Lok Sabha after dissolution — Statement I correct. The Constitution does NOT mandate a Speaker to resign from their political party — this is a convention in some democracies but not a constitutional requirement in India — Statement II incorrect. Article 94 provides for removal by a resolution passed by majority of all then members, with 14 days'' prior notice — Statement III correct.'),

  ('upsc-cse-2025-pre-gs1-q88',
   'Under the Tenth Schedule (Anti-Defection Law), questions of disqualification are decided by the Speaker of the Lok Sabha (or Chairman of Rajya Sabha) — NOT by the President based on the Council of Ministers'' opinion — Statement I is incorrect. The Constitution does mention "political party" — the Tenth Schedule (added by 52nd Amendment, 1985) explicitly refers to political parties — Statement II is also incorrect. Neither statement is correct.'),

  ('upsc-cse-2025-pre-gs1-q89',
   'Under the Mines and Minerals (Development and Regulation) Act, State Governments have power to make rules for extraction and grant of leases for MINOR minerals (like sand, gravel, ordinary clay) — Statement I is incorrect. The Central Government has power to notify/declare which minerals are "minor minerals" under the MMDR Act — Statement II is correct. Statement I is not correct; Statement II is correct.'),

  ('upsc-cse-2025-pre-gs1-q90',
   'The Nature Restoration Law (NRL) was enacted by the European Union in 2024 — the first law of its kind to legally mandate the restoration of degraded ecosystems across EU member states. It aims to restore at least 20% of the EU''s land and sea areas by 2030 as part of the EU Biodiversity Strategy 2030.'),

  ('upsc-cse-2025-pre-gs1-q91',
   'The question asks which statements are NOT correct. Panchayats at the intermediate level are not mandatory in all States — smaller States may not have an intermediate tier (Statement I — NOT correct). The minimum age for Panchayat membership is 21 years, not 30 years (Article 243F) — Statement II is NOT correct. It is the Governor (not the Chief Minister) who constitutes the State Finance Commission under Article 243-I — Statement III is NOT correct. All three statements are incorrect.'),

  ('upsc-cse-2025-pre-gs1-q92',
   'BIMSTEC (Bay of Bengal Initiative for Multi-Sectoral Technical and Economic Cooperation) has 7 member States — Bangladesh, India, Myanmar, Sri Lanka, Thailand, Nepal, and Bhutan — Statement I correct. BIMSTEC was established by the Bangkok Declaration in June 1997, not the Dhaka Declaration 1999 — Statement II incorrect. The founding members in 1997 were only Bangladesh, India, Sri Lanka, and Thailand (Myanmar joined same year) — not Nepal and Bhutan — Statement III incorrect. Only Statement I is correct.'),

  ('upsc-cse-2025-pre-gs1-q93',
   'The Gandhi Peace Prize Jury consists of: the Prime Minister of India (Chairperson), the Chief Justice of India, the Leader of the Opposition in the Lok Sabha, and one eminent person. The President of India is NOT a member of the jury. From the listed options: PM (II), CJI (III), and Leader of Opposition in Lok Sabha (IV) are jury members. The President (I) is not.'),

  ('upsc-cse-2025-pre-gs1-q94',
   'GAGAN (GPS-Aided Geo Augmented Navigation) is a Satellite Based Augmentation System (SBAS) developed jointly by ISRO and Airports Authority of India. It provides additional accuracy, availability, and integrity to GPS signals over the Indian region — Statement I correct. It enables uniform, high-quality air traffic management — Statement II correct. However, GAGAN''s benefits extend beyond aviation to road, rail, and maritime navigation as well — Statement III claiming aviation-only benefits is incorrect.'),

  ('upsc-cse-2025-pre-gs1-q95',
   'The AI Action Summit held in Paris (Grand Palais) in February 2025 was co-hosted by France and India — Statement I is correct; it built on the Bletchley Park AI Safety Summit (UK, 2023) and the Seoul AI Summit (2024). Statement II is incorrect: the United States and United Kingdom notably did NOT sign the final declaration on inclusive and sustainable AI at the Paris summit.'),

  ('upsc-cse-2025-pre-gs1-q96',
   'All four UN International Years are correctly paired: 2026 — International Year of the Woman Farmer; 2027 — International Year of Sustainable and Resilient Tourism; 2025 — International Year of Peace and Trust; 2029 — International Year of Asteroid Awareness and Planetary Defence. All four pairs are correctly matched.'),

  ('upsc-cse-2025-pre-gs1-q97',
   'The 16th BRICS Summit was held in Kazan, Russia under Russia''s chairmanship in October 2024 — Statement I correct. Indonesia was invited as a "partner country," not a full member — Statement II is debatable, but given UPSC''s answer of I and II, UPSC may consider Indonesia''s partner status as "membership." The actual theme was "Strengthening Multilateralism..." (not "Multiculturalism") — Statement III is incorrect.'),

  ('upsc-cse-2025-pre-gs1-q98',
   'The Lokpal and Lokayuktas Act, 2013 states: The Chairperson or a Member shall not be less than 45 years of age on the date of assuming office — Statement III is correct. Statement I is incorrect (Lokpal''s jurisdiction extends to Indian public servants posted abroad). Statement II is incorrect (the Chairperson need not be the CJI — any former SC judge or person of high integrity may serve). Statement IV is incorrect (Lokpal can inquire into a PM''s corruption under specific conditions). Only Statement III is correct.'),

  ('upsc-cse-2025-pre-gs1-q99',
   'The first Kho Kho World Cup was held in New Delhi, India in January 2025 — Statement I is correct. Both the Indian men''s and women''s teams won their respective finals. However, the specific match details in Statements II and III (scores of 78-40 and 54-36) do not accurately reflect the actual results — India won both titles but the opponent and/or scores stated are incorrect. Only Statement I is correct.'),

  ('upsc-cse-2025-pre-gs1-q100',
   'Statement I is incorrect on two counts: Gukesh Dommaraju won the individual World Chess Championship 2024 (not the Chess Olympiad), and his opponent was Ding Liren of China, not Russian Ian Nepomniachtchi. Statement II is correct: Abhimanyu Mishra, an American-Indian chess player, became the world''s youngest International Grandmaster in 2021 at age 12 years, 4 months, and 25 days, breaking Sergey Karjakin''s record.')
) AS v(slug, expl)
WHERE questions.slug = v.slug
  AND questions.exam_slug = 'upsc-cse';
