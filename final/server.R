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
  df <- data.table::fread("ca-wildfires.csv", stringsAsFactors = F)
  
  df$latitude <- as.numeric(df$longitude)
  df$longitude <- as.numeric(df$latitude)
  saveRDS(df, "./data.rds")
  sample_data <- df[c(1:1000),]
  saveRDS(sample_data, "./sample_data.rds")
  
  data <- reactive({
    x <- df
  })
  output$gun_violence <- renderLeaflet({
    df <- data()
    
    m <- leaflet(data = df) %>%
      addTiles() %>%
      addMarkers(
                 popup = paste("Location", df$longitude, "<br>",
                               "Year:", df$latitude))
    return(m)
  })
  
  
}
      