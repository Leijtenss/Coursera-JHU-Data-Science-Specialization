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


