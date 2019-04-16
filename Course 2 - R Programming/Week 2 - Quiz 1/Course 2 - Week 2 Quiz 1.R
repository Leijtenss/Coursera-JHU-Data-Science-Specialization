#Q1
# Suppose I define the following function in R
cube <- function(x, n) {
        x^3
}

# What is the result of running:
cube(3)


#Q2
# The following code will produce an error in R, why?
x <- 1:10
if(x > 5) {
        x <- 0
}

#Q3
# What value is returned when running the following?
f <- function(x) {
        g <- function(y) {
                y + z
        }
        z <- 4
        x + g(x)
}

z <- 10
f(3)

#Q4
# Consider the following expression. What is the value of 'y'?
x <- 5
y <- if(x < 3) {
        NA
} else {
        10
}

#Q5
# Consider the following R-function. Which symbol is the free variable?
h <- function(x, y = NULL, d = 3L) {
        z <- cbind(x, d)
        if(!is.null(y))
                z <- z + y
        else
                z <- z + f
        g <- x + y / z
        if(d == 3L)
                return(g)
        g <- g + 10
        g
}

#Q6
