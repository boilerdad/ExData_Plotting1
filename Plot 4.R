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

rm(rawdata, newdate)

## Start Plot 4

## set date time variable

datetime <- strptime(paste(workingdata$Date, workingdata$Time), "%d/%m/%Y %H:%M:%S")

png("plot4.png",width = 480, height = 480)

# setup 2 x 2 plotting space

par(mfrow = c(2,2))

## add plot 1 

with(workingdata, plot(datetime, Global_active_power, type="l", xlab = "", ylab = "Global Active Power"))

## add plot 2

with(workingdata, plot(datetime, Voltage, type="l",  ylab = "Voltage"))

## add plot 3

plot(datetime, workingdata$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering", ylim = c(0,max(workingdata$Sub_metering_1)))
par(new = TRUE)
plot(datetime, workingdata$Sub_metering_2, col="red", type="l", axes = FALSE, ylab = "", xlab = "",ylim = c(0,max(workingdata$Sub_metering_1)))
par(new=TRUE)
plot(datetime, workingdata$Sub_metering_3, col="blue", type="l", axes = FALSE, ylab = "", xlab = "",ylim = c(0,max(workingdata$Sub_metering_1)))
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
par(new=FALSE)

## add plot 4

with(workingdata, plot(datetime, Global_reactive_power, type="l"))


dev.off()
