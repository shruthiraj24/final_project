#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
library(shiny)
library(leaflet)
library(dbplyr)
# 

#df <- data.table::fread("ca-wildfires.csv", stringsAsFactors = F)
#fire_info <- select(df,longitude,latitude,fire_year)
# Define UI for application that draws a histogram
ui <- fluidPage(
  theme="style.css",
  tags$p(class="important", "this is a random text"),
  titlePanel("fire Data"),
  
   sidebarLayout(
    
    sidebarPanel(
      uiOutput("yearSelector")
     
    )
   ) 
)
    
    mainPanel(
      leafletOutput("caliFireData"),
      uiOutput("imageGrid"),
      tags$script(HTML(
        "$(document).on('click', '.clickimg', function() {",
        "  Shiny.onInputChange('clickimg', $(this).data('value'));",
        "};"
      )
    )
  )





