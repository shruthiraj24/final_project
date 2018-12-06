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


ui <- fluidPage(
  #Title of shinyapp
  navbarPage("CA Wildfires", 
  tabPanel("Home",
    titlePanel("Introduction"),
    
    #Introduction on CA Wildfires home page; explains what the project is about,
    #where the dataset comes from, and for which parts of dataset we're analyzing
    #on
   p("This project explores about data of wildfires occurred in California from 
      1995, 2005, and 2015. The spread of wildfires in state of California has 
      been a trending topic in the recent time. The data that we've used for 
      this project originially comes from the", 
      a(href="https://www.fs.usda.gov/rds/archive/Product/RDS-2013-0009.4/", 
     "United States Department of Agriculture Forest Service."), "The 
      dataset mainly contains year of wildfire, date of year when the fire 
      was discovered and stopped, description for cause of the fire, fire
      size, longitude and latitude of the fire's location. To learn more details
      about the dataset, please visit the", 
     a(href="https://www.fs.usda.gov/rds/archive/products/RDS-2013-0009.4/_metadata_RDS-2013-0009.4.html", 
     "Spatial wildfire occurrence data for 
      the United States, 1992-2015"), "webpage. In this project, 
      we analyzed the location, duration, and cause of the wildfires."),
    
   #An image about California's wildfires happened recently
   img(src="https://www.daily49er.com/wp-content/uploads/2018/11/WireAP_6d36a64e200e4cb092d0c1a6254f2ec9_12x5_992-900x375.jpg"
   )),
  
  #Display the leaflet map on Leaflet page where it shows location points of 
  #wildfires in California in terms of county, as well as the fire size for 
  #wildfires for years of 1995, 2005, 2015
  tabPanel("Leaflet",
   titlePanel("California Under Fire"),
    p("This is a leaflet that focuses on the exact locations of the wildfires. 
      When users click the location, they are able to 
      know the fire size and the county in which it took place."),
   
   sidebarLayout(
     sidebarPanel(
        radioButtons("years",
                    "Select a year to display the wildfires of that year",
                    choices = c("1995", "2005", "2015"))

     ),
  
     mainPanel(
       leafletOutput("caliFireData"),
       p("This is a random sample of 100 wildfires for the chosen year.")
        )
      )
  ),  
  
  #Display a bar graph on Causes page where it shows the causes of wildfires vs.
  #the occurance of each cause in California for years of 1995, 2005, 2015 
  tabPanel("Causes",
   titlePanel("Causes of Wildfires"),
   p("The bar chart below displays the 13 causes of wildfires and the frequency 
     of each given a year. These causes are ordered in descending order to 
     display the most common cause at the top of the graph to the least common 
    cause at the bottom."
     ),
   
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

  #Display a map on Size and Duration page where it shows the duration of 
  #wildfires presenting by the color scale and size of wildfires presenting by 
  #the size of dots for years of 1995, 2005, and 2015
  tabPanel("Size and Duration",
    titlePanel("Size and Duration of Fires"),
    p("This map focuses on the duration and size of the fire. 
      Users are able to know about the size and how long it affects everyday 
      Californians."
      ),
    
    sidebarLayout(
      sidebarPanel(
        radioButtons("sizes",
                      "Select a year to display the wildfire sizes and durations
                      of that year",
                      choices = c("1995", "2005", "2015"))
      ),
    
    mainPanel(    
    plotOutput("map")
    )
  )
  )

))
