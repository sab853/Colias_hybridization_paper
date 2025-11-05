#Script to measure the distance to the nearest road, using our sampling sites in meters. 
#This script uses the longitude and latitude of each collection point and uses a Google API key to measure the distance to the nearest road

#Load packages
library(googleway)
library(readxl)
library(dplyr)
library(geosphere)
library(readxl)

Fieldwork_datasheet <- read_excel("Fieldwork_datasheet_2024.xlsx")
View(Fieldwork_datasheet)

name1<- Fieldwork_datasheet$`Park Name`
lat1<- Fieldwork_datasheet$Latitude
long1<- Fieldwork_datasheet$Longitude


#Run to get distance to the nearest road
mydf1 <- data.frame(site_name = (name1),
                    from_lat = (lat1),
                    from_long = (long1),
                    to_lat = (43.642342),
                    to_long = (-79.387386))

pls <- lapply(1:nrow(mydf1), function(x){
  
  foo <- google_directions(origin = unlist(mydf1[x, 2:3]),
                           destination = unlist(mydf1[x, 4:5]),
                           key = "", #insert API here
                           mode = "driving",
                           simplify = TRUE)
  
  ## Decode the polyline into lat/lon coordinates
  pl <- decode_pl(foo$routes$overview_polyline$points)
  
  return(pl)
})

closest_road<-list()
for(i in 1:length(pls)){
  closest_road[[i]]<-pls[[i]][1,]
}

distance_to_closest_road<-list()
for(x in 1:nrow(mydf1)){
  distance_to_closest_road[[x]]<-distm(c(unlist(mydf1[x,2:3])), c(unlist(closest_road[[x]])), fun=distHaversine)
}

distance_to_closest_road
mydf1$distances<-unlist(distance_to_closest_road)

mydf1

