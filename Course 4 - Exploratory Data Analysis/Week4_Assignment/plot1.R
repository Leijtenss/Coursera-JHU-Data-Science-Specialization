library(plyr) 
library(dplyr)
library(ggplot2)

options(scipen=999)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df <- subset(SCC, select = c("SCC", "Short.Name"))
NEI <- merge(NEI, df, by.x="SCC", by.y="SCC", all=TRUE)

rm(SCC)

## Q1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#         Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
#         for each of the years 1999, 2002, 2005, and 2008.

# Data prep
plot1 <- aggregate(Emissions ~ year, NEI, sum)

png(file = "plot1.png")

# Plot the chart
plot((Emissions / 1000) ~ year, 
     data = plot1, 
     type = "l", 
     #ylim = c(min(df1[ ,-1]), max(df1[ ,-1])),
     xlab = "Year",
     ylab = "Total emissions (/1000)",
     main = "Total US PM2.5 Emissions",
     xaxt="n")
axis(side=1, at=c("1999", "2002", "2005", "2008"))

# Save the file.
dev.off()


