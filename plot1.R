

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")

sel_data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

sel_data$Time <- format(strptime(sel_data$Time, "%H:%M:%S"), "%H:%M:%S")

cols.num <- 3:8
sel_data[cols.num] <- sapply(sel_data[cols.num],as.numeric)

sel_data$DateTime <- paste(sel_data$Date, sel_data$Time)


sel_data$DateTime <- as.POSIXct(strptime(sel_data$DateTime, "%Y-%m-%d %H:%M:%S"))



# Plot 1.

png(file = "plot1.png", width = 480, height = 480, units = "px")
with(sel_data, hist(Global_active_power/1000, col = "red", main = NULL, xlab = NULL))
title(main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
