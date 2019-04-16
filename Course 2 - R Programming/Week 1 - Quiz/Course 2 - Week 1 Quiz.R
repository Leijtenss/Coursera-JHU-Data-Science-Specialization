#Q4
# If I execute the expression x <- 4L in R, what is the class of the object `x' 
# as determined by the `class()' function?
x <- 4L
class(x)

#Q5
# What is the class of the object defined by x <- c(4, TRUE)?
x <- c(4, TRUE)
class(x)

#Q6 
# If I have two vectors x <- c(1,3, 5) and y <- c(3, 2, 10), what is produced 
# by the expression cbind(x, y)?
x <- c(1,3,5)
y <- c(3,2,10)
cbind(x, y)

#Q8
# Suppose I have a list defined as x <- list(2, "a", "b", TRUE). 
# What does x[[1]] give me? Select all that apply.
x <- list(2, "a", "b", TRUE)
x[[1]]

#Q9 
# Suppose I have a vector x <- 1:4 and y <- 2:3. What is produced by 
# the expression x + y?
x <- 1:4
y <- 2:3
x + y

# Q12
# Extract the first 2 rows of the data frame and print them to the console. 
# What does the output look like?
head(hw1_data, 2)

#Q13 
# Extract the last 2 rows of the data frame and print them to the console. 
# What does the output look like?
tail(hw1_data, 2)

#Q15
# What is the value of Ozone in the 47th row?
hw1_data$Ozone[47]

#Q16 
# How many missing values are in the Ozone column of this data frame?
sum(is.na(hw1_data$Ozone))

#Q17
# What is the mean of the Ozone column in this dataset? Exclude missing values 
# (coded as NA) from this calculation
mean(hw1_data$Ozone[!is.na(hw1_data$Ozone)])

#Q18
# Extract the subset of rows of the data frame where Ozone values are above 31 
# and Temp values are above 90. What is the mean of Solar.R in this subset?
good <- complete.cases(hw1_data$Ozone, hw1_data$Solar.R, hw1_data$Temp)
mean(hw1_data$Solar.R[good & hw1_data$Ozone > 31 & hw1_data$Temp > 90])

#Q19
good <- complete.cases(hw1_data$Month, hw1_data$Temp)
mean(hw1_data$Temp[good & hw1_data$Month == 6])

#Q20
# What was the maximum ozone value in the month of May (i.e. Month = 5)?
max(hw1_data$Ozone[hw1_data$Month==5 & !is.na(hw1_data$Ozone)])