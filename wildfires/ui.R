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
 
## ca_wildfires <- data.table::fread("all-cal-wildfires.csv", stringsAsFactors = F)
 
ui <- fluidPage(
  navbarPage("CA Wildfires", 
  tabPanel("Home",
    titlePanel("Introduction"),
    theme="style.css",
    tags$p(class="important", "This project explores about data of wildfires 
          occurred in California from 1995, 2005, and 2015. The 
           spread of wildfires in state of California has been a trending topic 
           in the recent time. The data that we've used for this project originially 
           comes from the", tags$a(href="https://www.fs.usda.gov/rds/archive/Product/RDS-2013-0009.4/", 
                                   "United States Department of Agriculture Forest Service."), "The 
           dataset mainly contains year of wildfire, date of year when the fire 
           was discovered and stopped, description for cause of the fire, fire
           size, longitude and latitude of the fire's location. In this project, 
           we analyzed the location, duration, and cause of the wildfires."),
    tags$img(src="https://www.daily49er.com/wp-content/uploads/2018/11/WireAP_6d36a64e200e4cb092d0c1a6254f2ec9_12x5_992-900x375.jpg")
    
    ),
  tabPanel("Leaflet",
   titlePanel("California Under Fire"),
   theme="style.css",
    p(class="important", "This is a leaflet that focuses on the exact locations of the wildfires. When users click the location, they are able to 
      know the fire size and the county in which it took place."),
   
   sidebarLayout(
     sidebarPanel(
       radioButtons("years",
                    "Select a year to display the wildfires of that year",
                    choices = c("1995", "2005", "2015"))

     ),
  
     mainPanel(
       leafletOutput("caliFireData"),
       p(class="important", "This is a random sample of 100 wildfires for the chosen year.")
   ))),  
     tabPanel("Causes",
       titlePanel("Causes of Wildfires"),
       theme="style.css",
       p(class="important", "The bar chart below displays the 13 causes of wildfires and the frequency of each given a year.
             These causes are ordered in descending order to display the most common cause at the top of the graph to the least common cause at the bottom.
             "),
       sidebarLayout(
         sidebarPanel(
           radioButtons("causes",
                        "Select a year to display the wildfire causes of that year",
                        choices = c("1995", "2005", "2015"))
         ),
      mainPanel(    
       plotOutput("Plot")
     )
   )
),
tabPanel("Size and Duration",
         titlePanel("Size and Duration of Fires"),
         theme="style.css",
         p(class="important", "This map focuses on the duration and size of the fire. Users are able to know about the size and how long it affects everyday Californians.
           "),
         sidebarLayout(
           sidebarPanel(
             radioButtons("sizes",
                          "Select a year to display the wildfire sizes and durations of that year",
                          choices = c("1995", "2005", "2015"))
           ),
           mainPanel(    
             plotOutput("map")
           )
         )
         )

))
