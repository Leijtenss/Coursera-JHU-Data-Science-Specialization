#rm(list = ls(all.names = TRUE)) 

pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".
        
        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        
        ## Steps taken
        # Set directory for specdata which is hidden behind multiple subfolders
        dirs <- list.dirs()
        directory <- (dirs[grepl(directory, dirs)])
        
        # Create extra variables
        file_list <- list.files(directory)
        data <- NA
        
        # Read csv-files and combine them into dataframe called data
        for (i in id) {
                file_path <- paste(directory, file_list[i], sep="/")
                csv_data <- read.csv(file_path)
                data <- rbind(data, csv_data)
                }
        
        # Final step, calculate mean depending on pollutant
        mean(data[[pollutant]], na.rm = TRUE)
}

# Example
pollutantmean(directory = 'specdata', pollutant = 'sulfate', id = 300)


# Exam questions
#Q1
round(pollutantmean("specdata", "sulfate", 1:10), 3)

#Q2
round(pollutantmean("specdata", "nitrate", 70:72), 3)

#Q3
round(pollutantmean("specdata", "sulfate", 34), 3)

#Q4
round(pollutantmean("specdata", "nitrate"), 3)
