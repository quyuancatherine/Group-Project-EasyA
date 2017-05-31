library(shiny)
library(plotly)

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
    sidebarPanel(
      #helpText("Create a bar plot by choosing your department of interest"),
      
      selectInput("course number", 
                  label = "Course Number",
                  choices = course.num,
                  selected = "A A 198 A"),
      
      #helpText(p('By choosing the time range, the plot will only display the department you choose
                 # within that time range.')),
      
      selectInput("instructor", 
                  label = "Instructor",
                  choices = instructor.name,
                  selected = 'KNOWLEN, CARL'),
      
      selectInput("term", 
                  label = "Term",
                  choices = term,
                  selected = 'Autumn 2010')
      
     
    # checkboxGroupInput("year", 
     #                    label = "Year",
     #                    choices = c("2010", "2011", "2012", "2013", "2014", "2015", "2016"), 
    #                     selected = c("2010", "2011", "2012", "2013", "2014", "2015", "2016")),
      
    #  checkboxGroupInput("term", 
     #                    label = "Term",
     #                    choices = c("Autumn", "Winter", "Spring", "Summer"), 
     #                    selected = c("Autumn", "Winter", "Spring", "Summer"))
      ),
    
    mainPanel(plotlyOutput("histogram"))
  )
))