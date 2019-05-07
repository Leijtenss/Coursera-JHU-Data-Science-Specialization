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


## Q4
# Across the United States, how have emissions from coal combustion-related sources 
#       changed from 1999–2008?

# Data prep
plot4 <- subset(NEI, grepl('oal',NEI$Short.Name, fixed=TRUE), 
                 c("Emissions", "year","type", "Short.Name"))
plot4 <- aggregate(Emissions ~ year, plot4, sum)

png(file = "plot4.png")

# Plot the chart
plot((Emissions / 1000) ~ year, 
     data = plot4, 
     type = "l", 
     #ylim = c(min(df1[ ,-1]), max(df1[ ,-1])),
     xlab = "Year",
     ylab = "Total emissions (/1000)",
     main = "Total US Coal Emissions",
     xaxt="n")
axis(side=1, at=c("1999", "2002", "2005", "2008"))

# Save the file.
dev.off()

