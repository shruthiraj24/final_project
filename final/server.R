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
  data <- reactive({
    df <- data.table::fread("ca-wildfires.csv", stringsAsFactors = F)
    df$latitude <- as.numeric(df$latitude)
    df$longitude <- as.numeric(df$longitude)
    df[c(1:100),]
    
  })
  
  output$imageGrid <- renderUI({
    fluidRow(
      lapply(images, function(img) {
        column(3, 
               tags$img(src=paste0("images/", img), class="clickimg", data-value=img)
        )
      })
    )
  })
  
  
  output$caliFireData <- renderLeaflet({
    df <- data()
    
    m <- leaflet(data = df) %>%
      addTiles() %>%
      addMarkers(
        popup = paste("Offense", df$longitude, "<br>",
                      "Year:", df$latitude))
    return(m)
  })
  output$yearSelector <- renderUI({
    df <- data()
    selectInput('fire_year',
                label = 'Year',
                choices = unique(df$fire_year))
  })

    }   
  

  


 