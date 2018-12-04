#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
# 
# df <- data.table::fread("wa-wildfires.csv", stringsAsFactors = F)
# 
# df$latitude <- as.numeric(df$latitude)
# df$longitude <- as.numeric(df$longitude)
# saveRDS(df, "./data.rds")
# 
# 
# sample_data <- df[c(1:1000),]
# saveRDS(sample_data, "./sample_data.rds")

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme="style.css",
  tags$p(class="important", "this is a random text"),
  mainPanel(
  leafletOutput("gun_violence")
  )
)


