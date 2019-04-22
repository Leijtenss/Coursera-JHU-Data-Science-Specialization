## Q1 - Download the following file
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
fileUrlQ1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrlQ1, destfile = "q1.csv", method = "curl")
df_q1 <- read.csv("q1.csv")

str(df_q1$VAL) # Check variable type
length(which(df_q1$VAL == 24)) # 24 is code for properties > 1million


## Q2 - Consider the variable FES in the code book. 
# Which of the "tidy data" principles does this variable violate?

unique(df_q1$FES) # check unique values in column FES
str(df_q1$FES)


## Q3 - Download the Excel spreadsheet on Natural Gas Aquisition Program here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
fileUrlQ3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrlQ3, destfile = "q3.xlsx", method = "curl")

library(readxl)
dat <- read_excel("q3.xlsx", range = cell_rows(18:23))
dat <- dat[,c(7:15)]

sum(dat$Zip*dat$Ext,na.rm=T)


## Q4 - Read the XML data on Baltimore restaurants from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
library(XML)
fileUrlQ4 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrlQ4, useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)

names(rootNode)
rootNode[[1]][[1]][[2]] # check individual record

sum(xpathSApply(rootNode,"//zipcode",xmlValue) == 21231) # number with this zip

## Q5 - Download the 2006 microdata survey about housing 
# for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
# using the fread() command load the data into an R object
fileUrlQ5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrlQ5, destfile = "q5.csv", method = "curl")

library(data.table)
DT = fread('Q5.csv')

system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15)) + system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))





