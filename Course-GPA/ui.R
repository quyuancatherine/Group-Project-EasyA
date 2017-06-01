# ui.R

# From http://shiny.rstudio.com/articles/basics.html
library(shiny)
library(plotly)

data.frame <- read.csv("~/Documents/INFO 201/Group-Project-EasyA/Analyze_department_GPA/full_data.csv", stringsAsFactors = F)
unique.course <- unique(data.frame$Course_Title)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Title for the Shiny Application
  titlePanel('Course Data'),
  
  mainPanel(
    # Add a textInput that allows the user to enter the class for which the grade data is needed.
    selectInput('course.var', label = 'Select Course', choices = unique.course),
    
    uiOutput('depControl'),
    
    # Displays the scatter plot.
    plotlyOutput('plotly')
  )
))
