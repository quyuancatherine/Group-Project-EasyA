# server.R

# From: http://shiny.rstudio.com/articles/basics.html
library(shiny)
library(plotly)
library(dplyr)

df <- read.csv("~/Documents/INFO 201/Group-Project-EasyA/Analyze_department_GPA/full_data.csv", stringsAsFactors = F)


# Define server logic required to draw a scatterplot.
shinyServer(function(input, output) {
  
  a <- reactive({
    x <- filter(df, Course_Title == input$course.var)
    y <- unique(x$department_name)
    return(y)
  })
  
  output$depControl <- renderUI({
    selectInput('dep.var', 'Select Department', choices = a())
  })
  
  b <- reactive({
    x <- filter(df, Course_Title == input$course.var, department_name == input$dep.var)
    return(x)
  })
  
  output$plotly <- renderPlotly({
    return(plot_ly(type = 'scatter', data = b(), x = ~Academic_Year, y = ~Average_GPA, sizes = ~Average_GPA, color = ~Course_Number, text = ~paste('Section: ', Course_Number)))
  })
  
  
  
})
