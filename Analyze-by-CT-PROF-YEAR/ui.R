library(shiny)
library(plotly)

# choices that used in wedgits 
grade.data <- read.csv("full_data.csv")
course.num <- unique(grade.data$Course_Number)
instructor.name <- unique(grade.data$Primary_Instructor)
term <- c("Autumn 2010", 
          "Autumn 2011", "Winter 2011", "Spring 2011", "Summer 2011", 
          "Autumn 2012", "Winter 2012", "Spring 2012", "Summer 2012",
          "Autumn 2013", "Winter 2013", "Spring 2013", "Summer 2013",
          "Autumn 2014", "Winter 2014", "Spring 2014", "Summer 2014",
          "Autumn 2015", "Winter 2015", "Spring 2015", "Summer 2015",
          "Winter 2016")

shinyUI(fluidPage(
  titlePanel("Search Grades"),
  
  sidebarLayout(
    # Creating control panel on the side bar
    sidebarPanel(
      
      # select input for course number 
      selectInput("course number", 
                  label = "Course Number",
                  choices = course.num,
                  selected = "A A 210 A"),
      
      # select input for instrucor
      selectInput("instructor", 
                  label = "Instructor",
                  choices = instructor.name,
                  selected = 'KNOWLEN, CARL'),
      
      # select input for academic term
      selectInput("term", 
                  label = "Term",
                  choices = term,
                  selected = 'Autumn 2010')
      ),
    # Creating display panel
    mainPanel(plotlyOutput("histogram"))
  )
))