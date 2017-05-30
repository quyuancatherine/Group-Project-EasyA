library(shiny)
library(plotly)

lala <- read.csv("full_data.csv")
department.name <- unique(lala$department_name)

shinyUI(fluidPage(
  titlePanel("Department GPA"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create a bar plot by choosing your department of interest"),
      
      selectInput("department", 
                  label = "choose a department to display",
                  choices = department.name,
                  selected = "Aeronautics & Astronautics"),
      
      helpText(p('By choosing the time range, the plot will only display the department of
                 your interest within that time range.')),
      
      selectInput("time", 
                  label = "choose a time range to display",
                  choices = c('2010', '2011', '2012', '2013', '2014', '2015'),
                  selected = '2010')
    ),
    
    mainPanel(plotlyOutput("chart"))
    )
  ))