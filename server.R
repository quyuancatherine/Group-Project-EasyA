
library(shiny)
library(plotly)
library(stringr)
library(dplyr)
library(plotly)
shinyServer(function(input, output) {
  # Load Data
  grade.data <- read.csv("full_data.csv", stringsAsFactors = FALSE)
  # Department Table
  by_department <- grade.data %>% group_by(department) %>%
    summarize(classes = n(), students = sum(Student_Count), mean_students = students/classes, mean_gpa = mean(Average_GPA)) %>% arrange(department)
  colnames(by_department) <- c("Department Code", "Total Classes", "Total Students", "Mean Enrollment", "Mean GPA")
  output$department_table <- renderDataTable(by_department, options = list(pageLength = 10, autowidth = TRUE))
  
  # Other Charts
  source('./scripts/script.R')
  output$histogram <- renderPlotly({
    return(HistChart(grade.data, input$`course number`, input$instructor, input$term))
  })
  
  source('./scripts/plot.R')
  output$chart <- renderPlotly({
    return(PlotChart(grade.data, input$department, input$time))
  })
  
  
  #Reactive charts
  a <- reactive({
    x <- filter(grade.data, Course_Title == input$course.var)
    y <- unique(x$department_name)
    return(y)
  })
  
  output$depControl <- renderUI({
    selectInput('dep.var', 'Select Department', choices = a())
  })
  
  b <- reactive({
    x <- filter(grade.data, Course_Title == input$course.var, department_name == input$dep.var)
    return(x)
  })
  
  output$plotly <- renderPlotly({
    plot_ly(type = 'scatter', data = b(), x = ~Academic_Year, y = ~Average_GPA, sizes = ~Average_GPA, color = ~Course_Number, text = ~paste('Section: ', Course_Number)) %>% layout(margin = list(b = 160))
  })
  
  output$prof_table <- reactive({
    by_professor <- grade.data %>% filter(Primary_Instructor == input$prof.var) %>% group_by(department_name, Course_Title) %>% summarize(terms = n(), avg.grade = mean(Average_GPA), mean_students = mean(Student_Count))
    renderDataTable(by_professor, options = list(pageLength = 10, autowidth = TRUE))
  })
  output$prof_graph <- renderPlotly({
    # Find average GPA for each class input professor has taught
    by_professor <- grade.data %>% filter(Primary_Instructor == input$prof.var) %>% group_by(department_name, Course_Title) %>% summarize(avg.grade = mean(Average_GPA))
    
    plot_ly(by_professor, x = ~Course_Title, y = ~avg.grade, type = 'bar') %>% layout(margin = list(b = 200), xaxis = list(title = "Course Title"), yaxis = list(title = "Average GPA"))
  })
  
  # Create extremes table
  output$extremes <- renderPlotly({
    # Filter for current department and sort professors by average gpa
    cur_department <- grade.data %>% filter(department_name == input$dept.var) %>% group_by(Primary_Instructor) %>% summarize(classes = n(), avg.grade = mean(Average_GPA))
    
    # Find the top 5, bottom 5, and average
    top <- cur_department %>% top_n(5)
    bottom <- cur_department %>% top_n(-5)
    avg <- grade.data %>% filter(department_name == input$dept.var) %>% summarize(classes = n(), avg.grade = mean(Average_GPA)) %>% mutate(Primary_Instructor = "Average")
    avg[1, 'classes'] = 0
    
    # Put them together and plot
    tot <- bind_rows(top, avg, bottom) %>% arrange(-avg.grade)
    plot_ly(tot, x = ~Primary_Instructor, y = ~avg.grade, type = 'bar') %>% layout(margin = list(b = 160), xaxis = list(title = "Course Title", categoryorder = "array", categoryarray = tot$Primary_Instructor), yaxis = list(title = "Average GPA/Number of Classes taught"))
  })
  
})
