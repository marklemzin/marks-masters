#29.04

#### Dependencies ####
library(ggplot2)

library(tidyverse)

#### Data import/conditioning ####
directory <- '../raw-data/'
raw_filename <- '29.4 overnight-coculture-stability.csv'
source <- paste0(directory,raw_filename)

Sample_ID <- data.table::fread(source, header = TRUE, data.table=F)

values_for_plot <- Sample_ID
values_for_plot$cond_cut <- stringr::word(sub('', '', values_for_plot$condition), 1)
values_for_plot$strain <- stringr::word(sub('', '', values_for_plot$condition), 2)
values_for_plot$no_replicates <- ifelse(is.na(stringr::word(values_for_plot$condition, 1, 2)),
                                        values_for_plot$condition,
                                        stringr::word(values_for_plot$condition, 1, 2))
values_for_plot$no_time <- gsub("*.*.-", "", values_for_plot$cond_cut) 

strain_glossary <- data.table::fread('../experimental-setup/19.3 code_strains.csv', header = TRUE, data.table=F)

values_for_plot <- merge(values_for_plot, strain_glossary, by='strain')
values_for_plot$strain <- values_for_plot$fixed_strain

values_for_plot$time <- rep(NA,length(values_for_plot$strain))
values_for_plot$time[grep('post',values_for_plot$condition)] <- 'post'
values_for_plot$time[grep('pre',values_for_plot$condition)] <- 'pre'

values_for_plot$time <- fct_rev(as_factor(values_for_plot$time))

#### Imaging ####

#AHHHH
#ggplot facets alphabetically. USA300 does not preserve strain association.

ggplot2::ggplot(values_for_plot, aes(x=time, y=cfu)) +
  geom_point(alpha=0.3) +
  facet_wrap( strain ~ no_time ) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(auc_e) {mean(auc_e) + sd(auc_e)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test", ref.group="pre") +
  theme(legend.position="none") +
  theme_bw() +
  scale_y_continuous(trans='log10') +
  ylab("") +
  xlab("")
