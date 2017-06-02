#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

grade.data <- read.csv("full_data.csv")
grade.data <- grade.data %>% rename(  `A-` = `A.`, `B+` = `B.`, `B-` = `B..1`, `C+` = `C.`, `C-` = `C..1`, `D+` = `D.`, `D-` = `D..1`)
course.num <- unique(grade.data$Course_Number)
instructor.name <- unique(grade.data$Primary_Instructor)
term <- c("Autumn 2010", 
          "Autumn 2011", "Winter 2011", "Spring 2011", "Summer 2011", 
          "Autumn 2012", "Winter 2012", "Spring 2012", "Summer 2012",
          "Autumn 2013", "Winter 2013", "Spring 2013", "Summer 2013",
          "Autumn 2014", "Winter 2014", "Spring 2014", "Summer 2014",
          "Autumn 2015", "Winter 2015", "Spring 2015", "Summer 2015",
          "Winter 2016")
unique.course <- unique(grade.data$Course_Title)
unique.prof <- unique(grade.data$Primary_Instructor)
unique.dept <- unique(grade.data$department_name)


# Define UI for application that draws a histogram
shinyUI(
  navbarPage("University of Washington Grade Data",
             tabPanel("About",
                      mainPanel(shiny::includeHTML("./static/faq.html"))),
             tabPanel("Class Overview",
                      fluidPage(
                        sidebarLayout(
                          sidebarPanel(
                            
                            selectInput('course.number', label = 'Select Course', choices = course.num),
                            
                            uiOutput('profControl'),
                            
                            uiOutput('termControl')
                            
                            
                        ),
                        mainPanel(plotlyOutput("course_plot"))

                      ))),
             tabPanel("Department Table",
                      mainPanel(dataTableOutput("department_table"))
             ),
             tabPanel("Department Overview",
                      fluidPage(
                        titlePanel("Department GPA"),
                        
                        sidebarLayout(
                          sidebarPanel(
                            helpText("Create a bar plot by choosing your department of interest"),
                            
                            selectInput("department", 
                                        label = "choose a department to display",
                                        choices = unique.dept,
                                        selected = "Aeronautics & Astronautics"),
                            
                            helpText(p('By choosing the time range, the plot will only display the department you choose
                                       within that time range.')),
                            
                            selectInput("time", 
                                        label = "choose a time range to display",
                                        choices = c('2010', '2011', '2012', '2013', '2014', '2015'),
                                        selected = '2010')
                            ),
                          
                          mainPanel(plotlyOutput("chart"))
                        )
             )),
             tabPanel("Course Search", fluidPage(
               
               # Title for the Shiny Application
               titlePanel('Course Data'),
               
               mainPanel(
                 # Add a textInput that allows the user to enter the class for which the grade data is needed.
                 selectInput('course.var', label = 'Select Course', choices = unique.course),
                 
                 uiOutput('depControl'),
                 
                 # Displays the scatter plot.
                 plotlyOutput('plotly')
               )
             )),
             tabPanel("Professor Search", fluidPage(
               "Select a professor to see grading statistics.",
               selectInput('prof.var', label = 'Select Professor', choices = unique.prof),
               plotlyOutput('prof_graph'),
               dataTableOutput('prof_table')
               
             )),
             tabPanel("Department Extremes", fluidPage(
               titlePanel("View the Easiest and Hardest Professors in each Department"),
               selectInput('dept.var', label = 'Select Department', choices = unique.dept),
               plotlyOutput('extremes')
             ))
             
  )
)