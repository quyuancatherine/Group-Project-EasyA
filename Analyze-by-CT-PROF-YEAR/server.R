library(shiny)
source('./scripts/script.R')
grade.data <- read.csv("full_data.csv")
library(plotly)

shinyServer(
  function(input, output) {
    output$histogram <- renderPlotly({
      return(HistChart(grade.data, input$`course number`, input$instructor, input$term))
    })
  }
)