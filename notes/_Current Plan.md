
**Research proposal (21.4)**

Fluorescence microscopy to investigate the co-localization preferences of *Pa* and *Sa* in agar-plate colonies.

(1) Optimizing a protocol for detecting microcolony heterogeneity.

- Media optimization for imaging clarity. Possible parameters include agarose concentration, media thickness, the material of the imaging plate, and humidity control. For end-point imaging only.

- Fluorescent marker stability. Growth curves of strains bearing fluorescent proteins in media lacking antibiotics for selective markers. Would include optimizing for fluorescent protein excitation/emission spectra.

- Coculture stability. Ensure CFU ratios between *Pa* and *Sa* in the inoculum are similar to the colony after incubation. Essentially a growth curve. Key parameters include ratios of inoculation (*Pa*:*Sa*, 1:1 , 10:1 , 100:1) and time of culture (PAO1/14 16h, LESB58 ? days.)

- Fluorescent marker visibility. Selection for an emission/excitation spectra that gives a high-resolution microscope image. Needs to overcome media autofluorescence, media refraction, and signal separation (I.E., GFP vs FarRed.)

The key control is the use of different strains: *Pa* PAO1 & PA14 should overgrow *Sa* USA300 at lower inoculums than the slower-growing *Pa* LESB58.

(2) Finding some genetic and chemical determinants of microcolony heterogeneity.

- Gene identification. Read, then propose mechanisms for how genes Deb identified in her transposon library screen for co-culture stability could impact *Pa* and *Sa* co-localization. Ensure genes have no known effects on co-localization.

- Fluorescent strain manufacture. Transform transposon mutants in the genes of interest with plasmids carrying fluorescent proteins (*Sa* red, *Pa* green.)

- Localization impact. Look at coculture stability of the transposon mutants as compared with the wild-type strain. Detect changes in strain competition by counting CFUs and comparing *Sa* and *Pa* ratios before and after incubation. Detect finer ecological patterning by comparing localization patterns between wild-type and transposon-mutant cells.

The key control is the use of mutants in genes with established impacts on microcolony co-localization.

(3) Piecing together a timeline of when genes become important for *Pa* and *Sa* cocultures.

- Following chemical/mechanical abrogation (treatment). The 'elasticity' of strains when re-establishing biofilm patterning after the disruption of biofilm structure. Chemical abrogation could be achieved by adding drops of chemicals onto the biofilm directly (surfactants, anti-biofilm-production drugs.) Mechanical abrogation could be mixing of the biofilm using a sterile pipette tip. Genes could contribute to biofilm formation by reducing disorganization directly (biofilm structuring) or increasing tolerance to disorganization (*Sa* protective stress mechanisms from *Pa* exposure.) Which genes help *Pa* and *Sa* form resilient and self-recovering biofilms?

- Mutant emergence. Mutants could aggregate differently with partner strains, but why exactly will be uncertain from co-culture experiments alone. A higher resolution is possible with tri-culture: using the wild-type, mutant and partner species. Where the wild-type and mutant localize relative to the partner species could give more information on the gene's contribution to cell localisation. Visualisation would need a construct carrying a third fluorescent protein (blue) to identify the third strain. How do novel phenotypes physically spread through a polymicrobial colony?

 - Invasion preferences. A parallel case for biofilm development where *Sa* is allowed to form a monomicrobial biofilm before wild-type *Pa* or mutant *Pa* is introduced. Biofilm invasion would be measured by fluorescent microscopy and CFUs as before. The context is invasion of *Pa* into *Sa* biofilms is part of the species succession in the lungs of younger CF patients. Which genes help *Pa* overtake *Sa* growth?

Controls as appropriate for each experiment.

---

**Earlier drafts**

Overall aim: investigate the genetic/chemical determinants of microcolony heterogeneity in *Pa* and *Sa*.

I aim to work through this problem in 3 steps.

*More thoughts*
- 'Preferences'

(1) Aim: to optimize a protocol for detecting agar-plate microcolony heterogeneity.

The first phase builds an experimental pipeline. I'll use the PA14, PAO1, and LESB58 strains as they have well-characterized interactions with *Sa* USA300. I'd expect PAO1 and PA14, but not LESB58, to outgrow *Sa* over 16 hours. I can measure growth of *Pa/Sa* by imaging colonies for fluorescent proteins and I can also count CFUs. I'd want to benchmark the media components, agar thickness, and inoculum ratio for future experiments.

I hope to finish optimization before May.

(2) Aim: to identify genetic factors that can change microcolony heterogeneity.

The second phase iterates my optimized protocol. Every week I'll try run though a pipeline:
- Find a gene in *Pa* or *Sa* that could mediate co-localization (data sources in order of relevance: Deb's biofilm coculture transposon library screen, upcoming murine TnSeq data, literature)
- Read about the corresponding metabolic pathway to find a chemical/drug that can mirror or compliment the knockout-strain's phenotype.
- Transform the corresponding mutant from our transposon-library with a GFP/FarRed-producing plasmid.
- Run coculture plates for counting CFUs and imaging. Perform with or without the compliment as appropriate.
- Measure species proportions (cell growth/death after CFUs) and microcolony patterning (GFP/Red intermixing).
- Assign the gene at least one ecological mode - does the gene promote colony heterogeneity or maybe overgrowth of the partner species?

I only need to collect enough data to support 4 mutant/treatment phenotypes: increased species intermixing, decreased species intermixing, increased species competition, and decreased species competition. For *Pa* and *Sa* combined this could be as few as 8 mutants but could be substantially more.

(3) Aim: to piece together a timeline of ecological states during agar-plate biofilm development.
Consider *Pa* and *Sa* ecological preferences.

The final phase combines the mutants/chemicals I identified in my screen to put together an order of ecological preferences for *Pa/Sa*. If I can disrupt ecological transitions (for example *Pa* and *Sa* are forced to co-localize) then I can see how *Pa/Sa* interact when they do not co-localize appropriately to stress. Two experimental options:

- Tri-culture against wild-type *Pa* AND *Sa* with the transposon mutant. (*Pa* green, *Sa* red, mutant colourless).
- Treating mutants that cannot make an ecological transition with a chemical that forces an ecological transition. Two sub-strategies: use mutants that force a particular co-localization, or use mutants lacking the ability to co-localize as the wild-type strain would following chemical treatment (knockout of the bacteria's 'backup plan').

I would like to push for at least one experiment of this complexity - even if I feel these are overkill for a Master's thesis (or even a PhD) they'd make for a great way to get a meaningful conclusion from my 'phase 2' screen.

[plan-summary-diagram]

*Your biggest criticism*
The hardest part about ecological problems is finding a decent measurement. I haven't written much about what I'll measure as I haven't thought-of/found any applicable theory - it's a very tricky balance between stochastic realism and idealistic abstraction. Even if I never find the perfect theorem, there's not a huge risk because we only need distinct pictures (showing species ratios, maybe species intermixing) and not necessarily statistical modelling.

I'll explain my problem a little more... Let's reimagine the above as if we were tracking an unknown species: (1) confirms that our 'field-tools' are working correctly. (2) logs all the different kinds of 'footprints' that could be left on an agar plate under particular conditions. (3) asks what would happen if we were to take our 'animal' into an unfamiliar environment.
We are searching for the 'footprint' of an abstract ecological 'animal'. What we do when we change strains/media composition is we change the environment that ecological phenomena can manifest. Our core experimental model may rely on mutants, but our measurements are abstract patterns.

As an example:
A fractal 'footprint' must have an underlying fractal process (or reason for being fractal-like.) I know some types of fractal can be made by an 'expanding' force and a concentric 'repelling' force. I could ask whether a gene causes cells to grow outwards, or why cells move away from isogenic neighbours. If we take a mutant in a gene involved in self-recognition (quorum-sensing, for example) then we'd expect the fractal pattern to no longer manifest. I could also ask if we can control how large the fractal pattern can become, or how often fractal patterns happen in an agar-plate colony.

*Some notes on confounding*
(1) History of strain coexistence. Have PAO1, PA14, or LESB58 come from polymicrobial wounds or like settings?