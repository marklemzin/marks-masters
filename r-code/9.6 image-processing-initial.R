#9.6 Calculating image intensity ratios and color heterogeneity

# Dependencies
library(magick)

library(reshape2)

library(ash)

library(tidyverse)

library(spatstat)
library(tiff)

#### Spatstat: import as im (sect 3.6) ####
fn <- "../raw-data/28.6 back to basics/16h/imageJ-FFT/FFT gfp 323mono gfp.tif"
mat <- readTIFF(fn, as.is=TRUE, info=TRUE)
str(mat)

smat <- transmat(mat, from="European", to="spatstat")
test_im <- im(smat)

#Pixel is 1.175um (according to 200um scale, length is 235 pixels)
pixscale <- 1.175
test_im <- im(smat,
              xrange=c(0, ncol(smat) * pixscale),
              yrange=c(0, nrow(smat) * pixscale),
              unitname="um")

summary(test_im)

#### Spatstat: exploring im (sect 4.3) ####
plot(test_im)

test_X <- eval.im( test_im > 60 )
plot(test_X)

#### Spatstat: homogeneous intensity (6.2) ####
#Intensity estimate
mat <- as.matrix(test_X)
melt <- melt( mat )
melt <- melt[melt$value==TRUE,]

X <- ppp(melt$Var1, melt$Var2,
         c( 0, nrow(as.matrix(test_im)) ) ,
         c( 0, ncol(as.matrix(test_im)) ))

X <- rescale(X, 
  s=1/pixscale,
  unitname="um")

#Corresponding standard error (given a Poisson distribution: var = mean)
lam <- intensity(X)
(sdX <- sqrt(lam/area(Window(X))))
#So the se is 0.000169 points per square um

#### Quadrant counting (6.4) ####
#Note confusing spelling: 'quadrat'
Q3 <- quadratcount( X , nx=3 , ny=3 )
Q3

intensity(Q3)

# Tesselating quadrants: hexagons
H <- hextess( X, 1 )
#hQ <- quadratcount( X, tess=H )
# Quadrat count freaks out with enormous datasheets
hQ <- pixellate( X )

#Null hypothesis is a poisson distribution: I.E. below 0.05 means nonrandom distribution
tS <- quadrat.test(X, 3, 3)
#Neat little pooling function available when asking if multiple 'datasets' are all random

den <- density(X, sigma=40)
plot(den)
persp.im(den)
contour.im(den)

#Optimized sigma value (extremely slow)
b <- bw.ppl(X)
#another method is bw.scott
D <- density( X, sigma=bw.diggle(X) )

#### Experimentation: color intensity... a failure ####
test_image_PA14_co <- magick::image_read(path = '/Users/64204/Desktop/master/raw-data/28.6 back to basics/16h/imageJ-FFT/FFT gfp 323co.tif')
test_image_PA14_mono <- magick::image_read(path = '/Users/64204/Desktop/master/raw-data/28.6 back to basics/16h/imageJ-FFT/FFT gfp 323mono.tif')

test_map_co <- as.integer( magick::image_data( test_image_PA14_co , channels="Gray" ) )[,,1]
test_map_mono <- as.integer( magick::image_data( test_image_PA14_mono , channels="Gray" ) )[,,1]

#Effects of FFT
#Matrix to column format, and binary filter. For monoculture.
mono_melt <- reshape2::melt( test_map_mono )
mono_threshold <- dplyr::filter( mono_melt , value>60 )
bins_mono <- ash::bin2(cbind(mono_threshold$Var1, mono_threshold$Var2) , nbin=c(100,100))

mono_bins_melt <- reshape2::melt( bins_mono$nc )

ggplot( mono_bins_melt , aes( x = Var2, y = Var1, fill = value )) +
  geom_tile() +
  theme_bw() +
  scale_y_reverse()

#Matrix to column format, and binary filter. For coculture.
co_melt <- reshape2::melt( test_map_co )
co_threshold <- dplyr::filter( co_melt , value>60 )
bins_co <- ash::bin2(cbind(co_threshold$Var1, co_threshold$Var2) , nbin=c(100,100))

co_bins_melt <- reshape2::melt( bins_co$nc )

ggplot( co_bins_melt , aes( x = Var2, y = Var1, fill = value )) +
  geom_tile() +
  theme_bw() +
  scale_y_reverse()

#With everything looking alright, I'll return to the original matrices.

# Create ppp objects
pa_mask <- test_map_mono > 60
sa_mask <- test_map_mono <= 60
pa_pts <- which(pa_mask > 0, arr.ind = TRUE)
sa_pts <- which(sa_mask > 0, arr.ind = TRUE)
pa_ppp <- ppp(x = p_a_pts[,1], y = p_a_pts[,2], window = window)
s_a_ppp <- ppp(x = s_a_pts[,1], y = s_a_pts[,2], window = window)


#### Experimentation: local standardization ####
test_image_gfp <- magick::image_read(path = '/Users/64204/Desktop/master/raw-data/14.6 6h full rescreen/10x/538 gfp.tif')
test_image_red <- magick::image_read(path = '/Users/64204/Desktop/master/raw-data/14.6 6h full rescreen/10x/538 red.tif')

test_map_gfp <- as.integer( magick::image_data( test_image_gfp , channels="Gray" ) )[,,1]
test_map_red <- as.integer( magick::image_data( test_image_red , channels="Gray" ) )[,,1]

# An example: linear gradient + cube selection
x <- 100
y <- 100
min_max_diff <- range( test_map_gfp[x-50:x+50,y-50:y+50] )
intensity_step <- 255 /(min_max_diff[2] - min_max_diff[1])
( sample(min_max_diff[1]:min_max_diff[2] , 1) - min_max_diff[1] ) * intensity_step

## Using pre-calculated ranges
# 'Node' matrix
box_size <- 100
x_nodes <- seq( from=1+box_size/2 , to=length(test_map_gfp[1,])-box_size/2 , by=box_size )
y_nodes <- seq( from=1+box_size/2 , to=length(test_map_gfp[,1]-box_size/2 ) , by=box_size )

node_intensity_step <- matrix( , nrow=length(x_nodes) , ncol=length(y_nodes) )
node_minimum_intensity <- matrix( , nrow=length(x_nodes) , ncol=length(y_nodes) )

for ( x in 1:length(x_nodes) ) {
  for ( y in 1:length(y_nodes) ) {
    min_max_diff <- range( test_map_gfp[y_nodes[y]-(box_size/2):y_nodes[y]+(box_size/2),
                           x_nodes[x]-(box_size/2):x_nodes[x]+(box_size/2)])
    intensity_step <- 255 /(min_max_diff[2] - min_max_diff[1])
    node_intensity_step[x,y] <- intensity_step
    node_minimum_intensity[x,y] <- min_max_diff[1]
  }
  print(x)
}

# 'Node' matrix reversion into full-size matrix
intensity_step_map <- matrix( , nrow = length(test_map_gfp[,1]) , ncol = length(test_map_gfp[1,]) )
minimum_intensity_map <- matrix( , nrow = length(test_map_gfp[,1]) , ncol = length(test_map_gfp[1,]) )

for ( x in 1:length(x_nodes) ) {
  for ( y in 1:length(y_nodes) ) {
    intensity_step_map[y_nodes[y]-(box_size/2):y_nodes[y]+(box_size/2),
                       x_nodes[x]-(box_size/2):x_nodes[x]+(box_size/2)] <- node_intensity_step[x,y]
    minimum_intensity_map[y_nodes[y]-(box_size/2):y_nodes[y]+(box_size/2),
                          x_nodes[x]-(box_size/2):x_nodes[x]+(box_size/2)] <- node_minimum_intensity[x,y]
  }
}

# Actual image adjustment
adjusted_map_gfp <- matrix( , nrow = length(test_map_gfp[,1]) , ncol = length(test_map_gfp[1,]) )

for ( x in 51:length(test_map_gfp[1,]-50 ) ) {
  for ( y in 51:length(test_map_gfp[,1]-50 ) ) {
    adjusted_map_gfp[y,x] <- (test_map_gfp[y,x] - minimum_intensity_map[y,x] ) * intensity_step_map[y,x]
  }
  print(x)
}

# Adjustment confirmation
gfp_melt <- reshape2::melt( adjusted_map_gfp )
gfp_threshold <- filter( gfp_melt , value>150 )
bins_gfp <- bin2(cbind(gfp_threshold$Var1, gfp_threshold$Var2) , nbin=c(100,100))

gfp_bins_melt <- reshape2::melt( bins_gfp$nc )

ggplot( gfp_bins_melt , aes( x = Var2, y = Var1, fill = value )) +
  geom_tile() +
  theme_bw() +
  scale_y_reverse()

## Repetition for red
box_size <- 100
x_nodes <- seq( from=1+box_size/2 , to=length(test_map_red[1,])-box_size/2 , by=box_size )
y_nodes <- seq( from=1+box_size/2 , to=length(test_map_red[,1]-box_size/2 ) , by=box_size )
node_intensity_step <- matrix( , nrow=length(x_nodes) , ncol=length(y_nodes) )
node_minimum_intensity <- matrix( , nrow=length(x_nodes) , ncol=length(y_nodes) )
for ( x in 1:length(x_nodes) ) {
  for ( y in 1:length(y_nodes) ) {
    min_max_diff <- range( test_map_red[y_nodes[y]-(box_size/2):y_nodes[y]+(box_size/2),
                                        x_nodes[x]-(box_size/2):x_nodes[x]+(box_size/2)])
    intensity_step <- 255 /(min_max_diff[2] - min_max_diff[1])
    node_intensity_step[x,y] <- intensity_step
    node_minimum_intensity[x,y] <- min_max_diff[1]
  }
  print(x)
}
intensity_step_map <- matrix( , nrow = length(test_map_red[,1]) , ncol = length(test_map_red[1,]) )
minimum_intensity_map <- matrix( , nrow = length(test_map_red[,1]) , ncol = length(test_map_red[1,]) )
for ( x in 1:length(x_nodes) ) {
  for ( y in 1:length(y_nodes) ) {
    intensity_step_map[y_nodes[y]-(box_size/2):y_nodes[y]+(box_size/2),
                       x_nodes[x]-(box_size/2):x_nodes[x]+(box_size/2)] <- node_intensity_step[x,y]
    minimum_intensity_map[y_nodes[y]-(box_size/2):y_nodes[y]+(box_size/2),
                          x_nodes[x]-(box_size/2):x_nodes[x]+(box_size/2)] <- node_minimum_intensity[x,y]
  }
}
adjusted_map_red <- matrix( , nrow = length(test_map_red[,1]) , ncol = length(test_map_red[1,]) )
for ( x in 51:length(test_map_red[1,]-50 ) ) {
  for ( y in 51:length(test_map_red[,1]-50 ) ) {
    adjusted_map_red[y,x] <- (test_map_red[y,x] - minimum_intensity_map[y,x] ) * intensity_step_map[y,x]
  }
  print(x)
}
red_melt <- reshape2::melt( adjusted_map_red )
red_threshold <- filter( red_melt , value>50 )
bins_red <- bin2(cbind(red_threshold$Var1, red_threshold$Var2) , nbin=c(100,100))
red_bins_melt <- reshape2::melt( bins_red$nc )
ggplot( red_bins_melt , aes( x = Var2, y = Var1, fill = value )) +
  geom_tile() +
  theme_bw() +
  scale_y_reverse()

# :) Appears successful. Now for the combination.
overlapped_map <- abs(adjusted_map_gfp - adjusted_map_red)
overlapped_melt <- reshape2::melt( overlapped_map )
overlapped_threshold <- filter( overlapped_melt , value < 70 )
bins_overlapped <- bin2(cbind(overlapped_threshold$Var1, overlapped_threshold$Var2) , nbin=c(100,100))
overlapped_bins_melt <- reshape2::melt( bins_overlapped$nc )
ggplot( overlapped_bins_melt , aes( x = Var2, y = Var1, fill = value )) +
  geom_tile() +
  theme_bw() +
  scale_y_reverse()

# Legacy: horrendously inefficient
adjusted_map_gfp <- matrix( , nrow = length(test_map_gfp[,1]) , ncol = length(test_map_gfp[1,]) )

for ( x in 51:length(test_map_gfp[1,]-50 ) ) {
  for ( y in 51:length(test_map_gfp[,1]-50 ) ) {
    min_max_diff <- range( test_map_gfp[x-50:x+50,y-50:y+50] )
    intensity_step <- 255 /(min_max_diff[2] - min_max_diff[1])
    adjusted_map_gfp[x,y] <- (test_map_gfp[x,y] - min_max_diff[1] ) * intensity_step
  }
  print(x)
}

#### Color ratio ####

test_image_gfp <- magick::image_read(path = '/Users/64204/Desktop/master/raw-data/4.6 rescreen 1 of 2/imageJ-gamma/Gamma gfp pilA 100x.jpg')
test_image_red <- magick::image_read(path = '/Users/64204/Desktop/master/raw-data/4.6 rescreen 1 of 2/imageJ-gamma/Gamma red pilA 100x.jpg')

test_map_gfp <- as.integer( image_data( test_image_gfp , channels="Gray" ) )
test_map_red <- as.integer( image_data( test_image_red , channels="Gray" ) )

### Experimentation: necessity for color standardization (see graphs produced)

# Red
red_melt <- reshape2::melt( test_map_red )
red_threshold <- filter( red_melt , value>60 )
bins_red <- bin2(cbind(red_threshold$Var1, red_threshold$Var2) , nbin=c(100,100))

red_bins_melt <- reshape2::melt( bins_red$nc )

ggplot( red_bins_melt , aes( x = Var2, y = Var1, fill = value )) +
  geom_tile() +
  theme_bw() +
  scale_y_reverse()

# Green
gfp_melt <- reshape2::melt( test_map_gfp )
gfp_threshold <- filter( gfp_melt , value>80 )
bins_gfp <- bin2(cbind(gfp_threshold$Var1, gfp_threshold$Var2) , nbin=c(100,100))

gfp_bins_melt <- reshape2::melt( bins_gfp$nc )

ggplot( gfp_bins_melt , aes( x = Var2, y = Var1, fill = value )) +
  geom_tile() +
  theme_bw() +
  scale_y_reverse()

#Simple localized standardization
mapping_base <- test_map_gfp[,,1]
mapping_std <- mapping_base

for ( y in 1:ncol(mapping_base) ) {
  for ( x in 1:nrow(mapping_base) ) {
    if (x!=1 & x!=nrow(mapping_base) & y!=ncol(mapping_base) & y!=1 ) {
      neighbours <- c( mapping_base[x+1,y], mapping_base[x-1,y], mapping_base[x,y+1], mapping_base[x,y-1])
      # A thought: contrast settings! (max(neighbours) - min(neighbours)) /255
      mapping_std[x,y] <- mapping_base[x,y] * ( 255 / max(neighbours) )
    }
  }
}

#Checking the outputs
gfp_melt <- reshape2::melt( mapping_std )
gfp_threshold <- filter( gfp_melt , value>252 )
bins_gfp <- bin2(cbind(gfp_threshold$Var1, gfp_threshold$Var2) , nbin=c(100,100))

gfp_bins_melt <- reshape2::melt( bins_gfp$nc )

ggplot( gfp_bins_melt , aes( x = Var2, y = Var1, fill = value )) +
  geom_tile() +
  theme_bw() +
  scale_y_reverse()

ncol( mapping_base )
nrow( mapping_base )

# I'll need a straight Gamma pass

### Legacy section - using merged images for analysis

# Image import using imageMagick
test_image <- magick::image_read(path = '/Users/64204/Desktop/master/raw-data/4.6 rescreen 1 of 2/imageJ-merge/Merged 317 10x.jpg')

#Conversion to colored bitmap
test_dataset_jpg <- image_data( test_image )
#channel_types()
image_separate( test_image, channel = "Red" )
image_separate( test_image, channel = "Green" )
image_separate( test_image, channel = "Blue" )
test_bitmap <- as.integer( test_dataset_jpg )
melted_bitmap <- reshape2::melt(test_bitmap)

