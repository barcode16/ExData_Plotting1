#Read data from datafile which needs to be in R Working Directory
#Source data downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Download date: 4th Aug 2014

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

#Remove original data set to free up memory

rm(data)

#Open png graphics device, create plot, and close png device

png(file="plot2.png", height=480, width=480)

plot(subdata$datetime, subdata$globalactivepower,
     type="l",
     ylab="Global Active Power (kilowatts)", 
     xlab=""
     )

dev.off()
