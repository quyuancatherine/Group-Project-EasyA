setwd("~/Documents/School/info201/Group-Project-EasyA")
library(stringr)
library(dplyr)
library(plotly)
grade_data <- read.csv("grade_data.csv", stringsAsFactors = FALSE)
grade_data <- grade_data %>% mutate(department = str_match(Course_Number, '[^0-9]*'))


majors <- "http://www.washington.edu/students/reg/depttools/tsupdate/major.php"
major.list <- readHTMLTable(majors, header=TRUE, stringsAsFactor = FALSE)
major.table <-bind_rows(major.list)
colnames(major.table) <- c("abbr", "name")
major.table <- major.table %>% mutate(name = trimws(str_match(name, '[^();-]*'))) %>%
  distinct(abbr, .keep_all = TRUE)


new_data <- grade_data %>% group_by(department, Term) %>% summarize(classes = n(), class_size = mean(Student_Count), mean_gpa = mean(Average_GPA))
map <- plot_ly(new_data, x = new_data$class_size, y = new_data$mean_gpa, color = "blue")
