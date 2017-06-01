library(shiny)
source('./scripts/plot.R')
lala <- read.csv("full_data.csv")
library(plotly)

shinyServer(
  function(input, output) {
    output$chart <- renderPlotly({
      return(PlotChart(lala, input$department, input$time))
    })
  }
)