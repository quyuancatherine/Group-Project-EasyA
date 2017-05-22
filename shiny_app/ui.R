#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
  navbarPage("My Application",
             tabPanel("Component 1",
                      mainPanel("First Page")
             ),
             tabPanel("Component 2",
                      mainPanel("Second Page")),
             tabPanel("FAQ",
                      mainPanel(shiny::includeHTML("./static/faq.html")))
  )
)