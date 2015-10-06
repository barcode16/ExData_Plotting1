#Read data from datafile which needs to be in R Working Directory
#Source data downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Original assignment completed Aug 2014. Re-completed Oct 2015 on Signature Track

data<-read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

#Convert Date variable from factor to date format

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#Combine new composite variable of time and date, and convert to date/time format using strptime()

data$datetime <- paste(data$Date, data$Time)
data$datetime <- strptime(data$datetime, format= "%Y-%m-%d %H:%M:%S")

#Tidy variable names by removing special characters and converting to lower case

colnames(data)<-tolower(gsub("[^[:alnum:]]", "", colnames(data)))

#Create a subset of the data to include only the dates from 2007-02-01 to 2007-02-02

subdata<-data[data$date=="2007-02-01" | data$date=="2007-02-02", ]

#Open png graphics device, create histogram, and close graphics device)

png(file="plot1.png", height=480, width=480)

hist(subdata$globalactivepower,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red"
     )

dev.off()





