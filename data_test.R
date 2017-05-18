setwd("~/Documents/School/info201/Group-Project-EasyA")
library(stringr)
library(dplyr)
library(plotly)
grade_data <- read.csv("grade_data.csv", stringsAsFactors = FALSE)
grade_data <- grade_data %>% mutate(department = str_match(Course_Number, '[^0-9]*'))

new_data <- grade_data %>% group_by(department, Term) %>% summarize(classes = n(), class_size = mean(Student_Count), mean_gpa = mean(Average_GPA))
map <- plot_ly(new_data, x = new_data$class_size, y = new_data$mean_gpa, color = "blue")
