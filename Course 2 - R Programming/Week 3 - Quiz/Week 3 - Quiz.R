library(datasets)
data(iris)

?iris

#Q1
# what is the mean of 'Sepal.Length' for the species virginica?
round(mean(iris$Sepal.Length[iris$Species == 'virginica']), 0)

#Q2
# what R code returns a vector of the means of the variables 'Sepal.Length', 
# 'Sepal.Width', 'Petal.Length', and 'Petal.Width'?
head(iris)

# Gives vector of the means
apply(iris[, 1:4], 1, mean)

# Gives the mean per variable
apply(iris[, 1:4], 2, mean)


library(datasets)
data(mtcars)

#Q3
# How can one calculate the average miles per gallon (mpg) by number of 
# cylinders in the car (cyl)?
sapply(split(mtcars$mpg, mtcars$cyl), mean) #1
with(mtcars, tapply(mpg, cyl, mean)) #2
tapply(mtcars$mpg, mtcars$cyl, mean) #3


#Q4
# what is the absolute difference between the average horsepower of 4-cylinder 
# cars and the average horsepower of 8-cylinder cars?

# Check averages first
sapply(split(mtcars$hp, mtcars$cyl), mean)

# Now to calculate difference between 4 and 8 cylinder cars
round(mean(mtcars$hp[mtcars$cyl == 8]) - mean(mtcars$hp[mtcars$cyl == 4]), 0)


#Q5
# If you run debug(ls), what happens if you run ls afterwards?
debug(ls)
ls()
