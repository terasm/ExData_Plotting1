

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")

sel_data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

sel_data$Time <- format(strptime(sel_data$Time, "%H:%M:%S"), "%H:%M:%S")

cols.num <- 3:8
sel_data[cols.num] <- sapply(sel_data[cols.num],as.numeric)

sel_data$DateTime <- paste(sel_data$Date, sel_data$Time)


sel_data$DateTime <- as.POSIXct(strptime(sel_data$DateTime, "%Y-%m-%d %H:%M:%S"))


# Plot 3.

png(file = "plot3.png", width = 480, height = 480, units = "px")
plot(sel_data$DateTime, sel_data$Sub_metering_1, type = "l", ylab = "Energy sub metering", 
     xlab = "", xaxt = 'n')
lines(sel_data$DateTime, sel_data$Sub_metering_2, col = "red")
lines(sel_data$DateTime, sel_data$Sub_metering_3, col = "blue")
axis.POSIXct(side = 1, sel_data$DateTime, labels = TRUE, by = "day")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1),
       col = c("black", "red", "blue"))
dev.off()