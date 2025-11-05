#Script to create Butterfly maps from points of collection

#load packages
library(ggplot2)
library(ggmap)
library(readxl)

api_secret <-"" #insert unique API code here
register_google(key = api_secret)

#Read excel
Fieldwork_datasheet <- read_excel(Fieldwork_datasheet_2024)
View(Fieldwork_datasheet)

#Butterfly map
mapbutterfly <- get_map (location=c(Longitude=(-79.38332), Latitude=(43.70885)), zoom =11, scale=1)
ggmap(mapbutterfly)

mapbutterfly1<- ggmap(mapbutterfly)+ geom_point(data=Fieldwork_datasheet,aes(x=Longitude,y=Latitude, alpha = 0.7),
                                                size = 4, shape = 21, colour="blue", fill="blue") +guides(fill=FALSE, alpha=FALSE, size=FALSE) +labs(y= "Latitude", x = "Longitude")
mapbutterfly1



