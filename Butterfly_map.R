#map shows 1 circle per park where colias were collected

#load packages
library(ggplot2)
library(ggmap)
library(ggspatial)
library(sf)
api_secret <-"" #insert unique API code here
register_google(key = api_secret)

#data entry for parks
Fieldwork_datasheet <- data.frame(
  park_number = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
  Latitude = c(43.771289, 43.654407, 43.586443, 43.7505449, 43.7786512, 43.6942802, 
               43.7797746, 43.6641906, 43.6595815, 43.7242016, 43.7422736, 43.7434777),
  Longitude = c(-79.506077, -79.589672, -79.5447338, -79.5724347, -79.1946797, -79.5134948, 
                -79.1876933, -79.5091923, -79.30806, -79.3573391, -79.4783759, -79.2705279)
)

# Get Map
map_base <- get_map(location = c(lon = -79.38, lat = 43.70), zoom = 11, maptype = "terrain")

mapbutterfly1 <- ggmap(map_base) + 
  coord_sf(crs = st_crs(4326)) + 
  
  geom_point(data = Fieldwork_datasheet, aes(x = Longitude, y = Latitude), 
             size = 5, shape = 21, fill = "blue", color = "white") +
  
  geom_text(data = Fieldwork_datasheet, aes(x = Longitude, y = Latitude, label = park_number), 
            hjust = 0.5, vjust = -1.0, size = 3.5, fontface = "bold") +
  
  # Scale bar and North arrow
  annotation_scale(location = "br", width_hint = 0.4) +
  annotation_north_arrow(location = "br", which_north = "true", 
                         pad_x = unit(0.2, "in"), pad_y = unit(0.4, "in"),
                         style = north_arrow_fancy_orienteering(
                           fill = c("black", "white"),
                           line_col = "grey20"
                         )) +
  labs(y = "Latitude", x = "Longitude") +
  theme_minimal()
print(mapbutterfly1)
