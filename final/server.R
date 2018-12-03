#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)





server <- function(input,output){
  df <- data.table::fread("wa-wildfires.csv", stringsAsFactors = F)
  
  df$latitude <- as.numeric(df$latitude)
  df$longitude <- as.numeric(df$longitude)
  saveRDS(df, "./data.rds")
  sample_data <- df[c(1:1000),]
  saveRDS(sample_data, "./sample_data.rds")
  data <- reactive({
    x <- df
  })
  output$mymap <- renderLeaflet({
    df <- data()
    
    m <- leaflet(data = df) %>%
      addTiles() %>%
      addMarkers(longitude = ~longitude,
                 latitude = ~latitude,
                 popup = paste("Offense", df$longitude, "<br>",
                               "Year:", df$latitude))
    m
  })
  

}