#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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

ca_wildfires <- read.csv("all-cal-wildfires.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Wildfires in California"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      radioButtons("causes",
                   "Select a year to display the wildfire causes of that year",
                   choices = c("1995", "2005", "2015"))
                   
      ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Plot")
      
    )
  ))
)

