complete_func <- list.files(pattern = "complete.", recursive = TRUE)
source(complete_func)

corr <- function(directory, threshold = 0) {
        ## Steps taken
        # Set directory for specdata which is hidden behind multiple subfolders
        dirs <- list.dirs()
        directory <- (dirs[grepl(directory, dirs)])
        
        # Filter out cases below threshold
        observations <- complete(directory)
        filtered <- subset(observations, observations$nobs > threshold)
        
        # Create extra variables
        file_list <- list.files(directory)
        correlation <- vector()

        # For each id in filtered observations:
        # Read csv-files and combine them into dataframe called data
        for (i in filtered$id) {
                file_path <- paste(directory, file_list[i], sep="/")
                data <- read.csv(file_path)
                
        # Remove NA
        data <- subset(data, complete.cases(data))      
                  
        # Calculate correlation
        correlation <- c(correlation,cor(data$nitrate, data$sulfate))                
        }

        # return correlation
        correlation
}

# Test case
cr <- corr('specdata', 5000)
head(cr)


# Exam questions
#Q8
cr <- corr("specdata")                
cr <- sort(cr)                
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

#Q9
cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)                
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

#Q10
cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))