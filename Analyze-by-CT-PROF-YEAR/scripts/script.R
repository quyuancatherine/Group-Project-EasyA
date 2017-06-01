library(plotly)
library(dplyr)
library(tibble)
library(tidyr)

# Creating a bar chart
HistChart <- function(data, select.course.num, select.instructor.name, select.term){
  filter <- filter(data, Course_Number == select.course.num)
  filter <- filter %>% 
            filter(Primary_Instructor == select.instructor.name) %>% 
            filter(grepl(select.term, Term))
  
  filter <- select_(filter, "A", "A.", "B.", "B", "B..1", "C.", "C", "C..1", "D.", "D", "D..1")
  filter <- stack(filter)
 
  p <- plot_ly(data = filter, x = ~ind, y = ~values,
               type = 'bar') %>% 
       layout(title = paste(select.course.num, select.term, "(", select.instructor.name, ")"), 
              xaxis = list(title = "Grade Level"),
              yaxis = list(title = "Number of Students"))
  
  return(p)
}