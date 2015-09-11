
##************************************************************************************
## Created by: Joan Braithwaite
## Date: 9/11/2015
## Project: Exploratory Data Analysis, Assignment 1
##
## This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets.
##
## Input: household_power_consumption text file
##************************************************************************************ 
## Read in data table

if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}
power <- read.table(file, header=T, sep=";")  ##Read text input file from working folder
## Convert date to get subset
power$Date <- as.Date(power$Date, format="%d/%m/%Y") ## Convert date
## Select working set of data
df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),] 
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
## merge date and time
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

## Generate Plot 2

plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
cat("plot2.png has been saved in", getwd())
