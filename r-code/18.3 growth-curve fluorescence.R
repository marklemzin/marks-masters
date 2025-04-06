#18.03
# Tasks as of 19.03
# Add comments
# See if fl and od curves can be shown on the same graph

#### Dependencies ####
#packageVersion()

library(growthcurver)
library(stringr)
library(paletteer)
library(ggpubr)
library(patchwork)

#tidyverse
library(ggplot2)

#### OD600: Area under the curve ####
directory <- '../raw-data/'
raw_filename <- '31.3 fpscreen OD.csv'
source <- paste0(directory,raw_filename)

Sample_ID <- data.table::fread(source, header = TRUE, data.table=F)
Sample_ID_out <- growthcurver::SummarizeGrowthByPlate(Sample_ID,
                                        plot_fit = TRUE,
                                        plot_file = paste0(directory,'troubleshooting.pdf'))

Sample_ID_out$condition <- ifelse(is.na(stringr::word(Sample_ID_out$sample, 1, 2)),
                                  Sample_ID_out$sample,
                                  stringr::word(Sample_ID_out$sample, 1, 2))

values_for_plot <- Sample_ID_out[-grepl('empty',Sample_ID_out$condition),]
values_for_plot$media <- stringr::word(sub('', '', values_for_plot$condition), 1)
values_for_plot$strain <- stringr::word(sub('', '', values_for_plot$condition), 2)

strain_glossary <- data.table::fread('../experimental-setup/19.3 code_strains.csv', header = TRUE, data.table=F)
media_glossary <- data.table::fread('../experimental-setup/19.3 code_media.csv', header = TRUE, data.table=F)

values_for_plot <- merge(values_for_plot, strain_glossary, by='strain')
values_for_plot <- merge(values_for_plot, media_glossary, by='media')
values_for_plot$strain <- values_for_plot$fixed_strain
values_for_plot$media <- values_for_plot$named_media

values_for_plot$no_engineer <- stringr::word(sub('', '', values_for_plot$fixed_strain), 1)
values_for_plot$engineer <- stringr::word(sub('', '', values_for_plot$fixed_strain), 2)

values_for_plot$fp <- rep('NA', length(values_for_plot$media))
values_for_plot$fp[grep('GFP',values_for_plot$fixed_strain)] <- 'GFP'
values_for_plot$fp[grep('YFP',values_for_plot$fixed_strain)] <- 'YFP'
values_for_plot$fp[grep('FarRed',values_for_plot$fixed_strain)] <- 'FarRed'

#Standardize to blank
values_for_lb <- values_for_plot[grep('lb', values_for_plot$sample),]
values_for_lb <- values_for_lb[-grep('blank', values_for_lb$strain),]
#For average blank AUC_e, use the 8th column
values_for_lb$auc_e <- sapply(values_for_lb$auc_e, function(x) x - 
                                mean(values_for_plot[grep('lb blank', values_for_plot$condition),10]))

#As above for TSB
values_for_tsb <- values_for_plot[grep('tsb', values_for_plot$sample),]
values_for_tsb <- values_for_tsb[-grep('blank', values_for_tsb$strain),]
#For average blank AUC_e, use the 8th column
values_for_tsb$auc_e <- sapply(values_for_tsb$auc_e, function(x) x - 
                                mean(values_for_plot[grep('tsb blank', values_for_plot$condition),10]))

#For PAO1
strain_of_interest <- 'PAO1'
plot_title <- paste0('auc_e (OD) of ', strain_of_interest,' mutants')
y_label <- 'AUC_e (OD600 x h)'

p_PAO1 <- ggplot2::ggplot(values_for_lb[grep(strain_of_interest,values_for_lb$no_engineer), ], aes(x=strain, y=auc_e, fill = fp)) +
    geom_point(alpha=0.3) +
    stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
    stat_summary(fun.y=function(auc_e) {mean(auc_e) + sd(auc_e)*c(-1,1)}, geom="point", shape="\U2014", 
                 size=7, colour="black") +
    stat_compare_means(label = "p.signif", method = "t.test",
                       ref.group = paste0(strain_of_interest,' (wild-type)'),
                       label.y = 12.5) +
    theme(legend.position="none") +
    scale_fill_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
    theme_bw() +
    ylab(y_label) +
    xlab('') +
    theme(legend.position="none") +
    ylim(c(0,22)) +
    theme(axis.text.x = element_text(angle = 45, hjust=1)) +
    ggtitle(plot_title)

#For PA14
strain_of_interest <- 'PA14'
plot_title <- paste0('auc_e (OD) of ', strain_of_interest,' mutants')

p_PA14 <- ggplot2::ggplot(values_for_lb[grep(strain_of_interest,values_for_lb$no_engineer), ], aes(x=strain, y=auc_e, fill = fp)) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(auc_e) {mean(auc_e) + sd(auc_e)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test",
                     ref.group = paste0(strain_of_interest,' (wild-type)'),
                     label.y = 11) +
  theme(legend.position="none") +
  scale_fill_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ylab('') +
  xlab('') +
  ylim(c(0,22)) +
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  ggtitle(plot_title)

#For LESB58
strain_of_interest <- 'LESB58'
plot_title <- paste0('auc_e (OD) of ', strain_of_interest,' mutants')

p_LESB58 <- ggplot2::ggplot(values_for_lb[grep(strain_of_interest,values_for_lb$no_engineer), ], aes(x=strain, y=auc_e, fill = fp)) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(auc_e) {mean(auc_e) + sd(auc_e)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test",
                     ref.group = paste0(strain_of_interest,' (wild-type)'),
                     label.y = 9) +
  theme(legend.position="none") +
  scale_fill_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ylab('') +
  xlab('') +
  ylim(c(0,22)) +
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  ggtitle(plot_title)

#For USA300
strain_of_interest <- 'USA300'
plot_title <- paste0('auc_e (OD) of ', strain_of_interest,' mutants')

p_USA300 <- ggplot2::ggplot(values_for_tsb[grep(strain_of_interest,values_for_tsb$no_engineer), ], aes(x=strain, y=auc_e, fill = fp)) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(auc_e) {mean(auc_e) + sd(auc_e)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test",
                     ref.group = paste0(strain_of_interest,' (wild-type)'),
                     label.y = 21) +
  theme(legend.position="none") +
  scale_fill_manual(values=c("#A45A52", "#D3D3D3")) +
  theme_bw() +
  ylab('') +
  xlab('') +
  ylim(c(0,22)) +
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  ggtitle(plot_title)

#Adding all 4 plots: PAO1, PA14, LESB58, USA300
p_PAO1 + p_PA14 + p_LESB58 + p_USA300

#Growth for all Pa strains (legacy)
my_comparisons <- list( c('(wild-type)','pUCP.eGFP-2') )

ggplot2::ggplot(values_for_lb, aes(x=engineer, y=auc_e, fill = fp)) +
  geom_point(alpha=0.3) +
  facet_wrap( . ~ no_engineer , scales = "free_x") +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(auc_e) {mean(auc_e) + sd(auc_e)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  scale_fill_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ylab('RFU') +
  xlab('') +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  theme(legend.position="none") +
  ggtitle('auc_e OD of all Pseudomonas strains')

#Alternate version for multiple media (legacy)

plot_title <- 'No growth in TCM across strains'
y_label <- 'AUC_e (OD600 x h)'

ggplot2::ggplot(values_for_tcm, aes(x=media, y=auc_e, fill=media)) +
  facet_grid( . ~ strain ) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(auc_e) {mean(auc_e) + sd(auc_e)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test",
                     comparisons = list(c('TCM','TCM + Gm50')), label.y = 12.5) +
  theme(legend.position="none") +
  paletteer::scale_fill_paletteer_d("palettetown::ariados") +
  theme_bw() +
  ylab(y_label) +
  ggtitle(plot_title)

####OD600: average for fl calculations####

#Average AUC. For fluorescence calculations
condition_list <- unique(values_for_lb$sample)
od_mean_auc <- numeric(length=length(condition_list))

for ( i in 1:length(condition_list) ) {
  od_mean_auc[i] <- mean(values_for_lb$auc_e[grep(condition_list[i], values_for_lb$sample)])
}

od_auc_sum_lb <- data.frame( sample = condition_list , od_auc = od_mean_auc )

#for TSB
condition_list <- unique(values_for_tsb$sample)
od_mean_auc <- numeric(length=length(condition_list))

for ( i in 1:length(condition_list) ) {
  od_mean_auc[i] <- mean(values_for_tsb$auc_e[grep(condition_list[i], values_for_tsb$sample)])
}

od_auc_sum_tsb <- data.frame( sample = condition_list , od_auc = od_mean_auc )

#### Fluorescence: Area under the curve ####

#For FarRed

directory <- '../raw-data/'
raw_filename <- '31.3 fpscreen FarRed.csv'
source <- paste0(directory,raw_filename)

Sample_ID <- data.table::fread(source, header = TRUE, data.table=F)
Sample_ID_out <- growthcurver::SummarizeGrowthByPlate(Sample_ID,
                                                      plot_fit = TRUE,
                                                      plot_file = paste0(directory,'troubleshooting.pdf'))

Sample_ID_out$condition <- ifelse(is.na(stringr::word(Sample_ID_out$sample, 1, 2)),
                                  Sample_ID_out$sample,
                                  stringr::word(Sample_ID_out$sample, 1, 2))
values_for_plot <- Sample_ID_out
values_for_plot$media <- stringr::word(sub('', '', values_for_plot$condition), 1)
values_for_plot$strain <- stringr::word(sub('', '', values_for_plot$condition), 2)

values_for_plot <- merge(values_for_plot, strain_glossary, by='strain')
values_for_plot <- merge(values_for_plot, media_glossary, by='media')
values_for_plot$strain <- values_for_plot$fixed_strain
values_for_plot$media <- values_for_plot$named_media

values_for_plot$no_engineer <- stringr::word(sub('', '', values_for_plot$fixed_strain), 1)
values_for_plot$engineer <- stringr::word(sub('', '', values_for_plot$fixed_strain), 2)

values_for_plot$fp <- rep('NA', length(values_for_plot$media))
values_for_plot$fp[grep('GFP',values_for_plot$fixed_strain)] <- 'GFP'
values_for_plot$fp[grep('YFP',values_for_plot$fixed_strain)] <- 'YFP'
values_for_plot$fp[grep('FarRed',values_for_plot$fixed_strain)] <- 'FarRed'

values_for_tsb <- values_for_plot[grep('tsb', values_for_plot$sample),]
values_for_tsb <- values_for_tsb[-grep('blank', values_for_tsb$strain),]
values_for_tsb$auc_e <- sapply(values_for_tsb$auc_e, function(x) x - 
                                mean(values_for_plot[grep('tsb blank', values_for_plot$condition),8]))

#Only different component: RFU calculation
tsb_fl_od <- merge(values_for_tsb, od_auc_sum_tsb , by = "sample")
tsb_fl_od$rfu <- tsb_fl_od$auc_e / tsb_fl_od$od_auc

strain_of_interest <- 'USA300'
plot_title <- paste0('Fluorescence (592/650) of ', strain_of_interest)
y_label <- 'RFU auc_e'

ggplot2::ggplot(tsb_fl_od, aes(x=strain, y=rfu, fill = fp)) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(rfu) {mean(rfu) + sd(rfu)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test",
                     ref.group = paste0(strain_of_interest,' (wild-type)')) +
  scale_fill_manual(values=c("#A45A52", "#D3D3D3")) +
  theme_bw() +
  ylab(y_label) +
  xlab('') +
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  ggtitle(plot_title)

#For YFP

directory <- '../raw-data/'
raw_filename <- '31.3 fpscreen yfp.csv'
source <- paste0(directory,raw_filename)

Sample_ID <- data.table::fread(source, header = TRUE, data.table=F)
Sample_ID_out <- growthcurver::SummarizeGrowthByPlate(Sample_ID,
                                                      plot_fit = TRUE,
                                                      plot_file = paste0(directory,'troubleshooting.pdf'))

Sample_ID_out$condition <- ifelse(is.na(stringr::word(Sample_ID_out$sample, 1, 2)),
                                  Sample_ID_out$sample,
                                  stringr::word(Sample_ID_out$sample, 1, 2))
values_for_plot <- Sample_ID_out
values_for_plot$media <- stringr::word(sub('', '', values_for_plot$condition), 1)
values_for_plot$strain <- stringr::word(sub('', '', values_for_plot$condition), 2)

values_for_plot <- merge(values_for_plot, strain_glossary, by='strain')
values_for_plot <- merge(values_for_plot, media_glossary, by='media')
values_for_plot$strain <- values_for_plot$fixed_strain
values_for_plot$media <- values_for_plot$named_media

values_for_plot$no_engineer <- stringr::word(sub('', '', values_for_plot$fixed_strain), 1)
values_for_plot$engineer <- stringr::word(sub('', '', values_for_plot$fixed_strain), 2)

values_for_plot$fp <- rep('NA', length(values_for_plot$media))
values_for_plot$fp[grep('GFP',values_for_plot$fixed_strain)] <- 'GFP'
values_for_plot$fp[grep('YFP',values_for_plot$fixed_strain)] <- 'YFP'
values_for_plot$fp[grep('FarRed',values_for_plot$fixed_strain)] <- 'FarRed'

values_for_lb <- values_for_plot[grep('lb', values_for_plot$sample),]
values_for_lb <- values_for_lb[-grep('blank', values_for_lb$strain),]
values_for_lb$auc_e <- sapply(values_for_lb$auc_e, function(x) x - 
                                 mean(values_for_plot[grep('lb blank', values_for_plot$condition),8]))

#Only different component: RFU calculation
lb_fl_od <- merge(values_for_lb, od_auc_sum_lb , by = "sample")
lb_fl_od$rfu <- lb_fl_od$auc_e / lb_fl_od$od_auc

#For PAO1
strain_of_interest <- 'PAO1'
plot_title <- paste0('Fluorescence (500/543) of ', strain_of_interest)
y_label <- 'RFU auc_e'

p_PAO1_yfp <- ggplot2::ggplot(lb_fl_od[grep(strain_of_interest,lb_fl_od$no_engineer), ], aes(x=strain, y=rfu, fill = fp)) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(rfu) {mean(rfu) + sd(rfu)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test",
                     ref.group = paste0(strain_of_interest,' (wild-type)')) +
  scale_fill_manual(values=c("#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ylab('') +
  xlab('') +
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  ggtitle(plot_title)

#For PA14
strain_of_interest <- 'PA14'
plot_title <- paste0('Fluorescence (500/545) of ', strain_of_interest)
y_label <- 'RFU auc_e'

p_PA14_yfp <- ggplot2::ggplot(lb_fl_od[grep(strain_of_interest,lb_fl_od$no_engineer), ], aes(x=strain, y=rfu, fill = fp)) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(rfu) {mean(rfu) + sd(rfu)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test",
                     ref.group = paste0(strain_of_interest,' (wild-type)')) +
  scale_fill_manual(values=c("#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ylab(y_label) +
  xlab('') +
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  ggtitle(plot_title)

#For LESB58
strain_of_interest <- 'LESB58'
plot_title <- paste0('Fluorescence (500/545) of ', strain_of_interest)
y_label <- 'RFU auc_e'

p_LESB58_yfp <- ggplot2::ggplot(lb_fl_od[grep(strain_of_interest,lb_fl_od$no_engineer), ], aes(x=strain, y=rfu, fill = fp)) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(rfu) {mean(rfu) + sd(rfu)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test",
                     ref.group = paste0(strain_of_interest,' (wild-type)')) +
  scale_fill_manual(values=c("#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ylab('') +
  xlab('') +
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  ggtitle(plot_title)

#yfp facet
(p_PA14_yfp + p_LESB58_yfp) +
  p_PAO1_yfp

#For GFP

directory <- '../raw-data/'
raw_filename <- '31.3 fpscreen gfp.csv'
source <- paste0(directory,raw_filename)

Sample_ID <- data.table::fread(source, header = TRUE, data.table=F)
Sample_ID_out <- growthcurver::SummarizeGrowthByPlate(Sample_ID,
                                                      plot_fit = TRUE,
                                                      plot_file = paste0(directory,'troubleshooting.pdf'))

Sample_ID_out$condition <- ifelse(is.na(stringr::word(Sample_ID_out$sample, 1, 2)),
                                  Sample_ID_out$sample,
                                  stringr::word(Sample_ID_out$sample, 1, 2))
values_for_plot <- Sample_ID_out
values_for_plot$media <- stringr::word(sub('', '', values_for_plot$condition), 1)
values_for_plot$strain <- stringr::word(sub('', '', values_for_plot$condition), 2)

values_for_plot <- merge(values_for_plot, strain_glossary, by='strain')
values_for_plot <- merge(values_for_plot, media_glossary, by='media')
values_for_plot$strain <- values_for_plot$fixed_strain
values_for_plot$media <- values_for_plot$named_media

values_for_plot$no_engineer <- stringr::word(sub('', '', values_for_plot$fixed_strain), 1)
values_for_plot$engineer <- stringr::word(sub('', '', values_for_plot$fixed_strain), 2)

values_for_plot$fp <- rep('NA', length(values_for_plot$media))
values_for_plot$fp[grep('GFP',values_for_plot$fixed_strain)] <- 'GFP'
values_for_plot$fp[grep('YFP',values_for_plot$fixed_strain)] <- 'YFP'
values_for_plot$fp[grep('FarRed',values_for_plot$fixed_strain)] <- 'FarRed'

values_for_lb <- values_for_plot[grep('lb', values_for_plot$sample),]
values_for_lb <- values_for_lb[-grep('blank', values_for_lb$strain),]
values_for_lb$auc_e <- sapply(values_for_lb$auc_e, function(x) x - 
                                mean(values_for_plot[grep('lb blank', values_for_plot$condition),8]))

#Only different component: RFU calculation
lb_fl_od <- merge(values_for_lb, od_auc_sum_lb , by = "sample")
lb_fl_od$rfu <- lb_fl_od$auc_e / lb_fl_od$od_auc

#For PAO1
strain_of_interest <- 'PAO1'
plot_title <- paste0('Fluorescence (470/515) of ', strain_of_interest)
y_label <- 'RFU auc_e'

p_PAO1_gfp <- ggplot2::ggplot(lb_fl_od[grep(strain_of_interest,lb_fl_od$no_engineer), ], aes(x=strain, y=rfu, fill = fp)) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(rfu) {mean(rfu) + sd(rfu)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test",
                     ref.group = paste0(strain_of_interest,' (wild-type)')) +
  scale_fill_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ylab(y_label) +
  xlab('') +
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  ggtitle(plot_title)

#For PA14
strain_of_interest <- 'PA14'
plot_title <- paste0('Fluorescence (470/515) of ', strain_of_interest)
y_label <- 'RFU auc_e'

p_PA14_gfp <- ggplot2::ggplot(lb_fl_od[grep(strain_of_interest,lb_fl_od$no_engineer), ], aes(x=strain, y=rfu, fill = fp)) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(rfu) {mean(rfu) + sd(rfu)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test",
                     ref.group = paste0(strain_of_interest,' (wild-type)')) +
  scale_fill_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ylab('') +
  xlab('') +
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  ggtitle(plot_title)

#For LESB58
strain_of_interest <- 'LESB58'
plot_title <- paste0('Fluorescence (470/515) of ', strain_of_interest)
y_label <- 'RFU auc_e'

p_LESB58_gfp <- ggplot2::ggplot(lb_fl_od[grep(strain_of_interest,lb_fl_od$no_engineer), ], aes(x=strain, y=rfu, fill = fp)) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(rfu) {mean(rfu) + sd(rfu)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test",
                     ref.group = paste0(strain_of_interest,' (wild-type)')) +
  scale_fill_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ylab('') +
  xlab('') +
  theme(legend.position="none") +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  ggtitle(plot_title)

#gfp facet
(p_PA14_gfp + p_LESB58_gfp) +
  p_PAO1_gfp


#### OD600: curve ####
directory <- '../raw-data/'
raw_filename <- '31.3 fpscreen OD.csv'
source <- paste0(directory,raw_filename)

Sample_ID <- data.table::fread(source, header = TRUE, data.table=F)

sans_time <- Sample_ID
rownames(sans_time) <- sans_time$Time
sans_time <- sans_time[,-1]

trans_dat <- data.frame( od = rep(0,length(Sample_ID$Time)*length(sans_time)),
                        time = rep(0,length(Sample_ID$Time)*length(sans_time)),
                        condition = rep(0,length(Sample_ID$Time)*length(sans_time)) )

w <- 1
for (i in 1:length(colnames(sans_time)) ) {

  for (z in 1:length(Sample_ID$Time)) {

    trans_dat$time[w] <- Sample_ID$Time[z]
    trans_dat$od[w] <- sans_time[z,i]
    trans_dat$condition[w] <- colnames(sans_time)[i]
    
    w <- w+1
  }
}

lb_for_plot <- trans_dat[-grep('tsb',trans_dat$condition),]

tsb_for_plot <- trans_dat[-grep('lb',trans_dat$condition),]

lb_for_plot$media <- stringr::word(sub('', '', lb_for_plot$condition), 1)
lb_for_plot$strain <- stringr::word(sub('', '', lb_for_plot$condition), 2)

tsb_for_plot$media <- stringr::word(sub('', '', tsb_for_plot$condition), 1)
tsb_for_plot$strain <- stringr::word(sub('', '', tsb_for_plot$condition), 2)

strain_glossary <- data.table::fread('../experimental-setup/19.3 code_strains.csv', header = TRUE, data.table=F)
media_glossary <- data.table::fread('../experimental-setup/19.3 code_media.csv', header = TRUE, data.table=F)

lb_for_plot <- merge(lb_for_plot, strain_glossary, by='strain')
lb_for_plot <- merge(lb_for_plot, media_glossary, by='media')
lb_for_plot$strain <- lb_for_plot$fixed_strain
lb_for_plot$media <- lb_for_plot$named_media

tsb_for_plot <- merge(tsb_for_plot, strain_glossary, by='strain')
tsb_for_plot <- merge(tsb_for_plot, media_glossary, by='media')
tsb_for_plot$strain <- tsb_for_plot$fixed_strain
tsb_for_plot$media <- tsb_for_plot$named_media

lb_for_plot$no_engineer <- stringr::word(sub('', '', lb_for_plot$fixed_strain), 1)
lb_for_plot$engineer <- stringr::word(sub('', '', lb_for_plot$fixed_strain), 2)

tsb_for_plot$no_engineer <- stringr::word(sub('', '', tsb_for_plot$fixed_strain), 1)
tsb_for_plot$engineer <- stringr::word(sub('', '', tsb_for_plot$fixed_strain), 2)

lb_for_plot$fp <- rep('NA', length(lb_for_plot$media))
lb_for_plot$fp[grep('GFP',lb_for_plot$fixed_strain)] <- 'GFP'
lb_for_plot$fp[grep('YFP',lb_for_plot$fixed_strain)] <- 'YFP'
lb_for_plot$fp[grep('FarRed',lb_for_plot$fixed_strain)] <- 'FarRed'

tsb_for_plot$fp <- rep('NA', length(tsb_for_plot$media))
tsb_for_plot$fp[grep('GFP',tsb_for_plot$fixed_strain)] <- 'GFP'
tsb_for_plot$fp[grep('YFP',tsb_for_plot$fixed_strain)] <- 'YFP'
tsb_for_plot$fp[grep('FarRed',tsb_for_plot$fixed_strain)] <- 'FarRed'

#Subtract blank for LB
lb_for_plot$od <- sapply(lb_for_plot$od, function(x) x - 
                                mean(lb_for_plot[grep('lb blank', lb_for_plot$condition),3]))
lb_for_plot <- lb_for_plot[-grep('blank', lb_for_plot$strain),]

#Blank for TSB
tsb_for_plot$od <- sapply(tsb_for_plot$od, function(x) x - 
                           mean(tsb_for_plot[grep('tsb blank', tsb_for_plot$condition),3]))
tsb_for_plot <- tsb_for_plot[-grep('blank', tsb_for_plot$strain),]

#For PAO1
PAO1_plot <- lb_for_plot[grep('PAO1',lb_for_plot$no_engineer),]

plot_title <- 'Growth curve (OD600) of PAO1 in LB'
y_lab <- 'OD600'

ggplot2::ggplot(PAO1_plot, aes(x=time, y=od, color=fp, shape=engineer)) +
  geom_point(alpha=0.5) +
  scale_shape_manual(values=1:length(unique(PAO1_plot$engineer))) +
  theme(legend.position="none") +
  scale_color_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

#For PA14
PA14_plot <- lb_for_plot[grep('PA14',lb_for_plot$no_engineer),]

plot_title <- 'Growth curve (OD600) of PA14 in LB'
y_lab <- 'OD600'

ggplot2::ggplot(PA14_plot, aes(x=time, y=od, color=fp, shape=engineer)) +
  geom_point(alpha=0.5) +
  scale_shape_manual(values=1:length(unique(PAO1_plot$engineer))) +
  theme(legend.position="none") +
  scale_color_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

#For LESB58
LESB58_plot <- lb_for_plot[grep('LESB58',lb_for_plot$no_engineer),]

plot_title <- 'Growth curve (OD600) of LESB58 in LB'
y_lab <- 'OD600'

ggplot2::ggplot(LESB58_plot, aes(x=time, y=od, color=fp, shape=engineer)) +
  geom_point(alpha=0.5) +
  scale_shape_manual(values=1:length(unique(PAO1_plot$engineer))) +
  theme(legend.position="none") +
  scale_color_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

#For USA300
plot_title <- 'Growth curve (OD600) of USA300 in TSB'
y_lab <- 'OD600'

ggplot2::ggplot(tsb_for_plot, aes(x=time, y=od, color=fp, shape=engineer)) +
  geom_point(alpha=0.5) +
  scale_shape_manual(values=1:length(unique(PAO1_plot$engineer))) +
  theme(legend.position="none") +
  scale_color_manual(values=c("#A45A52", "#D3D3D3")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

#### God is dead! We have killed him, beyond lies only fluorescence curves ####
#And again.. and again... and again...

#### For GFP: unstandardized ####
directory <- '../raw-data/'
raw_filename <- '6.4 lesbRESCREEN gfp.csv'
source <- paste0(directory,raw_filename)

Sample_ID <- data.table::fread(source, header = TRUE, data.table=F)

sans_time <- Sample_ID
rownames(sans_time) <- sans_time$Time
sans_time <- sans_time[,-1]

trans_dat <- data.frame( od = rep(0,length(Sample_ID$Time)*length(sans_time)),
                         time = rep(0,length(Sample_ID$Time)*length(sans_time)),
                         condition = rep(0,length(Sample_ID$Time)*length(sans_time)) )

w <- 1
for (i in 1:length(colnames(sans_time)) ) {
  
  for (z in 1:length(Sample_ID$Time)) {
    
    trans_dat$time[w] <- Sample_ID$Time[z]
    trans_dat$od[w] <- sans_time[z,i]
    trans_dat$condition[w] <- colnames(sans_time)[i]
    
    w <- w+1
  }
}

lb_for_plot <- trans_dat

lb_for_plot$media <- stringr::word(sub('', '', lb_for_plot$condition), 1)
lb_for_plot$strain <- stringr::word(sub('', '', lb_for_plot$condition), 2)

strain_glossary <- data.table::fread('../experimental-setup/19.3 code_strains.csv', header = TRUE, data.table=F)
media_glossary <- data.table::fread('../experimental-setup/19.3 code_media.csv', header = TRUE, data.table=F)

lb_for_plot <- merge(lb_for_plot, strain_glossary, by='strain')
lb_for_plot <- merge(lb_for_plot, media_glossary, by='media')
lb_for_plot$strain <- lb_for_plot$fixed_strain
lb_for_plot$media <- lb_for_plot$named_media

lb_for_plot$no_engineer <- stringr::word(sub('', '', lb_for_plot$fixed_strain), 1)
lb_for_plot$engineer <- stringr::word(sub('', '', lb_for_plot$fixed_strain), 2)

lb_for_plot$fp <- rep('NA', length(lb_for_plot$media))
lb_for_plot$fp[grep('GFP',lb_for_plot$fixed_strain)] <- 'GFP'
lb_for_plot$fp[grep('YFP',lb_for_plot$fixed_strain)] <- 'YFP'
lb_for_plot$fp[grep('FarRed',lb_for_plot$fixed_strain)] <- 'FarRed'

#Subtract blank for LB
lb_for_plot$od <- sapply(lb_for_plot$od, function(x) x - 
                           mean(lb_for_plot[grep('lb blank', lb_for_plot$condition),3]))
lb_for_plot <- lb_for_plot[-grep('blank', lb_for_plot$strain),]

#For PAO1
PAO1_plot <- lb_for_plot[grep('PAO1',lb_for_plot$no_engineer),]

plot_title <- 'Fluorescence (470/515) of PAO1 in LB'
y_lab <- 'Fluorescence units (RAW)'

plot_PAO1_gfp <- ggplot2::ggplot(PAO1_plot, aes(x=time, y=od, color=fp, shape=engineer)) +
  geom_point(alpha=0.5) +
  scale_shape_manual(values=1:length(unique(PAO1_plot$engineer))) +
  scale_color_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylim(c(-5e4,2.75e6)) +
  ylab(y_lab)

#For PA14
PA14_plot <- lb_for_plot[grep('PA14',lb_for_plot$no_engineer),]

plot_title <- 'Fluorescence (470/515) of PA14 in LB'
y_lab <- 'Fluorescence units (RAW)'

plot_PA14_gfp <- ggplot2::ggplot(PA14_plot, aes(x=time, y=od, color=fp, shape=engineer)) +
  geom_point(alpha=0.5) +
  scale_shape_manual(values=1:length(unique(PAO1_plot$engineer))) +
  scale_color_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylim(c(-5e4,2.75e6)) +
  ylab(y_lab)

#For LESB58
LESB58_plot <- lb_for_plot[grep('LESB58',lb_for_plot$no_engineer),]

plot_title <- 'Fluorescence (470/515) of LESB58 in LB'
y_lab <- 'Fluorescence units (RAW)'

plot_LESB58_gfp <- ggplot2::ggplot(LESB58_plot, aes(x=time, y=od, color=fp, shape=engineer)) +
  geom_point(alpha=0.5) +
  scale_shape_manual(values=1:length(unique(PAO1_plot$engineer))) +
  scale_color_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

#### For YFP: unstandardized ####
directory <- '../raw-data/'
raw_filename <- '6.4 lesbRESCREEN yfp.csv'
source <- paste0(directory,raw_filename)

Sample_ID <- data.table::fread(source, header = TRUE, data.table=F)

sans_time <- Sample_ID
rownames(sans_time) <- sans_time$Time
sans_time <- sans_time[,-1]

trans_dat <- data.frame( od = rep(0,length(Sample_ID$Time)*length(sans_time)),
                         time = rep(0,length(Sample_ID$Time)*length(sans_time)),
                         condition = rep(0,length(Sample_ID$Time)*length(sans_time)) )

w <- 1
for (i in 1:length(colnames(sans_time)) ) {
  
  for (z in 1:length(Sample_ID$Time)) {
    
    trans_dat$time[w] <- Sample_ID$Time[z]
    trans_dat$od[w] <- sans_time[z,i]
    trans_dat$condition[w] <- colnames(sans_time)[i]
    
    w <- w+1
  }
}

lb_for_plot <- trans_dat

lb_for_plot$media <- stringr::word(sub('', '', lb_for_plot$condition), 1)
lb_for_plot$strain <- stringr::word(sub('', '', lb_for_plot$condition), 2)

strain_glossary <- data.table::fread('../experimental-setup/19.3 code_strains.csv', header = TRUE, data.table=F)
media_glossary <- data.table::fread('../experimental-setup/19.3 code_media.csv', header = TRUE, data.table=F)

lb_for_plot <- merge(lb_for_plot, strain_glossary, by='strain')
lb_for_plot <- merge(lb_for_plot, media_glossary, by='media')
lb_for_plot$strain <- lb_for_plot$fixed_strain
lb_for_plot$media <- lb_for_plot$named_media

lb_for_plot$no_engineer <- stringr::word(sub('', '', lb_for_plot$fixed_strain), 1)
lb_for_plot$engineer <- stringr::word(sub('', '', lb_for_plot$fixed_strain), 2)

lb_for_plot$fp <- rep('NA', length(lb_for_plot$media))
lb_for_plot$fp[grep('GFP',lb_for_plot$fixed_strain)] <- 'GFP'
lb_for_plot$fp[grep('YFP',lb_for_plot$fixed_strain)] <- 'YFP'
lb_for_plot$fp[grep('FarRed',lb_for_plot$fixed_strain)] <- 'FarRed'

#Subtract blank for LB
lb_for_plot$od <- sapply(lb_for_plot$od, function(x) x - 
                           mean(lb_for_plot[grep('lb blank', lb_for_plot$condition),3]))
lb_for_plot <- lb_for_plot[-grep('blank', lb_for_plot$strain),]

#For PAO1
PAO1_plot <- lb_for_plot[grep('PAO1',lb_for_plot$no_engineer),]

plot_title <- 'Fluorescence (500/545) of PAO1 in LB'
y_lab <- 'Fluorescence units (RAW)'

plot_PAO1_yfp <- ggplot2::ggplot(PAO1_plot, aes(x=time, y=od, color=fp, shape=engineer)) +
  geom_point(alpha=1) +
  scale_shape_manual(values=1:length(unique(PAO1_plot$engineer))) +
  scale_color_manual(values=c("#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab) +
  ylim(c(-5e4,9e5))

#For PA14
PA14_plot <- lb_for_plot[grep('PA14',lb_for_plot$no_engineer),]

plot_title <- 'Fluorescence (500/545) of PA14 in LB'
y_lab <- 'Fluorescence units (RAW)'

plot_PA14_yfp <- ggplot2::ggplot(PA14_plot, aes(x=time, y=od, color=fp, shape=engineer)) +
  geom_point(alpha=1) +
  scale_shape_manual(values=1:length(unique(PAO1_plot$engineer))) +
  scale_color_manual(values=c("#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab) +
  ylim(c(-5e4,9e5))

#For LESB58
LESB58_plot <- lb_for_plot[grep('LESB58',lb_for_plot$no_engineer),]

plot_title <- 'Fluorescence (500/545) of LESB58 in LB'
y_lab <- 'Fluorescence units (RAW)'

plot_LESB58_yfp <- ggplot2::ggplot(LESB58_plot, aes(x=time, y=od, color=fp, shape=engineer)) +
  geom_point(alpha=1) +
  scale_shape_manual(values=1:length(unique(PAO1_plot$engineer))) +
  scale_color_manual(values=c("#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylim(c(-5e4,9e5)) +
  ylab(y_lab)

plot_PAO1_yfp + plot_PA14_yfp + plot_LESB58_yfp

#### For FarRed: unstandardized ####

directory <- '../raw-data/'
raw_filename <- '31.3 fpscreen FarRed.csv'
source <- paste0(directory,raw_filename)

Sample_ID <- data.table::fread(source, header = TRUE, data.table=F)

sans_time <- Sample_ID
rownames(sans_time) <- sans_time$Time
sans_time <- sans_time[,-1]

trans_dat <- data.frame( od = rep(0,length(Sample_ID$Time)*length(sans_time)),
                         time = rep(0,length(Sample_ID$Time)*length(sans_time)),
                         condition = rep(0,length(Sample_ID$Time)*length(sans_time)) )

w <- 1
for (i in 1:length(colnames(sans_time)) ) {
  
  for (z in 1:length(Sample_ID$Time)) {
    
    trans_dat$time[w] <- Sample_ID$Time[z]
    trans_dat$od[w] <- sans_time[z,i]
    trans_dat$condition[w] <- colnames(sans_time)[i]
    
    w <- w+1
  }
}

tsb_for_plot <- trans_dat

tsb_for_plot$media <- stringr::word(sub('', '', tsb_for_plot$condition), 1)
tsb_for_plot$strain <- stringr::word(sub('', '', tsb_for_plot$condition), 2)

strain_glossary <- data.table::fread('../experimental-setup/19.3 code_strains.csv', header = TRUE, data.table=F)
media_glossary <- data.table::fread('../experimental-setup/19.3 code_media.csv', header = TRUE, data.table=F)

tsb_for_plot <- merge(tsb_for_plot, strain_glossary, by='strain')
tsb_for_plot <- merge(tsb_for_plot, media_glossary, by='media')
tsb_for_plot$strain <- tsb_for_plot$fixed_strain
tsb_for_plot$media <- tsb_for_plot$named_media

tsb_for_plot$no_engineer <- stringr::word(sub('', '', tsb_for_plot$fixed_strain), 1)
tsb_for_plot$engineer <- stringr::word(sub('', '', tsb_for_plot$fixed_strain), 2)

tsb_for_plot$fp <- rep('NA', length(tsb_for_plot$media))
tsb_for_plot$fp[grep('GFP',tsb_for_plot$fixed_strain)] <- 'GFP'
tsb_for_plot$fp[grep('YFP',tsb_for_plot$fixed_strain)] <- 'YFP'
tsb_for_plot$fp[grep('FarRed',tsb_for_plot$fixed_strain)] <- 'FarRed'

#Subtract blank for tsb
tsb_for_plot$od <- sapply(tsb_for_plot$od, function(x) x - 
                           mean(tsb_for_plot[grep('tsb blank', tsb_for_plot$condition),3]))
tsb_for_plot <- tsb_for_plot[-grep('blank', tsb_for_plot$strain),]

#For USA300
plot_title <- 'Fluorescence (592/650) of USA300 in TSB'
y_lab <- 'Fluorescence units (RAW)'

plot_USA300_red <- ggplot2::ggplot(tsb_for_plot, aes(x=time, y=od, color=fp, shape=engineer)) +
  geom_point(alpha=0.5) +
  scale_shape_manual(values=1:length(unique(PAO1_plot$engineer))) +
  scale_color_manual(values=c("#A45A52", "#D3D3D3")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

#### STANDARDIZED: For gfp ####
directory <- '../raw-data/'
raw_filename <- '31.3 fpscreen gfp.csv'
source <- paste0(directory,raw_filename)

Sample_ID <- data.table::fread(source, header = TRUE, data.table=F)

sans_time <- Sample_ID
rownames(sans_time) <- sans_time$Time
sans_time <- sans_time[,-1]

trans_dat <- data.frame( od = rep(0,length(Sample_ID$Time)*length(sans_time)),
                         time = rep(0,length(Sample_ID$Time)*length(sans_time)),
                         condition = rep(0,length(Sample_ID$Time)*length(sans_time)) )

w <- 1
for (i in 1:length(colnames(sans_time)) ) {
  
  for (z in 1:length(Sample_ID$Time)) {
    
    trans_dat$time[w] <- Sample_ID$Time[z]
    trans_dat$od[w] <- sans_time[z,i]
    trans_dat$condition[w] <- colnames(sans_time)[i]
    
    w <- w+1
  }
}

lb_for_plot <- trans_dat

lb_for_plot$media <- stringr::word(sub('', '', lb_for_plot$condition), 1)
lb_for_plot$strain <- stringr::word(sub('', '', lb_for_plot$condition), 2)

strain_glossary <- data.table::fread('../experimental-setup/19.3 code_strains.csv', header = TRUE, data.table=F)
media_glossary <- data.table::fread('../experimental-setup/19.3 code_media.csv', header = TRUE, data.table=F)

lb_for_plot <- merge(lb_for_plot, strain_glossary, by='strain')
lb_for_plot <- merge(lb_for_plot, media_glossary, by='media')
lb_for_plot$strain <- lb_for_plot$fixed_strain
lb_for_plot$media <- lb_for_plot$named_media

lb_for_plot$no_engineer <- stringr::word(sub('', '', lb_for_plot$fixed_strain), 1)
lb_for_plot$engineer <- stringr::word(sub('', '', lb_for_plot$fixed_strain), 2)

lb_for_plot$fp <- rep('NA', length(lb_for_plot$media))
lb_for_plot$fp[grep('GFP',lb_for_plot$fixed_strain)] <- 'GFP'
lb_for_plot$fp[grep('YFP',lb_for_plot$fixed_strain)] <- 'YFP'
lb_for_plot$fp[grep('FarRed',lb_for_plot$fixed_strain)] <- 'FarRed'

#Subtract blank for LB
lb_for_plot$od <- sapply(lb_for_plot$od, function(x) x - 
                           mean(lb_for_plot[grep('lb blank', lb_for_plot$condition),3]))
lb_for_plot <- lb_for_plot[-grep('blank', lb_for_plot$strain),]

#Calculation of RFU
#Need an alternatively-named condition column (remove replicate number)
lb_fl_od <- lb_for_plot
od_auc_sum_lb$condition <- od_auc_sum_lb$sample

lb_fl_od <- merge(lb_fl_od, od_auc_sum_lb , by = "condition")
lb_fl_od$rfu <- lb_fl_od$od / lb_fl_od$od_auc

#For PAO1
PAO1_plot <- lb_fl_od[grep('PAO1',lb_fl_od$no_engineer),]

plot_title <- 'Std. fluorescence (470/515) of PAO1 in LB'
y_lab <- 'RFU (fl / auc_e of OD600)'

plot_PAO1_gfp_std <- ggplot2::ggplot(PAO1_plot, aes(x=time, y=rfu, color=fp, shape=engineer)) +
  geom_point(alpha=0.5) +
  scale_shape_manual(values=1:length(unique(PAO1_plot$engineer))) +
  scale_color_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

#For PA14
PA14_plot <- lb_fl_od[grep('PA14',lb_fl_od$no_engineer),]

plot_title <- 'Std. fluorescence (470/515) of PA14 in LB'
y_lab <- 'RFU (fl / auc_e of OD600)'

plot_PA14_gfp_std <- ggplot2::ggplot(PA14_plot, aes(x=time, y=rfu, color=fp, shape=engineer)) +
  geom_point(alpha=0.5) +
  scale_shape_manual(values=1:length(unique(PA14_plot$engineer))) +
  scale_color_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

#For LESB58
LESB58_plot <- lb_for_plot[grep('LESB58',lb_for_plot$no_engineer),]

plot_title <- 'Std. fluorescence (470/515) of LESB58 in LB'
y_lab <- 'RFU (fl / auc_e of OD600)'

plot_LESB58_gfp_std <- ggplot2::ggplot(LESB58_plot, aes(x=time, y=od, color=fp, shape=engineer)) +
  geom_point(alpha=0.5) +
  scale_shape_manual(values=1:length(unique(LESB58_plot$engineer))) +
  scale_color_manual(values=c("#097969", "#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

#### STANDARDIZED: For yfp ####
directory <- '../raw-data/'
raw_filename <- '31.3 fpscreen yfp.csv'
source <- paste0(directory,raw_filename)

Sample_ID <- data.table::fread(source, header = TRUE, data.table=F)

sans_time <- Sample_ID
rownames(sans_time) <- sans_time$Time
sans_time <- sans_time[,-1]

trans_dat <- data.frame( od = rep(0,length(Sample_ID$Time)*length(sans_time)),
                         time = rep(0,length(Sample_ID$Time)*length(sans_time)),
                         condition = rep(0,length(Sample_ID$Time)*length(sans_time)) )

w <- 1
for (i in 1:length(colnames(sans_time)) ) {
  
  for (z in 1:length(Sample_ID$Time)) {
    
    trans_dat$time[w] <- Sample_ID$Time[z]
    trans_dat$od[w] <- sans_time[z,i]
    trans_dat$condition[w] <- colnames(sans_time)[i]
    
    w <- w+1
  }
}

lb_for_plot <- trans_dat

lb_for_plot$media <- stringr::word(sub('', '', lb_for_plot$condition), 1)
lb_for_plot$strain <- stringr::word(sub('', '', lb_for_plot$condition), 2)

strain_glossary <- data.table::fread('../experimental-setup/19.3 code_strains.csv', header = TRUE, data.table=F)
media_glossary <- data.table::fread('../experimental-setup/19.3 code_media.csv', header = TRUE, data.table=F)

lb_for_plot <- merge(lb_for_plot, strain_glossary, by='strain')
lb_for_plot <- merge(lb_for_plot, media_glossary, by='media')
lb_for_plot$strain <- lb_for_plot$fixed_strain
lb_for_plot$media <- lb_for_plot$named_media

lb_for_plot$no_engineer <- stringr::word(sub('', '', lb_for_plot$fixed_strain), 1)
lb_for_plot$engineer <- stringr::word(sub('', '', lb_for_plot$fixed_strain), 2)

lb_for_plot$fp <- rep('NA', length(lb_for_plot$media))
lb_for_plot$fp[grep('GFP',lb_for_plot$fixed_strain)] <- 'GFP'
lb_for_plot$fp[grep('YFP',lb_for_plot$fixed_strain)] <- 'YFP'
lb_for_plot$fp[grep('FarRed',lb_for_plot$fixed_strain)] <- 'FarRed'

#Subtract blank for LB
lb_for_plot$od <- sapply(lb_for_plot$od, function(x) x - 
                           mean(lb_for_plot[grep('lb blank', lb_for_plot$condition),3]))
lb_for_plot <- lb_for_plot[-grep('blank', lb_for_plot$strain),]

#Calculation of RFU
#Need an alternatively-named condition column (remove replicate number)
lb_fl_od <- lb_for_plot
od_auc_sum_lb$condition <- od_auc_sum_lb$sample

lb_fl_od <- merge(lb_fl_od, od_auc_sum_lb , by = "condition")
lb_fl_od$rfu <- lb_fl_od$od / lb_fl_od$od_auc

#For PAO1
PAO1_plot <- lb_fl_od[grep('PAO1',lb_fl_od$no_engineer),]

plot_title <- 'Std. fluorescence (500/545) of PAO1 in LB'
y_lab <- 'RFU (fl / auc_e of OD600)'

plot_PAO1_yfp_std <- ggplot2::ggplot(PAO1_plot, aes(x=time, y=rfu, color=fp, shape=engineer)) +
  geom_point(alpha=1) +
  scale_shape_manual(values=1:length(unique(PAO1_plot$engineer))) +
  scale_color_manual(values=c("#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

#For PA14
PA14_plot <- lb_fl_od[grep('PA14',lb_fl_od$no_engineer),]

plot_title <- 'Std. fluorescence (500/545) of PA14 in LB'
y_lab <- 'RFU (fl / auc_e of OD600)'

plot_PA14_yfp_std <- ggplot2::ggplot(PA14_plot, aes(x=time, y=rfu, color=fp, shape=engineer)) +
  geom_point(alpha=1) +
  scale_shape_manual(values=1:length(unique(PA14_plot$engineer))) +
  scale_color_manual(values=c("#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

#For LESB58
LESB58_plot <- lb_for_plot[grep('LESB58',lb_for_plot$no_engineer),]

plot_title <- 'Std. fluorescence (500/545) of LESB58 in LB'
y_lab <- 'RFU (fl / auc_e of OD600)'

plot_LESB58_yfp_std <- ggplot2::ggplot(LESB58_plot, aes(x=time, y=od, color=fp, shape=engineer)) +
  geom_point(alpha=1) +
  scale_shape_manual(values=1:length(unique(LESB58_plot$engineer))) +
  scale_color_manual(values=c("#D3D3D3", "#FDDA0D")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

#### STANDARDIZED: FarRed ####

directory <- '../raw-data/'
raw_filename <- '31.3 fpscreen FarRed.csv'
source <- paste0(directory,raw_filename)

Sample_ID <- data.table::fread(source, header = TRUE, data.table=F)

sans_time <- Sample_ID
rownames(sans_time) <- sans_time$Time
sans_time <- sans_time[,-1]

trans_dat <- data.frame( od = rep(0,length(Sample_ID$Time)*length(sans_time)),
                         time = rep(0,length(Sample_ID$Time)*length(sans_time)),
                         condition = rep(0,length(Sample_ID$Time)*length(sans_time)) )

w <- 1
for (i in 1:length(colnames(sans_time)) ) {
  
  for (z in 1:length(Sample_ID$Time)) {
    
    trans_dat$time[w] <- Sample_ID$Time[z]
    trans_dat$od[w] <- sans_time[z,i]
    trans_dat$condition[w] <- colnames(sans_time)[i]
    
    w <- w+1
  }
}

tsb_for_plot <- trans_dat

tsb_for_plot$media <- stringr::word(sub('', '', tsb_for_plot$condition), 1)
tsb_for_plot$strain <- stringr::word(sub('', '', tsb_for_plot$condition), 2)

strain_glossary <- data.table::fread('../experimental-setup/19.3 code_strains.csv', header = TRUE, data.table=F)
media_glossary <- data.table::fread('../experimental-setup/19.3 code_media.csv', header = TRUE, data.table=F)

tsb_for_plot <- merge(tsb_for_plot, strain_glossary, by='strain')
tsb_for_plot <- merge(tsb_for_plot, media_glossary, by='media')
tsb_for_plot$strain <- tsb_for_plot$fixed_strain
tsb_for_plot$media <- tsb_for_plot$named_media

tsb_for_plot$no_engineer <- stringr::word(sub('', '', tsb_for_plot$fixed_strain), 1)
tsb_for_plot$engineer <- stringr::word(sub('', '', tsb_for_plot$fixed_strain), 2)

tsb_for_plot$fp <- rep('NA', length(tsb_for_plot$media))
tsb_for_plot$fp[grep('GFP',tsb_for_plot$fixed_strain)] <- 'GFP'
tsb_for_plot$fp[grep('YFP',tsb_for_plot$fixed_strain)] <- 'YFP'
tsb_for_plot$fp[grep('FarRed',tsb_for_plot$fixed_strain)] <- 'FarRed'

#Subtract blank for tsb
tsb_for_plot$od <- sapply(tsb_for_plot$od, function(x) x - 
                            mean(tsb_for_plot[grep('tsb blank', tsb_for_plot$condition),3]))
tsb_for_plot <- tsb_for_plot[-grep('blank', tsb_for_plot$strain),]

#Calculation of RFU
#Need an alternatively-named condition column (remove replicate number)
tsb_fl_od <- tsb_for_plot
od_auc_sum_tsb$condition <- od_auc_sum_tsb$sample

tsb_fl_od <- merge(tsb_fl_od, od_auc_sum_tsb , by = "condition")
tsb_fl_od$rfu <- tsb_fl_od$od / tsb_fl_od$od_auc


#For USA300
plot_title <- 'Std. fluorescence (592/650) of USA300 in TSB'
y_lab <- 'RFU (fl / auc_e of OD600)'

plot_USA300_red <- ggplot2::ggplot(tsb_fl_od, aes(x=time, y=rfu, color=fp, shape=engineer)) +
  geom_point(alpha=0.5) +
  scale_shape_manual(values=1:length(unique(tsb_for_plot$engineer))) +
  scale_color_manual(values=c("#A45A52", "#D3D3D3")) +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)
