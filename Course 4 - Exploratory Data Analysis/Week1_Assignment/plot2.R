## Step 1 - Load the data
# Load only records for 2007-02-01 and 2007-02-02
househ <- read.table("household_power_consumption.txt", header = FALSE, 
                     sep = ";", dec = ".", skip = 66637, nrows = 2880,
                     col.names=c("Date", 
                                 "Time", 
                                 "Global_active_power", 
                                 "Global_reactive_power",
                                 "Voltage",
                                 "Global_intensity",
                                 "Sub_metering_1",
                                 "Sub_metering_2",
                                 "Sub_metering_3"))

# Create datetime by pasting together Date and Time
househ$datetime <- with(househ, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M"))


## Plot 2
# Plot and save to png
png('plot2.png')
with(househ, plot(datetime, Global_active_power, type = "l", 
                  xlab = "",
                  ylab = "Global Active Power (kilowatts)"))
dev.off()