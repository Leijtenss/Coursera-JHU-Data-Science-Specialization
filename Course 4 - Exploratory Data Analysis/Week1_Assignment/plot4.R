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


## Plot 4
# Plot and save to png
png('plot4.png')

# Set up plot 2x2
par(mfrow = c(2, 2))

# Plot the individual graphs
# Top left
with(househ, plot(datetime, Global_active_power, type = "l", 
                  xlab = "",
                  ylab = "Global Active Power (kilowatts)"))

# Top right
with(househ, plot(datetime, Voltage, type = "l", 
                  xlab = "datetime",
                  ylab = "Voltage"))

# Bottom left
plot(househ$datetime, househ$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(househ$datetime, househ$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
lines(househ$datetime, househ$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", col = c("black", "red", "blue"), lty=1, lwd=2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Bottom right
with(househ, plot(datetime, Global_reactive_power, type = "l", 
                  xlab = "datetime",
                  ylab = "Global_reactive_power"))

dev.off()


