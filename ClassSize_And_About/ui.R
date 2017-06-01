#FinalINFO201 ui
install.packages("shinydashboard")
library(shiny)
library(shinydashboard)
library(plotly)
grade.data <- read.csv("./full_data.csv")
department.name <- unique(grade.data$department_name)

shinyUI(
  dashboardPage(
    dashboardHeader(title = "Check the UW grade"),
                
    dashboardSidebar(
      sidebarMenu(
        menuItem("About", tabName = "about", icon = icon("list-alt")),
        menuItem("Department", tabName = "department", icon = icon("th")),
        menuItem("Class Size", tabName = "classsize", icon = icon("fa fa-camera-retro"))
        # menuItem()
        # menuItem()
      )#end sidebarMenu
    ),#end dashboardSidebar
    
    dashboardBody(
      tabItems(
        # #First tab content
        tabItem(tabName = "about", shiny::includeHTML("./FAQ.html")),
        # Second tab content
        tabItem(tabName = "department",h2("Department GPA")),
          
        #Third tab content
        tabItem(tabName = "classsize",h2("Class Size"),
          fluidRow(
            box(
              "Choose a range of class size that you're interest in",
              sliderInput("classinput", "Class Size:", min = 0, max = 750, value = c(200,500))
            ),#end Box1
            box(
              "This table is the average GPA and average students receive each letter grades",
              tableOutput("classGPA")
            )#end Box2
          )#end fluidRow
        )#end thrid tab content
      )#end tabItems
    ),#end dashboardBody
    skin = "purple"
  )#end dashboardPage
)#end shinyUi
