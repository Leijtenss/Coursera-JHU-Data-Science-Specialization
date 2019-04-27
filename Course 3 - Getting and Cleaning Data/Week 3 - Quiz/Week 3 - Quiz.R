##Q1
# Create a logical vector that identifies the households on greater than 
# 10 acres who sold more than $10,000 worth of agriculture products.

# What are the first 3 values that result?
fileUrlQ1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrlQ1, destfile = "q1.csv", method = "curl")
q1 <- read.csv("q1.csv")

# Var > 10 acres: ACR = 3
# Var > sales over $10k: AGS = 6

q1$agricultureLogical <- ifelse((q1$ACR == 3) & (q1$AGS == 6), TRUE, FALSE)

# Check the number of rows per value for the newly created variable
table(q1$agricultureLogical)

# And check the first three rows of this variable
head(which(q1$agricultureLogical), n=3)


##Q2
# Using the jpeg package read in the following picture of your instructor into R
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg

library(jpeg)

# Download the file
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
              , 'jeff.jpg', mode='wb' )

# Read the image
pic <- jpeg::readJPEG('jeff.jpg', native=TRUE)

# What are the 30th and 80th quantiles of the resulting data?
quantile(pic, probs=c(0.3, 0.8))


##Q3 
# Match the data based on the country shortcode. How many of the IDs match? 
# Sort the data frame in descending order by GDP rank (so United States is last).
# What is the 13th country in the resulting data frame?
fileUrlQ3_1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrlQ3_1, destfile = "q3_1.csv", method = "curl")
q3_1 <- read.csv("q3_1.csv", skip = 4, nrows=190)

fileUrlQ3_2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrlQ3_2, destfile = "q3_2.csv", method = "curl")
q3_2 <- read.csv("q3_2.csv")

library(dplyr)
q3_1 <- q3_1[,c(1, 2, 4, 5)]
colnames(q3_1)[1] <- "CountryCode"
colnames(q3_1)[2] <- "Rank"
colnames(q3_1)[3] <- "Country"
colnames(q3_1)[4] <- "GDP"

#q3_2 <- select(q3_2, CountryCode)
q3 <- merge(q3_1, q3_2, by="CountryCode")

# How many matches?
nrow(q3)

# Sort by GDP, then check 13th position
q3 <- arrange(q3, desc(Rank))
q3[13,3]


##Q4
# What is the average GDP ranking for the "High income: OECD" 
# and "High income: nonOECD" group?
# Variable: Income.Group
library(plyr)
q3_income <- filter(q3, Income.Group %in% c("High income: OECD",
                                            "High income: nonOECD"))
ddply(q3_income, .(Income.Group), summarize, mean=mean(Rank))


##Q5 
# Cut the GDP ranking into 5 separate quantile groups
# Make a table versus Income.Group
# How many countries are Lower middle income but among the 38 nations 
# with highest GDP?
library(Hmisc)

## Cut Ranks into 5 groups and store as factor variable
q3$Rank.Groups = cut2(q3$Rank, g = 5)

## Build a table of Income Groups across Rank Groups
table(q3$Income.Group, q3$Rank.Groups)


   