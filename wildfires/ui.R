#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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
 
 ca_wildfires <- data.table::fread("ca-wildfires.csv", stringsAsFactors = F)
 
 ui <- fluidPage(
   titlePanel("California Under Fire"),
   theme="style.css",
   tags$p(class="important", "This project explores about data of wildfires 
          occurred in California from 1995, 2005, and 2015. The 
          spread of wildfires in state of California has been a trending topic 
          in the recent time. The data that we've used for this project originially 
          comes from the", tags$a(href="https://www.fs.usda.gov/rds/archive/Product/RDS-2013-0009.4/", 
          "United States Department of Agriculture Forest Service."), "The dataset
          contains global unique identifier"), 
   
   sidebarLayout(
     sidebarPanel(
       
       uiOutput("yearSelector"), 
       
       radioButtons("causes",
                    "Select a year to display the wildfire causes of that year",
                    choices = c("1995", "2005", "2015"))
     ),
     
     mainPanel(
       leafletOutput("caliFireData"),
       plotOutput("Plot")
     )
   )
)