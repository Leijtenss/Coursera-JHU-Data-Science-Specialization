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

