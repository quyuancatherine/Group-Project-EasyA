setwd("~/Documents/School/info201/Group-Project-EasyA")
library(stringr)
library(dplyr)
library(plotly)
library(XML)
grade_data <- read.csv("grade_data.csv", stringsAsFactors = FALSE)

majors <- "http://www.washington.edu/students/reg/depttools/tsupdate/major.php"
major.list <- readHTMLTable(majors, header=TRUE, stringsAsFactor = FALSE)
major.table <-bind_rows(major.list)
colnames(major.table) <- c("department", "department_name")
major.table <- major.table %>% mutate(department_name = trimws(str_match(department_name, '[^();]*'))) %>%
  distinct(department, .keep_all = TRUE)

grade_data <- grade_data %>% mutate(department = trimws(str_match(Course_Number, '[^0-9]*'))[,1]) %>% left_join(major.table)


new_data <- grade_data %>% group_by(department, department_name, Term) %>% summarize(classes = n(), class_size = mean(Student_Count), mean_gpa = mean(Average_GPA))
map <- plot_ly(new_data, x = new_data$class_size, y = new_data$mean_gpa, color = "blue")
