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


## Q2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips=="24510") 
#         from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Data prep
plot2 <- subset(NEI, fips == "24510", c("Emissions", "year","type"))
plot2 <- aggregate(Emissions ~ year, plot2, sum)

png(file = "plot2.png")

# Plot the chart
plot((Emissions / 1000) ~ year, 
     data = plot2, 
     type = "l", 
     #ylim = c(min(df1[ ,-1]), max(df1[ ,-1])),
     xlab = "Year",
     ylab = "Total emissions (/1000)",
     main = "Baltimore City PM2.5 Emissions",
     xaxt="n")
axis(side=1, at=c("1999", "2002", "2005", "2008"))

# Save the file.
dev.off()


