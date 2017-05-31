library(plotly)
library(dplyr)

HistChart <- function(data, select.course.num, select.instructor.name, select.term){
  filter <- filter(data, Course_Number == select.course.num)
  filter <- filter %>% 
            filter(Primary_Instructor == select.instructor.name) %>% 
            filter(grepl(select.term, Term))
  
  p <- plot_ly(data = filter, x = ~Course_Number, y = ~Average_GPA,
               type = 'histogram')
  
  return(p)
}
#data <- read.csv("full_data.csv")
#filter <- filter(data, Course_Number == "A A 210 A")
#filter <- filter %>% 
#  filter(Primary_Instructor == "KNOWLEN, CARL") %>% 
#  filter(grepl("Autumn 2010", Term)) %>% 
 # select()
