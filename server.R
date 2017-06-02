
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
    x <- filter(grade.data, department_name == input$dep.var)
    y <- x$Course_Title
    return(y)
  })
  
  output$selectCourse <- renderUI({
    selectInput('course.var', 'Select Course', choices = a())
  })
  
  b <- reactive({
    x <- filter(grade.data, Course_Title == input$course.var, department_name == input$dep.var)
    return(x)
  })
  
  output$plotly <- renderPlotly({
    plot_ly(type = 'scatter', data = b(), x = ~Academic_Year, y = ~Average_GPA, sizes = ~Average_GPA, color = ~Course_Number, text = ~paste('Section: ', Course_Number, '<br>', Primary_Instructor)) %>% layout(margin = list(b = 160))
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
  
  source('./scripts/size.R')
  
  ################## 
  #this will take in 2 class sizes as the user interest, will return the average gpa and letter grade
  output$size1.gpa <- renderTable({
    size1 <- input$classinput1
    size1.data <- data.frame(#start data frame
      Grade = c("GPA",
                "A 90-100%",
                "B 80-89%",
                "C 70-79%",
                "D 60-69%",
                "F 0-59%",
                "W Withdraw"),
      Average = c(paste(ClasssizeGPA(size1)),
      paste(ClasssizeLetterA(size1),"student"),
      paste(ClasssizeLetterB(size1),"student"),
      paste(ClasssizeLetterC(size1),"student"),
      paste(ClasssizeLetterD(size1),"student"),
      paste(ClasssizeLetterF(size1),"student"),
      paste(ClasssizeLetterW(size1),"student"))
    )#end data frame
  }) #end size1
    
  output$size2.gpa <- renderTable({
    size2 <- input$classinput2
    size2.data <- data.frame(#start data frame
      Grade = c("GPA",
                "A 90-100%",
                "B 80-89%",
                "C 70-79%",
                "D 60-69%",
                "F 0-59%",
                "W Withdraw"),
      Average = c(paste(ClasssizeGPA(size2)),
                  paste(ClasssizeLetterA(size2),"student"),
                  paste(ClasssizeLetterB(size2),"student"),
                  paste(ClasssizeLetterC(size2),"student"),
                  paste(ClasssizeLetterD(size2),"student"),
                  paste(ClasssizeLetterF(size2),"student"),
                  paste(ClasssizeLetterW(size2),"student"))
    )#end data frame
  }) #end size2
    #############
   
  
})
