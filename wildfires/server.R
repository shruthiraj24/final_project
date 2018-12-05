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
 
#Running the shiny input and output & calling in our main dataset
shinyServer(function(input, output) {
  data <- reactive({
  ca_wildfires <- data.table::fread("all-cal-wildfires.csv", 
                                    stringsAsFactors = FALSE)
  })

#starting our leaflet plot. In this section, we add markers,tiles and 
  # create the pops to let viewers focus on. 
output$caliFireData <- renderLeaflet({
  d <- data()
  print(unique(d$years))
  
  ca_wildfires <- d %>% 
    dplyr::filter(fire_year == input$years) %>% 
    dplyr::sample_n(100)
  leaflet(data = ca_wildfires) %>%
    addTiles() %>%
    addMarkers(
      popup = paste("County", ca_wildfires$county, "<br>",
                    "Size:", ca_wildfires$fire_size, "acres"))
  
  
})

##output$yearSelector <- renderUI({
##  ca_wildfires <- data()
 ## selectInput('fire_year',
            ##  label = 'Year',
              ##choices = unique(ca_wildfires$fire_year))
##})

##generate bar graph with causes  
  output$Plot <- renderPlot({
    ca_wildfires <- data.table::fread("all-cal-wildfires.csv", 
                                      stringsAsFactors = FALSE)
    causesYearSelect <- function(choose_year){
      ca_wildfires %>%
        filter(fire_year == as.numeric(choose_year)) %>% 
        group_by(stat_cause_descr) %>% 
        summarize(
          total = n()
        ) %>% 
        ggplot(aes(x=reorder(stat_cause_descr, total), y=total, fill = "orange")) +
        geom_bar(stat = "identity") +
        labs(
          x = "Cause of Wildfire",
          y = "Count",
          title = paste("Wildfires in", as.character(choose_year))) +
        guides(fill=FALSE)+
        coord_flip()
    }
    causesYearSelect(input$causes)
    
  })

  ## generate map with size and duration of fires  
  output$map <- renderPlot({
    ca_wildfires <- data.table::fread("all-cal-wildfires.csv", 
                                      stringsAsFactors = FALSE)
    california <- map_data("state", region = "California")
    sizesYear <- function(select_year){
      ca_wildfires %>% 
        filter(fire_year == as.numeric(select_year)) %>% 
        mutate(fire_length = cont_doy - discovery_doy) %>% 
    ggplot()+
      geom_polygon(data = california, aes(x=long, y=lat, group=group))+
      geom_point(mapping = aes(x= longitude, y= latitude, size= fire_size, color=fire_length) )+
      scale_color_gradient(low = "royalblue", high = "red3") +
      scale_size(range =c(0, 5))+
      scale_size_area(max_size = 5 )+
      labs(
        x = "Longitude",
        y = "Latitude",
        title = "Duration of Fire and Size", size = "Fire Size", 
        color= "Duration of Fire") +
      coord_quickmap()
    }
    sizesYear(input$sizes)
  })
  
})
