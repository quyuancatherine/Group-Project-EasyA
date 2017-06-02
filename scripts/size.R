#FinalINFO201
library(dplyr)
grade.data <- read.csv("full_data.csv")

ClasssizeGPA <- function(size) {
gpa <- grade.data %>%
  filter(Student_Count == size) %>%
  select(Course_Number, Student_Count, Average_GPA) %>%
  summarise(Average_GPA = mean(Average_GPA, na.rm = TRUE))
return(round(gpa, digit = 2))
}

grade.data.mutate <- grade.data %>%
  mutate(All.A = A+A., All.B = B+B.+B..1, All.C = C+C.+C..1, All.D = D+D.+D..1, All.F = F, All.W = W) %>%
  select(X, Academic_Year, Term, Course_Number, Course_Title, Primary_Instructor, Student_Count, 
         Average_GPA, department, department_name, All.A, All.B, All.C, All.D, All.F, All.W)

ClasssizeLetterA <- function(size) {
  gpa <- grade.data.mutate %>%
    filter(Student_Count == size) %>%
    select(Course_Number, Student_Count, All.A) %>%
    summarise(All.A = mean(All.A, na.rm = TRUE))
  return(round(gpa, digit = 0))
}  

ClasssizeLetterB <- function(size) {
  gpa <- grade.data.mutate %>%
    filter(Student_Count == size) %>%
    select(Course_Number, Student_Count, All.B) %>%
    summarise(All.B = mean(All.B, na.rm = TRUE))
  return(round(gpa, digit = 0))
}

ClasssizeLetterC <- function(size) {
  gpa <- grade.data.mutate %>%
    filter(Student_Count == size) %>%
    select(Course_Number, Student_Count, All.C) %>%
    summarise(All.C = mean(All.C, na.rm = TRUE))
  return(round(gpa, digit = 0))
}

ClasssizeLetterD <- function(size) {
  gpa <- grade.data.mutate %>%
    filter(Student_Count == size) %>%
    select(Course_Number, Student_Count, All.D) %>%
    summarise(All.D = mean(All.D, na.rm = TRUE))
  return(round(gpa, digit = 0))
}

ClasssizeLetterF <- function(size) {
  gpa <- grade.data.mutate %>%
    filter(Student_Count == size) %>%
    select(Course_Number, Student_Count, All.F) %>%
    summarise(All.F = mean(All.F, na.rm = TRUE))
  return(round(gpa, digit = 0))
}

ClasssizeLetterW <- function(size) {
  gpa <- grade.data.mutate %>%
    filter(Student_Count == size) %>%
    select(Course_Number, Student_Count, All.W) %>%
    summarise(All.W = mean(All.W, na.rm = TRUE))
  return(round(gpa, digit = 0))
}

