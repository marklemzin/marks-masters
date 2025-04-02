
*Experimental overview*

A summary of the longer section below ('*Brainstorm*'):
- Species interact at least 4 ways (even all 4 ways simultaneously,) and there are macroscopic patterns associated with each.
- Genes will have functions that can be grouped by what ecological state they promote.
- Species in a biofilm are not thought to be 'ecologically neutral' and there is almost always some kind of ecological state.

Putting everything together it makes sense to say that we can 'visualize' gene functionality at a macroscopic level. What can we do with this?

The first step is to look at what experimental factors determine microcolony shape. Factors could include experiment variables: inoculum density, inoculum ratio (see [Deb's review](https://pubmed.ncbi.nlm.nih.gov/33576132/)), agar concentration, and media nutrients, *but* could also be extended to genetic variables. An early assay should look at how different strains behave. We'd compare between how LESB58, PAO1, PA14 grow in the context of LAC300 to get a big picture of which genes determine microcolony patterning. I haven't looked at what differs between the *Pseudomonas* reference strains, but I've heard that PAO1 and PA14 come from different lineages (the other one was PA7?), and I've heard that LESB58 is part of either the PAO1 or PA14 lineage.

After we have an idea of what the main pattern that *Pa* cells form with *Sa*, whether species are arranged homogenously or heterogeneously - we can then begin to ask which genes are actually responsible. We have a number of tools to help us find such genes correctly: one is from experimental data, the other is from fundamental ecology, and the last is a bacterial collection.

- TnSeq data. When this comes rolling in we'll get a picture of what genes are needed for clinically-relevant biofilms. One caveat is that the cellular microenvironment (metabolically and immunologically speaking) will differ between a mouse to and an agarose plate. The mutant data will still be a good way to filter down the number of possible genes to investigate. I'm sure it'll tie in well to the current literature on *Pa/Sa* interactions.

- Ecological patterning. There are parallels between how genes are distributed, their ecological functionalities, and how cells are arranged in biofilms. Key to such a model is 3 parameters: microcolony heterogeneity (species mixing), macrocolony species numbers (*Pa:Sa* ratio), and changes in interspecies dynamics over time. I've just read over Michael's (Michi's?) email and he seemed to be able to look at growth on agar over time - so it's something we could possibly try too. I'll write a commentary soon.

- Mutant library. From what I understand our *Pa* TnSeq library allows us *quickly* to screen many knockout-mutants (Tn-insertion; but we'll assume that they're equivalent) for changes in biofilm patterning. We'd just have to get a plasmid inside the corresponding mutants. I guess that this takes no more than a day for the electroporation and selection. It's by no means high-throughput but it does give us more chances to get a mutant with a really significant phenotype.

After we know which genes are needed for changing the ecological state of a biofilm we can look at how such genes can affect a clinical infection. For our agar plate-based experimental model it'd be best to look at treatments that can be spotted onto the colony directly. We could continue to follow the biofilm post-treatment (which can later be harvested for CFUs, or other more invasive assays.) I'm not sure which antimicrobials would have the strongest effect on biofilm heterogeneity at sub-MIC concentrations.

We could try some of our antibiofilm-peptides if we know that cells cooperate by contributing exotic components to the EPS. Treatment would chemically-abrogate one incentive for cells to co-operate. In other words, the treatment would align with the ecology of the biofilm. But abrogation of one function is rarely enough to outright eradicate cells. We could try to create mutants that lack a function which creates an extra window of susceptibility to eradication. Which genes should such mutants lack?

Let's say that a pair of species are mutualistic for biofilm production. Each makes a unique product that contributes to biofilm maturity. There are a couple of mutants to consider in this scenario:

(A) a synergy between a mutant for biofilm-production and an anti-biofilm peptide will be at most additive rather than synergistic. Both drug and mutation abrogate the same ecological component.

(B) a synergy between a mutant for *post-treatment recovery* and an anti-biofilm peptide can outright eradicate populations. If an anti-biofilm peptide disrupts the EPS barrier that keeps *Pa* from becoming stressed and producing bactericidal products - then a mutant for an *Sa* product that permits survival despite antagonism from *Pa* is open to a window in which *Sa* is vulnerable to *Pa*.

We know that something like HQNO from *Pa* inhibits the *Sa* ETC, so we could screen an *Sa* mutant that has defects in its respiration for a lack of response to *Pa* under regular circumstances and death following treatment with a drug that causes *Pa* to overproduce HQNO.

*Editor's note: this is a poor example. You tested this as part of the DJK5/Col paper and found no difference in killing. Still, it illustrates my point.*

The idea is to knock out the bacteria's backup plan. When a drug causes cells to be forced into a different environment species need to have a set of genes that restore them to their former equilibrium. Disruption of these genes means that treatments can become lethal after they are stopped so long as (1) species are brought into a different ecological state (2) species cannot return to a stable ecological state.

The treatment must disrupt *Pa* and *Sa* cell localization in the biofilm. Our best bet would be an anti-biofilm peptide. I've been reading our [Colistin/DJK-5 paper](https://www.nature.com/articles/s41522-024-00637-y), it doesn't look like we have a clear mechanism of killing. It's not due to HQNO and may have something to do with membrane disruption - but the membrane disruption could just be an indicator of cell death.

One completely different perspective would be to see how cells behave after the loss of DJK-5/Colistin but after the disruption of cellular colocalization. If *Pa* and *Sa* are forced into a certain space, are they able to survive after the Colistin/DJK-5 stressors are lost from the media?

*Practicalities*

In the very short term I'd like to get started with a literature review. I'm going to be going to my first training session with the confocal this Thursday (3.4.25) - all that is in my research pipeline already. We'll only need to find out what sort of plate can be used with the Fenix microscope. I bet that Michael can help us find a solution.

My review's sections would discuss:

- Strain characteristics
- Fundamental ecology
- *Pa-Sa* relationships (in an ecological lens: antagonism, parasitism, predator/prey, and mutualism)
- Methods of investigating biofilms (justifying agar-plate colonies - need to compare with microscope-slide, liquid well, and flow-cell models)
- Measuring localization (how something we see macroscopically can be genetically/mathematically determined)
- Biofilm disruption (peptide MoA)

The last three sections would not focus on *Pa* and *Sa* specifically as there are few papers looking into how *Pa* and *Sa* co-localize. I have a feeling that I'll be writing a lot about the basis of macroscopic biofilm structures (in the 'measuring localization' section probably) and think that this section would make for a great review for publication. In my writing below I discuss a paper on biofilm structure that becomes much more interesting when re-interpreted ecologically - take a look!

*Brainstorm*

*Editor's (a retrospective Mark) comments: this is a bunch of mis-matching thoughts that I've assembled into a patchwork of theory. My 'technique' for coming up with something to do starts by taking a simple concept and bringing it out to an absurd conclusion. I begin with a concept of cellular heterogeneity and extend it out to predicting biofilm functions. The relevant experimental material will be kept in the experimental plan above. I don't feel that what follows is important enough to be read in detail, but if you are interested in the reason behind my choices, I think what follows covers my perspective well. I hope it will help me handle upcoming experiments well.*

*Sa is an abbreviation for Staphylococcus aureus. Pa is an abbreviation for Pseudomonas aeruginosa.*

Within the same prokaryotic cell gene products cannot always touch one another and 'signalling cascades' can be spatially limited. The same idea applies at a macromolecular level where gene products cannot always freely travel in-between cells. It follows that cell-to-cell interactions (such as those found in a biofilm environment) could also be dependent on space: how close and how far cells are, from one species to the other, can affect trans-cellular signalling.

In such an ecological model it is impossible to think of biofilms as a uniform macro-organism. When we ignore spatial dynamics it is normal to think of biofilms as an ecological 'black box.' There are inputs and outputs like an enzymatic machine (in go nutrients, out goes biomass) which change along an ecological gradient. Biofilms may act as a well-oiled machine, and with a certain Darwinian optimism may even be thought to be on a trajectory (evolutionary) towards acting energetically optimally. But are there alternative perspectives, perhaps?

I propose that in a complex ecological model that there can be pockets of evolutionary stagnation. Imagine that a cell enters an equilibrium with another. The participating genes coevolve and both sides gain an optimized function. But there is a cost, as this novel function becomes situational; a function that is active only when the gene product is in proximity to its partner. Such a specialization can with even a slight change in the host cell's surroundings become evolutionarily backwards.

The nature of adaptation over time however is not a core component of ecology. What is instead relevant is how cells behave when they *sense* their environment. Instead of thinking about evolutionary trajectories we can think of expansionist phenotypes. Instead of thinking about evolutionary checkmates we can think of interspecies equilibria. And genes don't need to 'co-adapt' to have spatially-restricted behaviour. Cells have never feasibly evolved in isolation. They are well-adapted to both the current environment of the Earth and to the cells that coinhabit the Earth. So I do not feel that it is a coincidence or some evolutionary fate that two partner species will almost always have some degree of genetically-driven interaction.

Let me take a step back again - cells can be thought of as a unification of genes. Isn't it strange that genes are split across many different species when they could be part of a greater super-organism? That parts of the genes, like parts of a greater evolutionary machine are strewn between cells,, when they could be part of a single being? Such a thought is not entirely a fantasy. Genes can be producers of many metabolites or other extracellular particle, which have a role beyond the cell's barrier-like membrane.

*A thought for Sam. Can we think of cells as being assembled from pre-determined-genes like how we know the pool of cards in a rogue-like game? Do genes exist before they are made?*

Cells - crucially need at least two distinct functions (as opposed to only 1 essential function, when taking an evolutionary perspective) to participate in ecological interaction:
(1) a consumer module: a gene product that can respond to extracellular stimuli.
(2) a producer module: a gene product that can change the cell's extracellular environment.
These form the genes needed to create either a positive feedback loop (like a signalling cascade) or a negative feedback loop (I think of it as an equilibrium) in response to an environmental stimuli. The consumer module ('conmod') is there to turn extracellular signals into intracellular cues which the producer module ('prodmod') can perform a response towards.

There is nothing intrinsically ecological about polymicrobial biofilms. Just as well as a a single cell can form a feedback loop so can another species and so can two species form an interconnected loop. With two species I can think of 4 ecological trajectories. For now imagine that cells are simple 'minimum ecological constructs' (MECs; I made this up for convenience) with only one conmod (consumer module) and prodmod (producer module). The conmod is wired to activate the prodmod, which goes on to manipulate extracellular space.

Let's say that two MECs have a matching conmod and prodmod, that they are ecologically indiscriminable. Both MECs respond to the same regulatory signal and both produce a signal that they are both responsive towards. If the background of such MECs is essentially isogenic and both MECs start in equal numbers then neither should overgrow the other. But with even a slight population perturbation one species will begin to overgrow the other. Such a dynamic (between two MECs) is balanced on a single chaotic point which can tip the scales in favour of one MEC like a see-saw carrying slippery weights.

Two identical MECs (conmod/prodmod) have a network that connects cells together I.E. there are matching conmods and prodmods. But as both MECs produce the same product neither MEC has an incentive to cooperate. MECs that are exact opposites (no matching modules) are also insufficient for cooperation. As prodmods and conmods become too different there is less reason for MECs to interact at all. Such MECs have no shared signal so cannot value partner MECs for more than their material components.

Suppose instead there are two MECs but each have a set of mismatching conmods/prodmods. Each conmod/prodmod pair is responsive only to a prodmod product from the partner MEC. Such MECs find a middle ground where signals are distinguishable but also valuable to partners (like an exotic trade good.) Neither MEC can outgrow its partner until the partner's product loses value - such as by finding an environmental nutrient source. It's curious perhaps that such states of 'genetic disorder' are statistically more probable (at least more so than MECs which have only matching conmods and prodmods) so long as modules are free to be distributed between MECs. It's like how two liquids will tend towards perfect heterogeneity when mixed.

But what if such a signal trade is not bilateral but rather only one-directional? Here MECs must be asymmetrically constructed. One MEC takes the role of an independent producer and the 'parasite' MEC leeches products without any kind of reciprocation. Such a system is stable so long as the 'producer' MEC does not outcompete the 'parasite' MEC. Signal trading occurs on a gradient and how much one species receives for how little it invests determines its status, either as a parasite or as a mutualist.

![cell-incentives](https://github.com/marklemzin/marks-masters/raw/main/home-made-diagrams/24.3%20cell-incentives.png)

*Types of feedback loops with two participants. From top to bottom **(A) Indiscriminate equilibrium.** Species are ecologically isogenic, and will overgrow each other when given a growth advantage. **(B) Discriminate gradient.** Species have an asymmetrical gene arrangement, and become hierarchically-dependent. Stable so long as the 'producer' cannot outgrow the 'parasite' species. **(C) Discriminate equilibrium.** Species are mutualistic. Growth cannot be easily decoupled, unless trans-cellular goods lose trade value between organisms. **(D) Indiscriminate gradient.** Cells do not directly interact. Growth is necessarily decoupled.*

*Editor's comments: I've used a couple of terms here that I haven't described elsewhere: 'discriminate/indiscriminate' and 'equilibrium/gradient.' What I mean by 'discrimination' is whether growth of one species is directly coupled to the other. What I mean by 'gradient/equilibrium' is the direction of interaction, whether it is unilateral (a gradient) or bilateral (an equilibrium.)*

Let's forget about MECs (minimal ecological constructs) and return to cells and genes - more familiar concepts. Cells can be thought of as collections of MECs. I believe that every species of cell can form multifaceted relationships. Some parts could lead to fatal interactions where other parts are necessarily mutualistic.

Let's take another step back. In a lab-cultured biofilm environment (agar-plate colony) there are distinct stages in biofilm development: reversible attachment, irreversible attachment, maturation, and dissipation. During this time it well-understood that there is a kind of ecological succession where *Pa* comes to predominate *Sa*. It makes sense that besides species ratios there could be a change in *Pa* and *Sa*'s spatial distribution. As far as I'm aware, an 'ecological perspective' hasn't been much explored in biofilm development, less so in polymicrobial settings, and not at all for *Pa* and *Sa*.

During early stages of biofilm development cells are known to use motility systems such as the flagellum of *Pa* to seek out attachment surfaces. [It's known](https://pmc.ncbi.nlm.nih.gov/articles/PMC6910820/) that *Pa* can direct itself towards *Sa* by process of chemotaxis and attach to the surface of *Sa* cells. The process is something like how ants can follow a pheromone trail. Pioneer *Pa* cells use a pilus to follow a trail of PSMs (*Sa* surfactants) towards the *Sa* colony. Travel after this point is towards a combination of *Sa* and *Pa*. As an ecological interaction it's unclear whether *Sa* gains something from *Pa*'s sudden proximity but this could not be an indiscriminate relationship as *Pa* does move towards *Sa*. What *Pa*'s ecological incentive is is a more complicated question. In a closed system where *Pa* and *Sa* were perfectly co-evolved and where *Sa* does not regrow, it makes little sense that a motility system would exist if it were used to eradicate *Sa*. *Pa* could feed from *Sa* metabolites, or provide a growth factor for *Sa* in exchange for waste-products, or even cull the *Sa* population for nutrients - but *Pa* should not outright eradicate *Sa* lest the pressure to retain motility is lost. While such a model is unrealistic but it does seem to model early biofilm development as there are perspectives that *Sa* is the keystone species in early biofilms. As the biofilm matures the payoff for *Pa* from keeping *Sa* alive could wane for *Pa* so the growth of *Sa* cells is instead repressed.

The paper in the previous paragraph uses a 2-dimensional experimental model. Some very short glass frames are put onto a sterile microscope slide which is then used to cast a very thin layer of agarose gel that has been spiked with nutrients. A drop of culture is placed onto the gel and then 'sandwiched' with a coverslip slide. The slide is kept in a temperature/humidity controlled microscope for up to 8 hours (in methods that I've encountered.) Using high-resolution light microscopy *Pa* and *Sa* can be told apart by morphology alone (rods/cocci).

At the confocal centre we have access to only one PC2 microscope from what I understood from Rob. The '[Opera Phenix High-Content Screening System](https://www.otago.ac.nz/omni/confocal-microscopy/cm-equipment)' has a growth chamber and is able to be used with PC2 organisms. I was showing the slide model to Rob in the context of the paper above and he's since advised me to use it for agar-plate colonies too. The only trouble is that the system requires the shape of the plate to be explicitly defined or that we use a compatible plate (like a 24-well plate, which is not the same as a microscope slide obviously.)

For more developed biofilms it's better to look at static biofilm colonies. We can use fluorescent strains to highlight the key structures of biofilms. *Pa* could form a structure that encapsulates *Sa* for example. At a macroscopic level biofilms of *B. subtilis* have piles that form tunnels which can transport water, like little microbiological aqueducts. Maybe either *Pa* or *Sa* can be part of a macro-cellular transport network.

*Studies with mutants look at an alternate history where something is not present to create a certain biofilm structure.*

Bringing the previous sections together: biofilms can be thought of as many multigenic feedback loops which have spatially-dependent activity. Distance in a biofilm can be thought to be relative as genes have a function based on which gene functions are found in the same locale. With this we can start guessing which genes are in certain types of ecological relationships and subsequently how a gene can be visualized 'macroscopically.'

**Mutualism**

Where species exchange exotic functionalities. Think of this as the evolutionary middle ground. Species must make products that are like each other enough that they are mutually recognizable but not like each other enough that they become commodities. A great example is the extracellular matrix. Both *Pa* and *Sa* are evolutionarily distant but they both use a biofilm as part of their lifestyle. The reasons that both exist may be evolutionarily divergent (as an example, the *Sa* biofilm is geared to towards infections possibly and the *Pa* biofilm is better in more situations maybe) but both are like each other enough that they can form a synergistic matrix.

I think genes that make similar products (like the EPS) are likely to be involved in mutualism. A brief search of polymicrobial interactions or parallels between monomicrobial biofilms should be good to locate more possible mutants to investigate.

**Parasitism**

Could also be thought of as 'opportunism.' One species provides an exotic function to another but the act is not reciprocated. The 'parasite' (often called a 'cheater') may provide a commodity or even repress growth of the 'producer' cell but the 'parasite' shouldn't overtake the growth of the 'producer' in an ecological vacuum.

In terms of genetic segregation this is an odd case out of my 4 scenarios as it needs species to have an asymmetrical distribution of functionalities. The 'parasite' must explicitly have an functional regulator gene and an *unrelated* producer gene. The 'producer' must have a functional regulator gene and a *related* producer gene.

In biological terms this means that one species must control a common signal which the other species can only ever be modulated by. It's a trans-cellular version of the same genetic circuit that makes intracellular feedback loops possible. We could look at genes found in functions where *Pa* or *Sa* could either sense or produce a response to an oncoming stressor which could affect the partner species to some extent. My first guess is that phenol-soluble modulins (PSMs) or any of the *Pa* QS molecules (surfactants mostly but also HQNO) could be a part of a parasitic circuit. Some other gene products to try could be metabolites which are part of a metabolic feedback loop.

*If I had to choose one, I think this one is the most difficult to conceptualize. I'll write about parasitism more later but if a similar pattern occurs at different biological levels (genetic/trans-cellular) I'd guess that cells would be distributed fractally. Think of the 'parasite' like how a fire spreads through a dampened forest or vice-versa.*

**Antagonism**

Where species exchange commodities. Both species behave like cells in a mutualistic relationship but both species produce a signal that is native to all cells anyway. Cells could have to deal with metabolite accumulation (possibly toxic) from both native sources as well as exogenously from the partner cell's metabolism. Evolutionarily speaking the overlap of the *Pa* and *Sa* 'secretomes' would most likely occur at the metabolic level through any of the small-molecule by-products: pH (H+), reduced carbon sources (in an anaerobic biofilm), or reactive-oxygen species.

**Predator/prey**

Where species are so different that they can find no value in the partner species beyond nutritional value. Alternatively where cells must eradicate competition maybe to push a more niche isolationist lifestyle (which cannot tolerate competition.)

At an evolutionary level this occurs when the other ecological strategies (mutualism, parasitism, antagonism) are less valued than partner eradication. How such a barrier could be calculated or even conceptualized is beyond me.

This is what we think of when we talk about canonical polymicrobial interactions. Toxin secretion, contact-dependent killing, or even intrinsic growth advantages; all are ways for cells to get into an antagonistic relationship

The 'prey' to the 'predator' must be so insignificant that it is almost eradicated on accident. We must be very careful to not confuse predator/prey relationships with parasitism. They are not equivalent.

![cell-diplomacy](https://github.com/marklemzin/marks-masters/raw/main/home-made-diagrams/17.3%20cell-diplomacy.png)

*An accidental diagram (hopefully humorous.) I was thinking and playing around with ecological relationships, and they somehow ended up in a grid that resembles the political compass. For context: the left-to-right scale would measure the distribution of capital (socially-distributed to privately-owned) and the top-to-bottom scale would show the distribution of political power (centralized-management to grass-roots management.)*

There is a trend towards measuring colony heterogeneity as a proxy to showing ecological relationships. There's a great list in this review on [detecting heterogeneity](https://pubmed.ncbi.nlm.nih.gov/36227846/). My problem with work like this is that, as Sam would say, there is no biological basis. It'd be nice to have a review that gives examples like 'sector width' shows not only 'heterogeneity' but is also a way to show how much cells have grown from a frequently single-celled bottleneck - a representation of colonization potential.

*'Heterogeneity is not homogenous'*

But how could we use a model in a project? Based on our experimental design (agar-plate colonies) our data would be of static ecological settings. We can simulate by means of a mathematical model the biofilm's development *in-silico* - though making comparisons between *in-silico* and *in-vitro* data would need some serious statistical modelling. I prefer to think of models as an art critic would think of brush strokes, that they are part of an irreducible whole. Each model is mathematically chaotic but if we know what rules are behind the shapes formed maybe we can start to guess what genes could be involved when cells combine into similarly-shaped structures.

*An example: interpreting ecological images*

![fractal-mixing](https://github.com/marklemzin/marks-masters/raw/main/pictures/11.3%20fractal-mixing.jpg)


*Centre: initial inoculum. Green: consumer (nar KO). Cyan: producer (nir KO).*

The image above is from [a paper](https://pmc.ncbi.nlm.nih.gov/articles/PMC8319339/) that takes a look at the behaviour of 2 complimentary strains lacking either Nar or Nir (genes involved in N reduction) and their distribution on polymicrobial agar-plate colonies.

Their main conclusion: enough of one mutant is enough to determine which direction a metabolic gradient (N reduction) flows over a spatial region. The mutant which is in a higher density in the inoculum will go on to form the outer layer of the bacterial colony. The paper does not explain the fractal distribution of bacteria. This doesn't invalidate their conclusions but it's kind of a shame that they don't go any further with the fractal idea given how eye-catching it is.

Their 'fractal colony arrangement' doesn't remind me so much of a fractal shape as it does a process called diffusion-limited aggregation (DLA). DLA is something I had stumbled upon over the Summer as part of my recreational research and it's nice to see it pop up [in biofilm modelling](https://www.sciencedirect.com/science/article/pii/S0038109810000281) as well as this paper, completely coincidentally.

DLA itself is a pretty simple algorithm. A single point is placed on a toroidal plane (the top of the x-axis is the same as the bottom of the x-axis, and the same for the y-axis) and one-by-one, pixels are spawned at the borders and allowed to walk randomly until they contact a stationary pixel. As more pixels aggregate ('aggregation') their random walk is less likely to reach the core of the aggregated-structure ('diffusion-limited').

Taking a biological perspective we can look at each 'branch' of DLA as if it were made of 2 ecological gradients. The first is the line going out from the core - they explain this as the pressure from growing cells to force each other out towards uncolonized space, and the second line is the one that cells spread out concentrically along, to restrict access to the nucleating cell. This second line is less simple to explain biologically but we could think of it as cells having pressure to form borders with the complimentary strain. The genetic basis for DLA is not explained in the paper. It could be motility, chemotaxis, or just overgrowth but this is not explained by the paper.

![2d-dla](https://github.com/marklemzin/marks-masters/raw/main/home-made-diagrams/28.3%202d-dla.png)

It's a bit strange that DLA could be driven by physical cell interactions entirely (at least when looking at the data presented) since some of the DLA branches begin at the border and extend into the colony's core. Cell-to-cell pushing should only extend outwards from the colony core but it's clear here that DLA can go towards the colony core too.

From an ecological perspective DLA presents a model that maximizes interspecies homogeneity. Only parasitism/mutualism support interspecies mixing. The strains in the paper lend themselves well to a mutualistic model where a single partner cell grows out into a pre-colonized population of partner cells. Two factors predict plot colonization: a plot should be far enough away from the self (for example: no NO2- accumulation) and should be close enough to the other (for example: a partner than can turn NO2- into NO.) Visually and biologically this is much like how *Pseudomonas* cells swarm.

*Editor's notes: A 'plot' in ecology is a colonizable space. Think of it as a 'plot of land'.*

As a thought experiment if we add more and more colonizer cells the biofilm becomes saturated. Each cell has less space to expand freely and so form smaller and smaller DLA structures. When the biofilm is saturated cells cannot undergo DLA-style colonization - since the biofilm is already homogenous.

There is also a case to be made for parasitism. The empty space left in a DLA crystal (occupied by the partner cell) will have a greater total area than the crystal itself. When a species takes up more space than its partner species, the interspecies relationship cannot be perfectly mutualistic. The DLA pattern can suggest that the 'consumer' mutant has a slight edge in growth over the 'producer' despite being almost perfectly isogenic strains - but this is also shown to be strongly related to initial inoculum density.

*An example: Ecological neutrality*

Adapted from [this paper](https://pubmed.ncbi.nlm.nih.gov/32555430/), the bottom of the section titled 'Channels emerge as an inherent property of biofilm formation.'

This paper looks at water channels in *E. coli* biofilm colonies. I don't want to write about the rest of the paper as I think it's very good, but there is one section that requires care in its interpretation. Water channels were mechanically disrupted (using a sterile pipette) after some time and allowed to restructure themselves. The biofilm was subsequently imaged to see whether channels could spontaneously reform. 

Does such a disruption (mechanical) ever result in an absence of an ecological state where cells simply cannot react to each other? I'd guess that cells instead become homogenous and are forced into a setting where mutualism/parasitism are the optimal strategies.

It's really a logic of balance: biofilms must always have an ecological state. Certain gene products may have less or more merits to them when cells are pushed to homogeneity. A parasite ('cheater') may find themselves pushed to the borders of a producer colony normally but could have a dominant presence otherwise.

So antimicrobial treatments that disrupt the biofilm do not only remove prior ecological associations but also provide room for novel functionalities. A niche function of a species may become critically important if the cell is moved into a sub-optimal space for its primary survival strategy.

*Science fiction*

*Editor's note: Achtung! This section is fairly opaque because I struggle with these concepts. I've only left it in for the sake of completion.*

It only hurts to idealize in retrospect. I'll conclude with a little about the sort of places I'd want this project to take me - answers to the little biting problems I have with my perspective on biology.

*Can there be an ecologically null state?*

Cells far apart are ecologically neutral and cells that are placed in a new environment will quickly adapt. In that small window of time species will behave irrespective of their spatial context.

Such a case is fundamentally transient but serves to show that cells can behave outside of a normal gradient/equilibrium model given a large enough ecological shock. How I'd model a shift into an ecological mode is beyond me, but I'd say that it is no longer an ecological problem.

The reason why we'd care is to establish a model for the general mechanism of bacterial death. As bacteria become decoupled from more processes, things like energetic gradients and ecological equilibria - those are the best known, then bacteria have fewer barriers between them and entering a state where they have a net gain of structural disorder.

If we imagine the whole of biology as a well tuned machine, then pulling out a cog and letting it spin of its own accord on an axle creates a component that is much more challenging to restore to the machine - the teeth of a cog must align with those of its neighbours. Treatment with an antimicrobial suspends cells in a biologically transient state and genes that are key for typical survival (such as in the environment) or necessary ecological structures (such as a barrier used to keep away a bactericidal species). When the treatment is *removed*, cells may find themselves ill-equipped to handle their regular lifecycle. That state of ill-adaptation is what I would consider to be 'evolutionarily null' or 'ecologically null'.

Cells go on a journey that disrupts their standard lifestyle and may never be able to return to their initial genetic/ecological state.

*Gene distribution*

How well species related-ness predicts species co-operation is classic problem. It flows on from 'kin-selection' from classical genetics ('I would gladly give up my life for two brothers or eight cousins' - those sorts of vibes) and that general direction of research. I find statements like this to be something of a paradox. How much is there to gain from an isogenic twin ecologically-speaking? It makes sense that we'd better co-operate with something that offers an exotic function - a service that our own biology lacks.

The best way to answer a question like this is to take two organisms and randomly mix their genes; 50:50 a gene goes to one organism or the other. The cells that result would be likely to have a mix of genes from both organisms (a binomial distribution) but this is not the number of cell pairs that would subsequently grow. How similar/dissimilar cells would need to create more cells that are capable of independent growth or strictly cooperative growth is the difficult question.

![shared-pool-arrangement](https://github.com/marklemzin/marks-masters/raw/main/home-made-diagrams/26.3%20shared-pool-arrangement.png)

It's not hard to make a statement like 'more horizontal gene transfer means a lesser tendency to co-operate.' The hard part is to design the subsequent analysis/experiment. Such an experiment *starts* with genetic stochasticity (something like hypermutants, maybe?) of two species and then *ends* by saying how many of them were obligate mutualists and how many survived independently.

I'm not sure if there's a way to exchange genes between species so efficiently yet so the easier analysis would be bioinformatic. We can take the inverse statement: that cells that tend to transfer genes are likely to have a greater propensity for successful gene-mixing. If the donor then loses the original function then that species can become mutualistic.

But HGT is a niche evolutionary case. If we think of genes as memories to a stress or demand that may no longer be ecologically significant - then as memories often do - they themselves can perpetuate the situation-which-created them. It's a kind of convergent mimicry. If cells need to compete with bactericidal toxins then that stress will persist so long as there are 2 species in the world: one bactericidal and the other naïve. That host may then create a demand for its own antagonism resulting in pressure for other strains to produce bactericidal toxins. The first host may then keep its counterbalance (an antitoxin system) but lose its toxin system. The result is a transfer of gene functionality. Such is the case for bactericidal genes. The way that other genes are transferred likely follows different dynamics.

How *Pa* and *Sa* behave is a mystery of origination. If we knew what stressors that *Pa* and *Sa* encounter which makes them behave the way they do, it'd be less about how *Pa* and *Sa* as bacteria interact - but how much *Pa* and *Sa* create synergistic environments. Is there much of a change between the nose and soil after all?