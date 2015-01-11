## This is for class Exploratory Data Analysis
## Project 1, plot 4

setwd("C:\\Users\\lenovo\\Documents\\classes\\Exploratory Data Analysis")
if(!file.exists("data")) {
        dir.create("data")
}

## Download the file
.exdir <- "./data"
.file <- file.path(.exdir, "household_power_consumption.zip")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = .file)

## Unzip the file
unzip(.file, exdir = .exdir)
list.files("./data")
dateDownLoaded <- date()
dateDownLoaded

powerConsumptionData <- read.table("./data/household_power_consumption.txt", 
                                   sep=";", header=TRUE, nrows=2075259,
                                   colClasses = c("character", "character", "character",
                                                  "character", "character", "character",
                                                  "character", "character", "character"))

## Make a DateTime Column and format
powerConsumptionData$DateTime <- paste(powerConsumptionData$Date, powerConsumptionData$Time)
powerConsumptionData$DateTime <- strptime(powerConsumptionData$DateTime, format = "%d/%m/%Y %H:%M:%S") 
powerConsumptionData$Date <- as.Date(powerConsumptionData$Date, "%d/%m/%Y")

## Narrow the data down to just the February 1-2, 2007 data
Feb01to022007Data <- subset(powerConsumptionData, Date == "2007-02-01" | Date == "2007-02-02")

## Convert to numeric values
Feb01to022007Data$Global_active_power <- as.numeric(Feb01to022007Data$Global_active_power)
Feb01to022007Data$Global_reactive_power <- as.numeric(Feb01to022007Data$Global_reactive_power)
Feb01to022007Data$Voltage <- as.numeric(Feb01to022007Data$Voltage)
Feb01to022007Data$Sub_metering_1 <- as.numeric(Feb01to022007Data$Sub_metering_1)
Feb01to022007Data$Sub_metering_2 <- as.numeric(Feb01to022007Data$Sub_metering_2)
Feb01to022007Data$Sub_metering_3 <- as.numeric(Feb01to022007Data$Sub_metering_3)

## Fourth plot
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(Feb01to022007Data, {
        plot(DateTime, Global_active_power, xlab="",
             ylab="Global Active Power", type="l")
        plot(DateTime, Voltage, xlab="datetime", ylab="Voltage", type="l")
        plot(DateTime, Sub_metering_1, type="n", xlab="",
             ylab="Energy sub metering")
        lines(DateTime, Sub_metering_1)
        lines(DateTime, Sub_metering_2, col="red")
        lines(DateTime, Sub_metering_3, col="blue")
        legend("topright", lty=1, col=c("black", "red", "blue"),
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(DateTime, Global_reactive_power, xlab="datetime",
             ylab="Global_reactive_power", type="l")
})
dev.off()  ## close the PNG file device
