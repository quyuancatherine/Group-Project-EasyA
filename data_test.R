setwd("~/Documents/School/info201/Group-Project-EasyA")
library(stringr)
library(dplyr)
library(plotly)
grade_data <- read.csv("grade_data.csv", stringsAsFactors = FALSE)
grade_data <- grade_data %>% mutate(department = str_match(Course_Number, '[^0-9]*'))

grade_data <- grade_data %>% group_by(department, Term) %>% summarize(classes = n(), class_size = mean(Student_Count), mean_gpa = mean(Average_GPA))
map <- plot_ly(grade_data, x = grade_data$class_size, y = grade_data$mean_gpa, color = "blue")
