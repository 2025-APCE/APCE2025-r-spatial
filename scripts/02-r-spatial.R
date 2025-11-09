# course Advanced Population and Community Ecology (APCE) -  2025
# Spatial analysis in R
# Han Olff nov 2025


#--------------------------01 Set up the environment ----
# clear the working environment
rm(list = ls())
# run the setup script for user-defined functions and Google Sheets authentication
source("scripts/01-setup.R")
# authenticate Google Sheets access
gsheets_auth(email='m.y.name@rug.nl')  # change in your own email address
# set the working directory where your GIS data are located
setwd("G:/Shared drives/_Org OlffLab/Teaching/APCE/_general/APCE_GIS")

# restore the libraries of the project 
renv::restore()


# load the different libraries
library(terra)       # for working with raster data (although it also deals with vector data)
library(tidyterra)   # for adding terra objects to ggplot
library(ggspatial)  # for scale bars
library(sf)          # for vector data objects
library(tidyverse)   # ggplot, dplyr etc
library(scales)      # for oob (out of bounds) scale
library(ggnewscale) # for using multiple color fill scales in ggplot
library(patchwork)  # for combining multiple ggplots in one panel plot

# explore color palettes
# also see https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/
# Base R palettes
barplot(rep(1,10), col = grey.colors(10))
# each color has a hexadecimal code, and a list of such codes defines a palette
grey.colors(10)
# define a user palette, either as text colors 
DutchFlagCols<-c("blue","white","red")
# same as hexadecimal colors
mycolors<-c("#0000FF","#FFFFFF","#FF0000")
barplot(rep(1,3), col = mycolors, horiz=T)
# use existing palettes in base R, where rev() means reverse the palette order
barplot(rep(1,10), col = rev(topo.colors(10))) # rev turns the scale arround
barplot(rep(1,10), col = rev(terrain.colors(10)))

# find other palettes in packages, as RColorBrewer, viridis, wesanderson
library(RColorBrewer) 
RColorBrewer::display.brewer.all()
barplot(rep(1,10), col = RColorBrewer::brewer.pal(10, "Spectral"))
barplot(rep(1,10), col = RColorBrewer::brewer.pal(10, "BrBG"))
library(viridis)
barplot(rep(1,10), col = viridis::plasma(10)) # show colors
barplot(rep(1,10), col = viridis::viridis(10))
barplot(rep(1,10), col = viridis::inferno(10))
barplot(rep(1,10), col = viridis::turbo(10))
barplot(rep(1,10), col = viridis::mako(10))
library(wesanderson) # from eg the movie "The Life Aquatic with Steve Zissou"
# browseURL("https://www.youtube.com/watch?v=UpU0DZXTGA0") # movie trailer
barplot(rep(1,10), col = rev(wesanderson::wes_palette("Zissou1", 10, type = "continuous")))
pal_zissou1<-rev(wesanderson::wes_palette("Zissou1", 10, type = "continuous"))
pal_zissou2<-wesanderson::wes_palette("Zissou1", 10, type = "continuous")

# load the vector data for the Serengeti ecosystem
sf::st_layers("./2022_protected_areas/protected_areas.gpkg") # show which layers are in the geopackage
protected_areas<-terra::vect("./2022_protected_areas/protected_areas.gpkg",
                             layer="protected_areas_2022") # read protected area boundaries)
sf::st_layers("./2022_rivers/rivers_hydrosheds.gpkg")
rivers<-terra::vect("./2022_rivers/rivers_hydrosheds.gpkg",
                    layer="rivers_hydrosheds")
sf::st_layers("./lakes/lakes.gpkg")
lakes<-terra::vect("./lakes/lakes.gpkg",
                   layer="lakes")  

# read your study area !! check if this matches indeed the name of your area
sf::st_layers("./studyarea/studyarea.gpkg")
studyarea<-terra::vect("./studyarea/studyarea.gpkg",
                       layer="my_study_area")


# load the raster data for the whole ecosystem
woodybiom<-terra::rast("./2016_WoodyVegetation/TBA_gam_utm36S.tif")
hillshade<-terra::rast("./2023_elevation/hillshade_z5.tif")
rainfall<-terra::rast("./rainfall/CHIRPS_MeanAnnualRainfall.tif")
elevation<-terra::rast("./2023_elevation/elevation_90m.tif")
terra::plot(elevation)
# inspect the data 


# set the limits of the map to show (xmin, xmax, ymin, ymax in utm36 coordinates)
xlimits<-c(550000,900000)
ylimits<-c(9600000,9950000)

# plot the woody biomass map that you want to predict

# make elevation map  

# combine the maps with patchwork


# plot the rainfall map

# plot the elevation map

# combine the different maps  into one composite map using the patchwork library
# and save it to a high resolution png


############################
### explore your study area
# set the limits of your study area
xlimits<-sf::st_bbox(studyarea)[c(1,3)]
ylimits<-sf::st_bbox(studyarea)[c(2,4)]
saExt<-terra::ext(studyarea)
saExt


# plot the woody biomass for your study area

# plot elevation map for the study area


# plot rainfall map for the study area
# first you need to increase the raster resolution to 30 m
# Define the extent and resolution for the new raster

# Resample the raster to 30m resolution


### the following you can only do for layers that you have generated yourself 
### and downloaded from Earth Engine and you have put in your folder ./MyData

# plot distance to river for the study area


# burning frequency map from 2001 - 2016


# soil cation exchange capacity (CEC)

# landform hills 


# core_protected_areas  map 

# create 250 random points in your study area


# plot the points


# combine the maps with patchwork


#########################
# extract your the values of the different raster layers to the points
# Extract raster values at the points




# merge the different variable into a single table
# use woody biomass as the last variable

# plot how woody cover is predicted by different variables
# Create a correlation panel plot


# make long format

# make a panel plot with ggplot using facet_wrap

# do a pca
# Load the vegan package
library(vegan)
# Perform PCA using the rda() function from vegan

# Display a summary of the PCA

# Plot the PCA

# Add points for samples

# Add arrows for variables

# Label the variables with arrows

# Add axis labels and a title
title(main = "PCA Biplot")
xlabel <- paste("PC1 (", round(pca_result$CA$eig[1] / sum(pca_result$CA$eig) * 100, 1), "%)", sep = "")
ylabel <- paste("PC2 (", round(pca_result$CA$eig[2] / sum(pca_result$CA$eig) * 100, 1), "%)", sep = "")
title(xlab=xlabel)
title(ylab=ylabel)

# add contours for woody cover

