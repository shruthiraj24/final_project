library(ggplot2)
library(dplyr)
library(magrittr)
library(stringr)
library(maps)
library(mapdata)

us_fires_1 <- read.csv("data/us_fires/us_fires_1.csv")
us_fires_2 <- read.csv("data/us_fires/us_fires_2.csv")
us_fires_3 <- read.csv("data/us_fires/us_fires_3.csv")
us_fires_4 <- read.csv("data/us_fires/us_fires_4.csv")
us_fires_5 <- read.csv("data/us_fires/us_fires_5.csv")
us_fires_6 <- read.csv("data/us_fires/us_fires_6.csv")
us_fires_7 <- read.csv("data/us_fires/us_fires_7.csv")


wa_fires_1 <- us_fires_1 %>% filter(state == "WA")
wa_fires_2 <- us_fires_2 %>% filter(state == "WA")
wa_fires_3 <- us_fires_3 %>% filter(state == "WA")
wa_fires_4 <- us_fires_4 %>% filter(state == "WA")
wa_fires_5 <- us_fires_5 %>% filter(state == "WA")
wa_fires_6 <- us_fires_6 %>% filter(state == "WA")
wa_fires_7 <- us_fires_7 %>% filter(state == "WA")


combined_wa <- rbind(wa_fires_1, wa_fires_2, wa_fires_3, wa_fires_4,
                         wa_fires_5, wa_fires_6, wa_fires_7)

wa_wildfires_2005 <- combined_wa %>% filter(fire_year == 2005)
wa_wildfires_2010 <- combined_wa %>% filter(fire_year == 2010)
wa_wildfires_2015 <- combined_wa %>% filter(fire_year == 2015)

wa_fire_data <- rbind(wa_wildfires_2005, wa_wildfires_2010, wa_wildfires_2015)

write.csv(wa_fire_data, file = "wa-wildfires.csv")

rm(us_fires_1)
rm(us_fires_2)
rm(us_fires_3)
rm(us_fires_4)
rm(us_fires_5)
rm(us_fires_6)
rm(us_fires_7)
rm(wa_fires_1)
rm(wa_fires_2)
rm(wa_fires_3)
rm(wa_fires_4)
rm(wa_fires_5)
rm(wa_fires_6)
rm(wa_fires_7)
rm(combined_wa)
rm(wa_wildfires_2005)
rm(wa_wildfires_2010)
rm(wa_wildfires_2015)
rm(wa_fire_data)

#################################################

wa_wildfires <- read.csv("wa-wildfires.csv", stringsAsFactors = FALSE)
View(wa_wildfires)

washington <- map_data("state", region = "Washington")


wa_wildfires %>% 
  filter(fire_year == 2010) %>% 
    ggplot() +
      geom_polygon(data = washington, aes(x=long, y=lat, group=group)) +
      geom_point(mapping = aes(x=longitude, y=latitude, size = fire_size_class), color = "red") +
      labs(
        x = "Longitude",
        y = "Latitude",
        title = "Wildfires in 2010",
        size = "Class"
        )+
    coord_quickmap()

wa_wildfires %>% 
  filter(fire_year == 2010) %>% 
  ggplot() +
    geom_polygon(data = washington, aes(x=long, y=lat, group=group)) +
    geom_tile(mapping = aes(x=longitude, y=latitude, fill=fire_size)) +
    coord_quickmap()


chooseYear(2010)


ggplot(wa_wildfires) +
  geom_bar(mapping = aes(x = fire_year, fill=stat_cause_descr), position = "dodge")

ggplot(wa_wildfires) +
  geom_bar(mapping = aes(x = fire_year, fill=stat_cause_descr), position = "dodge")

ggplot(wa_wildfires) +
  geom_bar(mapping = aes(x=fire_year))

wa_wildfires$duration <- wa_wildfires$cont_doy - wa_wildfires$discovery_doy

ggplot(wa_wildfires) +
  geom_point(mapping = aes(x=duration, y = fire_size)) +
  geom_smooth(mapping = aes(x=duration, y = fire_size))

