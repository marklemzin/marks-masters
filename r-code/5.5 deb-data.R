#5.5
#Scripting for merging Deb's data with Pseudomonas.com's locus information

library(clusterProfiler)

#### PA14 ####

#Data import

PA14_GO <- data.table::fread('../raw-data/5.5 deb data/PA14 GO 5.5.csv',
                             header = TRUE, data.table=F)
PA14_2sd_up <- data.table::fread('../raw-data/5.5 deb data/PA14 2sdev moreSA.csv',
                              header = TRUE, data.table=F)
PA14_2sd_down <- data.table::fread('../raw-data/5.5 deb data/PA14 2sdev lessSA.csv',
                                 header = TRUE, data.table=F)
PA14_library <- data.table::fread('../raw-data/5.5 deb data/PA14 library.csv',
                                  header = TRUE, data.table=F)

#Nested merge for proofreading
FULL_UP <- merge( PA14_2sd_up , PA14_library, by='library_position')[,10]

write.csv(FULL_UP,"../raw-data/5.5 deb data/PA14 up.csv", row.names = FALSE)

FULL_DOWN <- merge( PA14_2sd_down , PA14_library, by='library_position')[,10]

write.csv(FULL_DOWN,"../raw-data/5.5 deb data/PA14 down.csv", row.names = FALSE)

#Note genes with missing loci
PA14_up_genes <- merge( PA14_2sd_up , PA14_library, by='library_position')[,10]

PA14_down_genes <- merge(PA14_2sd_down , PA14_library, by='library_position')[,10]

#Using clusterprofiler/KEGG for summary

#All genes
term2name <- subset(PA14_GO, select = c(5, 6))
term2gene <- subset(PA14_GO, select = c(5, 1))

ALL_up <- enricher(PA14_up_genes, qvalueCutoff = 0.05, pAdjustMethod = "BH", TERM2GENE = term2gene, TERM2NAME = term2name)

#(Molecular function)
PA14_GO_MF <- PA14_GO[ which(PA14_GO$Namespace=='molecular_function'), ]

term2name_MF <- subset(PA14_GO_MF, select = c(5, 6))
term2gene_MF <- subset(PA14_GO_MF, select = c(5, 1))

enriched_MF_up <- enricher(PA14_up_genes, qvalueCutoff = 0.05, pAdjustMethod = "BH", TERM2GENE = term2gene_MF, TERM2NAME = term2name_MF)

#(Biological process)
PA14_GO_BP <- PA14_GO[which(PA14_GO$Namespace == "biological_process"),]

term2name_BP <- subset(PA14_GO_BP, select = c(5, 6))
term2gene_BP <- subset(PA14_GO_BP, select = c(5, 1))

enriched_BP_up <- enricher(PA14_up_genes, qvalueCutoff = 0.05, pAdjustMethod = "BH", TERM2GENE = term2gene_BP, TERM2NAME = term2name_BP)

#(Cellular components)
PA14_GO_CC <- PA14_GO[which(PA14_GO$Namespace == "cellular_component"),]

term2name_CC <- subset(PA14_GO_CC, select = c(5, 6))
term2gene_CC <- subset(PA14_GO_CC, select = c(5, 1))

enriched_CC <- enricher(PA14_up_genes, qvalueCutoff = 0.05, pAdjustMethod = "BH", TERM2GENE = term2gene_CC, TERM2NAME = term2name_CC)

#KEGG
kegg_up <- enrichKEGG(gene = PA14_up_genes, organism = 'pau', pvalueCutoff = 0.05)

#### PAO1 ####

#Data import

PAO1_GO <- data.table::fread('../raw-data/5.5 deb data/PAO1 GO 5.5.csv',
                             header = TRUE, data.table=F)
PAO1_2sd_up <- data.table::fread('../raw-data/5.5 deb data/PAO1 2sdev moreSA.csv',
                                 header = TRUE, data.table=F)
PAO1_2sd_down <- data.table::fread('../raw-data/5.5 deb data/PAO1 2sdev lessSA.csv',
                                   header = TRUE, data.table=F)
PAO1_library <- data.table::fread('../raw-data/5.5 deb data/PAO1 library.csv',
                                  header = TRUE, data.table=F)

#Nested merge for proofreading
FULL_UP <- merge( PAO1_2sd_up , PAO1_library, by='Location')[,7]

write.csv(FULL_UP,"../raw-data/5.5 deb data/PAO1 up.csv", row.names = FALSE)

FULL_DOWN <- merge( PAO1_2sd_down , PAO1_library, by='Location')[,7]

write.csv(FULL_DOWN,"../raw-data/5.5 deb data/PAO1 down.csv", row.names = FALSE)

#Note genes with missing loci
PAO1_up_genes <- merge( PAO1_2sd_up , PAO1_library, by='Location')[,5]

PAO1_down_genes <- merge(PAO1_2sd_down , PAO1_library, by='Location')[,5]

#Using clusterprofiler/KEGG for summary

#All genes
term2name <- subset(PAO1_GO, select = c(5, 6))
term2gene <- subset(PAO1_GO, select = c(5, 1))

ALL_up <- enricher(PAO1_up_genes, qvalueCutoff = 0.05, pAdjustMethod = "BH", TERM2GENE = term2gene, TERM2NAME = term2name)
ALL_down <- enricher(PAO1_down_genes, qvalueCutoff = 0.05, pAdjustMethod = "BH", TERM2GENE = term2gene, TERM2NAME = term2name)

#(Molecular function)
PAO1_GO_MF <- PAO1_GO[ which(PAO1_GO$Namespace=='molecular_function'), ]

term2name_MF <- subset(PAO1_GO_MF, select = c(5, 6))
term2gene_MF <- subset(PAO1_GO_MF, select = c(5, 1))

enriched_MF_up <- enricher(PAO1_up_genes, qvalueCutoff = 0.05, pAdjustMethod = "BH", TERM2GENE = term2gene_MF, TERM2NAME = term2name_MF)
enriched_MF_down <- enricher(PAO1_down_genes, qvalueCutoff = 0.05, pAdjustMethod = "BH", TERM2GENE = term2gene_MF, TERM2NAME = term2name_MF)

#(Biological process)
PAO1_GO_BP <- PAO1_GO[which(PAO1_GO$Namespace == "biological_process"),]

term2name_BP <- subset(PAO1_GO_BP, select = c(5, 6))
term2gene_BP <- subset(PAO1_GO_BP, select = c(5, 1))

enriched_BP_up <- enricher(PAO1_up_genes, qvalueCutoff = 0.05, pAdjustMethod = "BH", TERM2GENE = term2gene_BP, TERM2NAME = term2name_BP)
enriched_BP_down <- enricher(PAO1_down_genes, qvalueCutoff = 0.05, pAdjustMethod = "BH", TERM2GENE = term2gene_BP, TERM2NAME = term2name_BP)

#(Cellular components)
PAO1_GO_CC <- PAO1_GO[which(PAO1_GO$Namespace == "cellular_component"),]

term2name_CC <- subset(PAO1_GO_CC, select = c(5, 6))
term2gene_CC <- subset(PAO1_GO_CC, select = c(5, 1))

enriched_CC_up <- enricher(PAO1_up_genes, qvalueCutoff = 0.05, pAdjustMethod = "BH", TERM2GENE = term2gene_CC, TERM2NAME = term2name_CC)
enriched_CC_down <- enricher(PAO1_down_genes, qvalueCutoff = 0.05, pAdjustMethod = "BH", TERM2GENE = term2gene_CC, TERM2NAME = term2name_CC)

#KEGG
kegg_up <- enrichKEGG(gene = PAO1_up_genes, organism = 'pae', pvalueCutoff = 0.05)
kegg_down <- enrichKEGG(gene = PAO1_down_genes, organism = 'pae', pvalueCutoff = 0.05)

#### USA300 / PAO1 ####

USA300PAO1_2sd_up <- data.table::fread('../raw-data/5.5 deb data/USA300-PAO1 2sdev morePa.csv',
                                 header = TRUE, data.table=F)
USA300PAO1_2sd_down <- data.table::fread('../raw-data/5.5 deb data/USA300-PAO1 2sdev lessPa.csv',
                                       header = TRUE, data.table=F)
USA300_library <- data.table::fread('../raw-data/5.5 deb data/SA library.csv',
                                  header = TRUE, data.table=F)

#Nested merge for proofreading
FULL_UP <- merge( USA300PAO1_2sd_up , USA300_library, by='location')
USA300PAO1_up_space <- data.frame( coordinate = FULL_UP$`Plate 1`)

write.csv(FULL_UP[,8],"../raw-data/5.5 deb data/USA300PAO1 up.csv", row.names = FALSE)

FULL_DOWN <- merge( USA300PAO1_2sd_down , USA300_library, by='location')
USA300PAO1_down_space <- data.frame( coordinate = FULL_DOWN$`Plate 1`)

write.csv(FULL_DOWN[,8],"../raw-data/5.5 deb data/USA300PAO1 down.csv", row.names = FALSE)

#### USA300 / PA14 ####

USA300PA14_2sd_up <- data.table::fread('../raw-data/5.5 deb data/USA300-PA14 2sdev morePa.csv',
                                       header = TRUE, data.table=F)
USA300PA14_2sd_down <- data.table::fread('../raw-data/5.5 deb data/USA300-PA14 2sdev lessPa.csv',
                                         header = TRUE, data.table=F)
USA300_library <- data.table::fread('../raw-data/5.5 deb data/SA library.csv',
                                    header = TRUE, data.table=F)

#Nested merge for proofreading
FULL_UP <- merge( USA300PA14_2sd_up , USA300_library, by='location')
USA300PA14_up_space <- data.frame( coordinate = FULL_UP$`Plate 1`)

write.csv(FULL_UP[,8],"../raw-data/5.5 deb data/USA300PA14 up.csv", row.names = FALSE)

FULL_DOWN <- merge( USA300PA14_2sd_down , USA300_library, by='location')
USA300PA14_down_space <- data.frame( coordinate = FULL_DOWN$`Plate 1`)

write.csv(FULL_DOWN[,8],"../raw-data/5.5 deb data/USA300PA14 down.csv", row.names = FALSE)

#### Well enrichment ####
#Run previous code first!

PAO1_2sd_up$col <- as.numeric( str_sub( sub( '.', '', sub(".*q", "", PAO1_2sd_up$Location) ) , -2 ) )
PAO1_2sd_up$row <- str_sub( sub( '.', '', sub(".*q", "", PAO1_2sd_up$Location) ) , 1 , 1 )

ggplot( PAO1_2sd_up , aes( x = col, y = row )) +
  geom_bin_2d() +
  theme_bw() +
  ggtitle('Wells which USA300 grew better (PAO1 tn screen)') +
  scale_y_discrete(limits=rev)

PAO1_2sd_down$col <- as.numeric( str_sub( sub( '.', '', sub(".*q", "", PAO1_2sd_down$Location) ) , -2 ) )
PAO1_2sd_down$row <- str_sub( sub( '.', '', sub(".*q", "", PAO1_2sd_down$Location) ) , 1 , 1 )

ggplot( PAO1_2sd_down , aes( x = col, y = row )) +
  geom_bin_2d() +
  theme_bw() +
  ggtitle('Wells which USA300 grew worse (PAO1 tn screen)') +
  scale_y_discrete(limits=rev)

PA14_2sd_up$col <- as.numeric( sub( '..', '', sub(".*\\_" , "" , PA14_2sd_up$library_position) ) )
PA14_2sd_up$row <- str_sub( sub( '.', '', sub(".*\\_" , "" , PA14_2sd_up$library_position) ) , 1 , 1 )

##

ggplot( PA14_2sd_up , aes( x = col, y = row )) +
  geom_bin_2d() +
  theme_bw() +
  ggtitle('Wells which USA300 grew better (PA14 tn screen)') +
  scale_y_discrete(limits=rev)

PA14_2sd_down$col <- as.numeric( sub( '..', '', sub(".*\\_" , "" , PA14_2sd_down$library_position) ) )
PA14_2sd_down$row <- str_sub( sub( '.', '', sub(".*\\_" , "" , PA14_2sd_down$library_position) ) , 1 , 1 )

##

ggplot( PA14_2sd_down , aes( x = col, y = row )) +
  geom_bin_2d() +
  theme_bw() +
  ggtitle('Wells which USA300 grew worse (PA14 tn screen)') +
  scale_y_discrete(limits=rev)

USA300PA14_up_space$row <- str_sub( USA300PA14_up_space$coordinate, 1, 1 )
USA300PA14_up_space$col <- as.numeric( sub(".", "", USA300PA14_up_space$coordinate) )

##

USA300PAO1_up_space$row <- str_sub( USA300PAO1_up_space$coordinate, 1, 1 )
USA300PAO1_up_space$col <- as.numeric( sub(".", "", USA300PAO1_up_space$coordinate) )

ggplot( USA300PAO1_up_space , aes( x = col, y = row )) +
  geom_bin_2d() +
  theme_bw() +
  ggtitle('Wells which Pa grew better (USA300/PAO1 tn screen)') +
  scale_y_discrete(limits=rev)

USA300PAO1_down_space$row <- str_sub( USA300PAO1_down_space$coordinate, 1, 1 )
USA300PAO1_down_space$col <- as.numeric( sub(".", "", USA300PAO1_down_space$coordinate) )

ggplot( USA300PAO1_down_space , aes( x = col, y = row )) +
  geom_bin_2d() +
  theme_bw() +
  ggtitle('Wells which Pa grew worse (USA300/PAO1 tn screen)') +
  scale_y_discrete(limits=rev)

##

USA300PA14_up_space$row <- str_sub( USA300PA14_up_space$coordinate, 1, 1 )
USA300PA14_up_space$col <- as.numeric( sub(".", "", USA300PA14_up_space$coordinate) )

ggplot( USA300PA14_up_space , aes( x = col, y = row )) +
  geom_bin_2d() +
  theme_bw() +
  ggtitle('Wells which Pa grew better (USA300/PA14 tn screen)') +
  scale_y_discrete(limits=rev)

USA300PA14_down_space$row <- str_sub( USA300PA14_down_space$coordinate, 1, 1 )
USA300PA14_down_space$col <- as.numeric( sub(".", "", USA300PA14_down_space$coordinate) )

ggplot( USA300PA14_down_space , aes( x = col, y = row )) +
  geom_bin_2d() +
  theme_bw() +
  ggtitle('Wells which Pa grew worse (USA300/PA14 tn screen)') +
  scale_y_discrete(limits=rev)

#### Gene co-occurence: PAO1/PA14 ####

#Increases in USA300 growth (tn mutagenesis of PAO1/PA14)
UP_PAO1 <- data.table::fread('../raw-data/5.5 deb data/PAO1 up.csv', header = TRUE, data.table=F)
colnames(UP_PAO1) <- 'Locus'

UP_PA14 <- data.table::fread('../raw-data/5.5 deb data/PA14 up.csv', header = TRUE, data.table=F)
UP_PA14_clean <- data.frame( `x` = UP_PA14[UP_PA14$x !="",])
colnames(UP_PA14_clean) <- 'Locus Tag'

PA14_ortho <- data.table::fread('../raw-data/5.5 deb data/orthologs PA14 PAO1 13.5.csv', header = TRUE, data.table=F)

UP_PA14_cvrt <- data.frame( Locus = unique(merge(UP_PA14_clean, PA14_ortho, by='Locus Tag', all=FALSE))[,3] )
unique(merge(UP_PA14_cvrt, UP_PAO1))

#Decreases in USA300 growth (tn mutagenesis of PAO1/PA14)
DOWN_PAO1 <- data.table::fread('../raw-data/5.5 deb data/PAO1 DOWN.csv', header = TRUE, data.table=F)
colnames(DOWN_PAO1) <- 'Locus'

DOWN_PA14 <- data.table::fread('../raw-data/5.5 deb data/PA14 DOWN.csv', header = TRUE, data.table=F)
DOWN_PA14_clean <- data.frame( `x` = DOWN_PA14[DOWN_PA14$x !="",])
colnames(DOWN_PA14_clean) <- 'Locus Tag'

PA14_ortho <- data.table::fread('../raw-data/5.5 deb data/orthologs PA14 PAO1 13.5.csv', header = TRUE, data.table=F)

DOWN_PA14_cvrt <- data.frame( Locus = unique(merge(DOWN_PA14_clean, PA14_ortho, by='Locus Tag', all=FALSE))[,3] )
unique(merge(DOWN_PA14_cvrt, DOWN_PAO1))

#Increases in Pa growth (tn mutagenesis of USA300)
UP_USA_PAO1 <- data.table::fread('../raw-data/5.5 deb data/USA300PAO1 up.csv', header = TRUE, data.table=F)
UP_USA_PA14 <- data.table::fread('../raw-data/5.5 deb data/USA300PA14 up.csv', header = TRUE, data.table=F)
merge(UP_USA_PAO1,UP_USA_PA14)

#Decreases in Pa growth (tn mutagenesis of USA300)
DOWN_USA_PAO1 <- data.table::fread('../raw-data/5.5 deb data/USA300PAO1 DOWN.csv', header = TRUE, data.table=F)
DOWN_USA_PA14 <- data.table::fread('../raw-data/5.5 deb data/USA300PA14 DOWN.csv', header = TRUE, data.table=F)
merge(DOWN_USA_PAO1,DOWN_USA_PA14)
