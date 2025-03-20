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

#tidyverse
library(ggplot2)

#### OD600: Area under the curve ####
directory <- '../raw-data/'
raw_filename <- '17.3 pilot 308.309.311 OD.csv'
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

#Standardize to blank
values_for_lb <- values_for_plot[grep('lb', values_for_plot$sample),]
values_for_lb <- values_for_lb[-grep('blank', values_for_lb$strain),]
#For average blank AUC_e, use the 8th column
values_for_lb$auc_e <- sapply(values_for_lb$auc_e, function(x) x - 
                                mean(values_for_plot[grep('lb blank', values_for_plot$condition),10]))

#As above for TCM
values_for_tcm <- values_for_plot[grep('tcm', values_for_plot$sample),]
values_for_tcm <- values_for_tcm[-grep('blank', values_for_tcm$strain),]
#For average blank AUC_e, use the 8th column
values_for_tcm$auc_e <- sapply(values_for_tcm$auc_e, function(x) x - 
                                mean(values_for_plot[grep('tcm blank', values_for_plot$condition),10]))

plot_title <- 'Good growth in LB across strains'
y_label <- 'AUC_e (OD600 x h)'

ggplot2::ggplot(values_for_lb, aes(x=media, y=auc_e, fill=media)) +
  facet_grid( . ~ strain ) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(auc_e) {mean(auc_e) + sd(auc_e)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test",
                     comparisons = list(c('LB','LB + Gm50')), label.y = 12.5) +
  theme(legend.position="none") +
  paletteer::scale_fill_paletteer_d("palettetown::ariados") +
  theme_bw() +
  ylab(y_label) +
  ggtitle(plot_title)

#Temporary tcm plot

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

#Average AUC. For fluorescence calculations
condition_list <- unique(values_for_lb$condition)
od_mean_auc <- numeric(length=length(condition_list))

for ( i in 1:length(condition_list) ) {
  od_mean_auc[i] <- mean(values_for_lb$auc_e[grep(condition_list[i], values_for_lb$condition)])
}

od_auc_sum <- data.frame( condition = condition_list , od_auc = od_mean_auc )

#### Fluorescence: Area under the curve ####
directory <- '../raw-data/'
raw_filename <- '17.3 pilot 308.309.311 YFP.csv'
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

values_for_plot <- merge(values_for_plot, strain_glossary, by='strain')
values_for_plot <- merge(values_for_plot, media_glossary, by='media')
values_for_plot$strain <- values_for_plot$fixed_strain
values_for_plot$media <- values_for_plot$named_media

values_for_lb <- values_for_plot[grep('lb', values_for_plot$sample),]
values_for_lb <- values_for_lb[-grep('blank', values_for_lb$strain),]
values_for_lb$auc_e <- sapply(values_for_lb$auc_e, function(x) x - 
                                mean(values_for_plot[grep('lb blank', values_for_plot$condition),8]))

#Only different component: RFU calculation
lb_fl_od <- merge(values_for_lb, od_auc_sum , by = "condition")
lb_fl_od$rfu <- lb_fl_od$auc_e / lb_fl_od$od_auc

graph_title <- '500/543 is good for YFP, less so for eGFP (16h growth)'
y_label <- 'RFU (YFP; 500/543)'

ggplot2::ggplot(lb_fl_od, aes(x=media, y=rfu, fill=media)) +
  facet_grid( . ~ strain ) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(rfu) {mean(rfu) + sd(rfu)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  stat_compare_means(label = "p.signif", method = "t.test",
                     comparisons = list(c('LB','LB + Gm50'))) +
  theme(legend.position="none") +
  paletteer::scale_fill_paletteer_d("palettetown::ariados") +
  ggtitle(graph_title) +
  ylab(y_label) +
  theme_bw()

#### OD600: curve ####
directory <- '../raw-data/'
raw_filename <- '17.3 pilot 308.309.311 OD.csv'
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

od_for_plot <- trans_dat[-c(grepl('empty',Sample_ID_out$condition), grepl('tcm',Sample_ID_out$condition)),]

od_for_plot$media <- stringr::word(sub('', '', od_for_plot$condition), 1)
od_for_plot$strain <- stringr::word(sub('', '', od_for_plot$condition), 2)

strain_glossary <- data.table::fread('../experimental-setup/19.3 code_strains.csv', header = TRUE, data.table=F)
media_glossary <- data.table::fread('../experimental-setup/19.3 code_media.csv', header = TRUE, data.table=F)

od_for_plot <- merge(od_for_plot, strain_glossary, by='strain')
od_for_plot <- merge(od_for_plot, media_glossary, by='media')
od_for_plot$strain <- od_for_plot$fixed_strain
od_for_plot$media <- od_for_plot$named_media

#Subtract blank
od_for_plot$od <- sapply(od_for_plot$od, function(x) x - 
                                mean(od_for_plot[grep('lb blank', od_for_plot$condition),3]))
od_for_plot <- od_for_plot[-grep('blank', od_for_plot$strain),]

plot_title <- 'Same as before where TCM does not cook'
y_lab <- 'OD600'

ggplot2::ggplot(od_for_plot, aes(x=time, y=od, fill=media)) +
  facet_grid( media ~ strain ) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="point", alpha=0.3, shape="\U2014", 
               size=3, color='black', alpha=0.7 ) +
  stat_summary(fun.y=function(od) {mean(od) + sd(od)*c(-1,1)}, geom="point", shape="\U2014", 
               size=2, colour="black", alpha=0.7 ) +
  theme(legend.position="none") +
  paletteer::scale_fill_paletteer_d("palettetown::ariados") +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

#### FL: curve ####
#All over again!

directory <- '../raw-data/'
raw_filename <- '17.3 pilot 308.309.311 YFP.csv'
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

fl_for_plot <- trans_dat[-c(grepl('empty',Sample_ID_out$condition), grepl('tcm',Sample_ID_out$condition)),]

fl_for_plot$media <- stringr::word(sub('', '', fl_for_plot$condition), 1)
fl_for_plot$strain <- stringr::word(sub('', '', fl_for_plot$condition), 2)

strain_glossary <- data.table::fread('../experimental-setup/19.3 code_strains.csv', header = TRUE, data.table=F)
media_glossary <- data.table::fread('../experimental-setup/19.3 code_media.csv', header = TRUE, data.table=F)

fl_for_plot <- merge(fl_for_plot, strain_glossary, by='strain')
fl_for_plot <- merge(fl_for_plot, media_glossary, by='media')
fl_for_plot$strain <- fl_for_plot$fixed_strain
fl_for_plot$media <- fl_for_plot$named_media

#Subtract blank
fl_for_plot$od <- sapply(fl_for_plot$od, function(x) x - 
                           mean(fl_for_plot[grep('lb blank', fl_for_plot$condition),3]))
fl_for_plot <- fl_for_plot[-grep('blank', fl_for_plot$strain),]

#Fixing name convention
fl_for_plot$condition <- ifelse(is.na(stringr::word(fl_for_plot$condition, 1, 2)),
                                fl_for_plot$condition,
                                stringr::word(fl_for_plot$condition, 1, 2))

#Convert to RFU
rfu_for_plot <- merge(fl_for_plot, od_auc_sum, by = "condition")
rfu_for_plot$rfu <- rfu_for_plot$od / rfu_for_plot$od_auc

plot_title <- '500/543 captures YFP, and a bit of GFP'
y_lab <- 'RFU (YFP; 500/543)'

ggplot2::ggplot(rfu_for_plot, aes(x=time, y=rfu, fill=media)) +
  facet_grid( media ~ strain ) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="point", alpha=0.3, shape="\U2014", 
               size=3, color='black' ) +
  stat_summary(fun.y=function(rfu) {mean(rfu) + sd(rfu)*c(-1,1)}, geom="point", shape="\U2014", 
               size=2, colour="black" ) +
  theme(legend.position="none") +
  paletteer::scale_fill_paletteer_d("palettetown::ariados") +
  theme_bw() +
  ggtitle(plot_title) +
  ylab(y_lab)

