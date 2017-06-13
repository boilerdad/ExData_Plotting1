## Plot 1 - Histogram of kilowatts of Gloab Active Power

## All of this uses the base graphics system,
## Need to load  lubridate to make things a lot easier.

library(lubridate)

## Read Data from current working director

url <- "household_power_consumption.txt"
rawdata <- read.table(url, header = TRUE, sep = ";")

## create a new variable with the date as.date
newdate <- strptime(rawdata$Date, "%d/%m/%Y")

## add the new variable to the raw data
rawdata <- cbind(rawdata, newdate)

startDate <- as.Date("2007-02-01")
endDate <- as.Date("2007-02-02")

## get only the data needed for the period of Feb 1-2, 2007
workingdata <- rawdata[rawdata$newdate >= startDate & rawdata$newdate <= endDate, ]

## now set proper data types

workingdata$Global_active_power <- as.double(as.character(workingdata$Global_active_power))
workingdata$Global_reactive_power <- as.double(as.character(workingdata$Global_reactive_power))
workingdata$Voltage <- as.double(as.character(workingdata$Voltage))
workingdata$Global_intensity <- as.double(as.character(workingdata$Global_intensity))
workingdata$Sub_metering_1 <- as.double(as.character(workingdata$Sub_metering_1))
workingdata$Sub_metering_2<- as.double(as.character(workingdata$Sub_metering_2))
workingdata$Sub_metering_3 <- as.double(as.character(workingdata$Sub_metering_3))


## Get rid of the originial rawdata to save space

## rm(rawdata, newdate)

## Start Plot 2

## set date time variable

datetime <- strptime(paste(workingdata$Date, workingdata$Time), "%d/%m/%Y %H:%M:%S")

png("plot2.png",width = 480, height = 480)

with(workingdata, plot(datetime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()
