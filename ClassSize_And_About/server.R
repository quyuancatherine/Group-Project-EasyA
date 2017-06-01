#FinalINFO201 server
library(shiny)
library(plotly)
library(shinydashboard)
grade.data <- read.csv("./full_data.csv")
source("./scripts/plot.R")
source("./scripts/testonly.R")

shinyServer(
  function(input, output){
  #No need for first tab("About")
    
  #Start second tab("Department") content
  
  ########### Start third tab("Class Size") content
  class.size.average <- reactive({#start class.size.average
    data.frame(#start data frame
      Grade = c("GPA",
                "A 90-100%",
                "B 80-89%",
                "C 70-79%",
                "D 60-69%",
                "F 0-59%",
                "W Withdraw"),
      Average = as.character(c(paste(ClasssizeGPA(input$classinput[1],input$classinput[2])),
                paste(ClasssizeLetterA(input$classinput[1],input$classinput[2]),"students"),
                paste(ClasssizeLetterB(input$classinput[1],input$classinput[2]),"students"),
                paste(ClasssizeLetterC(input$classinput[1],input$classinput[2]),"students"),
                paste(ClasssizeLetterD(input$classinput[1],input$classinput[2]),"students"),
                paste(ClasssizeLetterF(input$classinput[1],input$classinput[2]),"students"),
                paste(ClasssizeLetterW(input$classinput[1],input$classinput[2]),"students")))
    )#end data frame
  })#end class.size.average
  
  output$classGPA <- renderTable({
    class.size.average()
  })
  ###############End third tab content

})#end shinyServer
 
  
