##Q1
# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho. 

# Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
# What is the value of the 123 element of the resulting list?

fileUrlQ1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrlQ1, destfile = "q1.csv", method = "curl")
q1 <- read.csv("q1.csv")

# Check names first of dataframe, get the value from position 123 afterwards
strsplit(names(q1), "wgtp")[123]


##Q2
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# Remove the commas from the GDP numbers in millions of dollars and average them. 
# What is the average?

fileUrlQ2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrlQ2, destfile = "q2.csv", method = "curl")
q2 <- read.csv("q2.csv", skip = 4, nrows=190)

q2 <- q2[,c(1, 2, 4, 5)]
colnames(q2)[4] <- "GDP"

q2$GDP <- as.numeric(gsub(",", "", q2$GDP))
mean(q2$GDP)


##Q3
# In the data set from Question 2 what is a regular expression that would allow you 
# to count the number of countries whose name begins with "United"? 
# Assume that the variable with the country names in it is named countryNames. 
# How many countries begin with United?
grep("^United",q2[, Country])


##Q4 
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

# Match the data based on the country shortcode. Of the countries for which 
# the end of the fiscal year is available, how many end in June?

fileUrlQ4_1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrlQ4_1, destfile = "q4_1.csv", method = "curl")
q4_1 <- read.csv("q4_1.csv", skip = 4, nrows=190)

fileUrlQ4_2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrlQ4_2, destfile = "q4_2.csv", method = "curl")
q4_2 <- read.csv("q4_2.csv")

library(dplyr)
q4_1 <- q4_1[,c(1, 2, 4, 5)]
colnames(q4_1)[1] <- "CountryCode"
colnames(q4_1)[2] <- "Rank"
colnames(q4_1)[3] <- "Country"
colnames(q4_1)[4] <- "GDP"

q4 <- merge(q4_1, q4_2, by="CountryCode")

# Info on fiscal year is stored in Special.Notes
# Example of piece of string: Fiscal year end: June 30
sum(grepl("Fiscal year end: June", q4$Special.Notes))


##Q5 
# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices 
# for publicly traded companies on the NASDAQ and NYSE. 
# Use the following code to download data on Amazon's stock price 
# and get the times the data was sampled.

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# How many values were collected in 2012?
length(grep("^2012",sampleTimes))

# How many values were collected on Mondays in 2012? 
library(lubridate)
sum(weekdays(as.Date(sampleTimes[grep("^2012",sampleTimes)]))=="Monday")
