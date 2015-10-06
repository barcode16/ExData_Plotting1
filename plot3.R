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

#Open png graphics device and create plot, then close png graphics device. 
#The legend reverts to less tidy variable names to replicate the example
#the course requires us to produce.

png(file="Plot3.png", height=480, width=480)

plot(subdata$datetime, subdata$submetering1, type="n",
       ylab="Energy sub metering", xlab="")
lines(subdata$datetime, subdata$submetering1,col="black")
lines(subdata$datetime, subdata$submetering2,col="red")
lines(subdata$datetime, subdata$submetering3,col="blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
