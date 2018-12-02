# Loads the Shiny and leaflet libraries.
library(shiny)
library(leaflet)

# read the file
crime <- read.csv("Crime_Incidents_in_2017.csv", header=TRUE, stringsAsFactors=FALSE)
