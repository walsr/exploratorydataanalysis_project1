# code to create plot2.png
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
y <- data.selection$Global_active_power

#plot
plot(x, y, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## save to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
