#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(magrittr)
library(maps)
library(ggplot2)
library(R.utils)
library(rsconnect)
library(mapdata)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  ca_wildfires <- read.csv("all-cal-wildfires.csv", stringsAsFactors = FALSE)
  
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
})

