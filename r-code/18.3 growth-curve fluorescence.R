
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

values_for_plot <- Sample_ID_out[!grepl('empty',Sample_ID_out$condition),]
values_for_plot$media <- stringr::word(sub('', '', values_for_plot$condition), 1)
values_for_plot$strain <- stringr::word(sub('', '', values_for_plot$condition), 2)

ggplot2::ggplot(values_for_plot, aes(x=media, y=auc_e, fill=media)) +
  facet_grid( . ~ strain ) +
  geom_point(alpha=0.3) +
  stat_summary(fun.y=mean, geom="bar", alpha=0.3, color='black' ) +
  stat_summary(fun.y=function(auc_e) {mean(auc_e) + sd(auc_e)*c(-1,1)}, geom="point", shape="\U2014", 
               size=7, colour="black") +
  theme(legend.position="none") +
  paletteer::scale_fill_paletteer_d("palettetown::ariados") +
  stat_compare_means(method = "anova", label.y = 14) +
  stat_compare_means(label = "p.signif", method = "t.test",
                     ref.group = "lb", label.y = 13)

#### Fluorescence: Area under the curve ####
