library(plotly)
library(dplyr)

PlotChart <- function(data, interest, select.time){
  filter.department <- filter(data, department_name == interest)
  filter.department$Academic_Year <- as.character(filter.department$Academic_Year)
  filter.department$Academic_Year <- substr(filter.department$Academic_Year, 1, 4)
  filter.department <- filter(filter.department, Academic_Year == select.time)
  filter.department <- mutate(filter.department, 
                              added = paste(filter.department$Course_Number, ':', filter.department$Course_Title))
  
  p <- plot_ly(data = filter.department, x = ~added, y = ~Average_GPA,
               type = 'scatter', mode = 'markers', size = ~Average_GPA) %>% 
    layout(xaxis = list(tickfont = list(size = 1)))
  
  return(p)
}
#lala <- read.csv("full_data.csv")

