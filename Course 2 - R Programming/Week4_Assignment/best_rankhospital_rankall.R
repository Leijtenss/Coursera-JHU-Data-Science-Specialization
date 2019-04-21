## 1 Plot the 30-day mortality rates for heart attack
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

outcome[, 11] <- as.numeric(outcome[, 11])
## You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11])



## 2 Finding the best hospital in a state
# Write a function called best 

best <- function(state, outcome) {
        
        # Create outcomes first
        outcomes = c("heart attack", "heart failure", "pneumonia")
        
        ## Read outcome data
        # Filter out unnecessary columns and rename
        data <- read.csv("outcome-of-care-measures.csv", 
                         na.strings="Not Available",
                         colClasses = "character")
        df <- data[,c(2, 7, 11, 17, 23)]
        colnames(df) <- c("hospital", 
                          "state", 
                          "heart attack", 
                          "heart failure", 
                          "pneumonia")
        
        ## Check that state and outcome are valid
        if(!state %in% df[,'state']) {
                stop('select valid state')
                
        } else if(!outcome %in% c('heart attack',
                                  'heart failure',
                                  'pneumonia')) {
                stop('select valid outcome')
        } 
        
        ## Return hospital name in that state with lowest 30-day death
        ## rate
        df <- df[df$state==state & !is.na(df[outcome]),]
        values <- df[, outcome]
        index_nr <- which.min(values)
        df[index_nr,]$hospital
        
}

## Test
# Example 1
best("TX", "heart attack")



## 3 Write a function called rankhospital

rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        # Filter out unnecessary columns and rename
        data <- read.csv("outcome-of-care-measures.csv", 
                         na.strings="Not Available",
                         colClasses = "character")
        
        ## Check that state and outcome are valid
        if(!state %in% df[,'state']) {
                stop('select valid state')
                
        } else if(!outcome %in% c('heart attack',
                                  'heart failure',
                                  'pneumonia')) {
                stop('select valid outcome')
        } else if(!num %in% c("worst", "best") & num > nrow(df)) {
                stop(NA)
        }
        
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        df <- df[df$state==state & !is.na(df[outcome]),]
        
        df$`heart attack` <- as.numeric(df$`heart attack`)
        df$`heart failure` <- as.numeric(df$`heart failure`)
        df$pneumonia <- as.numeric(df$pneumonia)
        
        df <- df[with(df, order(df[outcome], df$hospital)), ]
        
        df$rank <- NA
        df$rank <- 1:nrow(df)
        
        df$type <- ifelse(df$rank == 1, "best", 
                           ifelse(df$rank == nrow(df), "worst",
                                  df$rank))
        
        df[(df$rank == num | df$type == num),]$hospital
        
}


## Test
# Example 1 - "DETAR HOSPITAL NAVARRO"
rankhospital("TX", "heart failure", 4)

# Worst - "HARFORD MEMORIAL HOSPITAL"
rankhospital("MD", "heart attack", "worst")



## 4 Write a function called rankall

library(dplyr)

rankall <- function(outcome, num = "best") {

        ## Read outcome data
        # Filter out unnecessary columns and rename
        data <- read.csv("outcome-of-care-measures.csv", 
                         na.strings="Not Available",
                         colClasses = "character")
        
        len <- nrow(data)
        
        ## Check that state and outcome are valid
        if(!outcome %in% c('heart attack',
                                  'heart failure',
                                  'pneumonia')) {
                stop('select valid outcome')
                
        } else if(!num %in% c("worst", "best") & num > nrow(df)) {
                stop(NA)
        }
        
        ## For each state, find the hospital of the given rank
        #df <- df[!is.na(df[outcome]),]
        
        # Manual adjustment of variable types
        cols.num <- c(3:5)
        df[cols.num] <- sapply(df[cols.num],as.numeric)
        
        df <- df[with(df, order(df$state, 
                                df[outcome], 
                                df$hospital)), ]
        
        df$rank <- sapply(1:nrow(df),
                           function(i) sum(df[1:i, c('state')]==df$state[i]))

        
        df$type <- ifelse(df$rank == 1, "best", 
                          ifelse(df$rank >= lead(df$rank, n=1L, default=NA), "worst",
                                 df$rank))
        
        df$type <- ifelse(is.na(df$type), "worst", df$type)
        
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        
        df[(df$rank == num | df$type == num),c(1:2)]

}


# Example 1
head(rankall("heart attack", 20), 10)

# Example 2
tail(rankall("pneumonia", "worst"), 3)

# Example 3
tail(rankall("heart failure"), 10)
