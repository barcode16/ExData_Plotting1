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

#Open png graphics device

png(file="plot4.png", height=480, width=480)

#Set parameters to produce 2 x 2 graphs on one plot, filling by column

par(mfcol=c(2,2), mar=c(5,5,2,1), oma=c(0,0,2,0))

#Create first plot which is the same as that produced by plot2.R

plot(subdata$datetime, subdata$globalactivepower,
     type="l",
     ylab="Global Active Power", 
     xlab=""
)

#Create second plot which is the same as that produced by plot3.R

plot(subdata$datetime, subdata$submetering1, type="n",
       ylab="Energy sub metering", xlab="")
lines(subdata$datetime, subdata$submetering1,col="black")
lines(subdata$datetime, subdata$submetering2,col="red")
lines(subdata$datetime, subdata$submetering3,col="blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Create third plot

plot(subdata$datetime, subdata$voltage,
     type="l", 
     ylab="Voltage", 
     xlab="datetime" # untidy label but required to replicate example
     )

#Create fourth plot

plot(subdata$datetime, subdata$globalreactivepower, 
     type="l", 
     ylab="Global_reactive_power", # untidy label but required to replicate example
     xlab="datetime" # untidy label but required to replicate example
     )

#Close png graphics device

dev.off()
