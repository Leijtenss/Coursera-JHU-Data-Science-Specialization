install.packages('RMySQL')
library(RMySQL)

source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
created = h5createFile("example.h5")
created


## Q1
install.packages("jsonlite")
library(jsonlite)
install.packages("httpuv")
library(httpuv)
install.packages("httr")
library(httr)

# Can be github, linkedin etc depending on application
oauth_endpoints("github")

# Change based on what you 
myapp <- oauth_app(appname = "Coursera_JHU",
                   key = "e72a2f7c20cd5598c0ac",
                   secret = "eb53d7ce0caad5fac7332aaca2ede6f8640d7a67")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 


## Q2
install.packages('sqldf')
library(sqldf)

fileUrlQ2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrlQ2, destfile = "q2.csv", method = "curl")
acs <- read.csv("q2.csv")

answer_q2 <- sqldf("select pwgtp1 from acs where AGEP < 50") # answer


## Q3
sqldf("select distinct AGEP from acs order by AGEP") # answer


## Q4
# How many characters are in the 10th, 20th, 30th and 100th lines of 
# HTML from this page:
# url: http://biostat.jhsph.edu/~jleek/contact.html
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)

c(nchar(htmlCode[10]), nchar(htmlCode[20]), 
  nchar(htmlCode[30]), nchar(htmlCode[100]))


## Q5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(url, destfile = "q5.for", method = "curl")
q5_df <- read.fwf(file = "q5.for", widths = c(15, 4, 1, 3, 5, 4), 
                  header = FALSE, sep = "\t", skip = 4)
sum(q5_df$V6)
