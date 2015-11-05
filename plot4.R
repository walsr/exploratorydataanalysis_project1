# code to create plot4.png
#setwd("/Users/tgdwaana/data/")

zipfilename <- "exdata_data_household_power_consumption.zip"
txtfilename <- "household_power_consumption.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## download and unzip the data
if (!file.exists(zipfilename)){
  download.file(url, zipfilename, method="curl")
}

if (!file.exists(txtfilename)) { 
  unzip(zipfilename) 
}

# read data
data <- read.csv(txtfilename, header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE, dec=".")

# convert date to date class in order to be able to select subset 
data$Date <- as.Date(data$Date, "%d/%m/%Y")
# create new variable timestamp with date and time combined
data$timestamp <- as.POSIXct(paste(data$Date, data$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

#selecting only 2007-02-01 and 2007-02-02 
data.selection <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

x <- data.selection$timestamp
y1 <- data.selection$Sub_metering_1
y2 <- data.selection$Sub_metering_2
y3 <- data.selection$Sub_metering_3

#plot
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
plot(x, data.selection$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(x, data.selection$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(x, y1, type="l", xlab="", ylab="Energy sub metering")
lines(x,y2, col="red")
lines(x,y3, col="blue")
legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(x, data.selection$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
