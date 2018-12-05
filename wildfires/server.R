#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table)
library(leaflet)
library(dplyr)
library(magrittr)
library(maps)
library(ggplot2)
library(R.utils)
library(rsconnect)
library(mapdata)

shinyServer(function(input, output) {
  data <- reactive({
  ca_wildfires <- data.table::fread("ca-wildfires.csv", 
                                    stringsAsFactors = FALSE)
  
  ca_wildfires$latitude <- as.numeric(ca_wildfires$latitude)
  ca_wildfires$longitude <- as.numeric(ca_wildfires$longitude)
  ca_wildfires[c(1:100),]
  })
})

output$caliFireData <- renderLeaflet({
  ca_wildfires <- data()
  
  wildfires_map <- leaflet(data = ca_wildfires) %>%
    addTiles() %>%
    addMarkers(
      popup = paste("Offense", ca_wildfires$longitude, "<br>",
                    "Year:", ca_wildfires$latitude))
  return(wildfires_map)
})

output$yearSelector <- renderUI({
  ca_wildfires <- data()
  selectInput('fire_year',
              label = 'Year',
              choices = unique(ca_wildfires$fire_year))
})
  
  output$Plot <- renderPlot({
    causesYearSelect <- function(choose_year){
      ca_wildfires %>%
        filter(fire_year == as.numeric(choose_year)) %>% 
        group_by(stat_cause_descr) %>% 
        summarize(
          total = n()
        ) %>% 
        ggplot(aes(x=reorder(stat_cause_descr, total), y=total)) +
        geom_bar(stat = "identity") +
        labs(
          x = "Cause of Wildfire",
          y = "Count",
          title = paste("Wildfires in", as.character(choose_year))
        ) +
        coord_flip()
    }
    causesYearSelect(input$causes)
    
  })

