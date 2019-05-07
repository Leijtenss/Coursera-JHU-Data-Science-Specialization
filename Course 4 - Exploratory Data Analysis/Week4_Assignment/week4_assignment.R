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


## Q3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#         which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#         Which have seen increases in emissions from 1999–2008? 
#         Use the ggplot2 plotting system to make a plot answer this question.

# Data prep
plot3 <- subset(NEI, fips == "24510", c("Emissions", "year","type"))
group_cols <- c("type", "year")
plot3 <- plot3 %>% group_by(!!!syms(group_cols)) %>% summarize(sum=sum(Emissions))

# Plot the chart
ggplot(data = plot3, aes(x = year, y = (sum / 1000), colour = type)) + 
        geom_line() + geom_point() + 
        xlab("Year") + ylab("Emissions (/1000") + 
        ggtitle("Baltimore City PM2.5 Emissions by Type and Year")

# Save the file.
ggsave(file="plot3.png")


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


## Q5
# How have emissions from motor vehicle sources changed from 1999–2008 
# in Baltimore City?

# Data prep
plot5 <- subset(NEI, fips == "24510" & type =="ON-ROAD", c("Emissions", "year","type"))
plot5 <- aggregate(Emissions ~ year, plot5, sum)

png(file = "plot5.png")

# Plot the chart
plot((Emissions / 1000) ~ year, 
     data = plot5, 
     type = "l", 
     #ylim = c(min(df1[ ,-1]), max(df1[ ,-1])),
     xlab = "Year",
     ylab = "Total emissions (/1000)",
     main = "Baltimore City PM2.5 Motor Vehicle Emissions",
     xaxt="n")
axis(side=1, at=c("1999", "2002", "2005", "2008"))

# Save the file.
dev.off()


## Q6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips=="06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Data prep
plot6 <- subset(NEISCC, (fips == "24510" | fips == "06037") & type =="ON-ROAD", c("Emissions", "year","type", "fips"))
plot6$city <- ifelse(plot6$fips == "24510", "Baltimore City", "L.A. County")

group_cols <- c("city", "year")
plot6 <- plot6 %>% group_by(!!!syms(group_cols)) %>% summarize(sum=sum(Emissions))

# Plot the chart
ggplot(data = plot6, aes(x = year, y = (sum / 1000), colour = city)) + 
        geom_line() + geom_point() + 
        xlab("Year") + ylab("Total emissions (/1000)") + 
        ggtitle("Total PM2.5 Emissions Motor Vehicles per year for Baltimore and L.A.")

# Save the file.
ggsave(file="plot6.png")

