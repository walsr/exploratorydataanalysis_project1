# code to create plot1.png
setwd("/Users/tgdwaana/data/")

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

# convert date, time variables to date/time classes 
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#selecting only 2007-02-01 and 2007-02-02 
data.selection <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

#plot
hist(data.selection$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## save to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
