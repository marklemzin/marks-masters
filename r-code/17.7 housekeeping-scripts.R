#### Saving packages for my update to R 4.5.1 (for terra)
library(pacman)
#Prior to installation
#mypks <- pacman::p_lib()
#saveRDS(mypks, "~/mypks.rds")
#After installation
mypks <- readRDS("~/mypks.rds")
install.packages(mypks)
