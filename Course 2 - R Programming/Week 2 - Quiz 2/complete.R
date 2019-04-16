complete <- function(directory, id = 1:332) {
        ## Steps taken
        # Set directory for specdata which is hidden behind multiple subfolders
        dirs <- list.dirs()
        directory <- (dirs[grepl(directory, dirs)])
        
        # Create extra variables
        file_list <- list.files(directory)
        ids <- vector()
        nobs <- vector()
        
        # Read csv-files and combine them into dataframe called data
        for (i in id) {
                file_path <- paste(directory, file_list[i], sep="/")
                data <- read.csv(file_path)
                
        ids = c(ids,i)
        nobs = c(nobs, sum(complete.cases(data)))
        
        }
        data.frame(id=ids, nobs=nobs)
}

# Test case with file number 3
test <- complete('specdata', c(2, 4, 8, 10, 12))
test

# Exam questions
#Q5
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)

#Q6
cc <- complete("specdata", 54)
print(cc$nobs)

#Q7
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])
