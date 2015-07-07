library(dplyr)
#select colnames
dir<-paste(getwd(),"household_power_consumption.txt",sep="/")
names<-names(read.table(dir,header = TRUE , sep= ";", nrow=1))

#open file
dataframe<-read.table(dir, na.strings = "?", sep=";", skip=24*60*45, nrow=24*60*60, col.names = c(names))
dataframe<-filter(dataframe, Date=="1/2/2007" | Date=="2/2/2007")

#format Date and Time
dataframe<-mutate(dataframe, Fulldate = paste(Date,Time))
dataframe$Fulldate<-strptime(dataframe$Fulldate, format= "%d/%m/%Y %H:%M:%S")

#graph paramaters
png(file="plot4.png")
par(mfrow=c(2,2), mar=c(4,4,1,1))

#plot 4 graphs
#plot 1
with(dataframe, plot(Fulldate,Global_active_power, type = "l", ylab= "Global Active Power", xlab=""))

#plot 2
with(dataframe, plot(Fulldate,Voltage, type = "l", ylab= "Voltage", xlab="datetime"))

#plot 3
with(dataframe, plot(Fulldate,Sub_metering_1, type = "l", ylab= "Energy sub metering", xlab=""))
with(dataframe, {lines(Fulldate, Sub_metering_2, col= "red", type="l")
        lines(Fulldate,Sub_metering_3, type = "l", col="blue")
        legend("topright",lty= 1,
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               col= c("black", "red","blue"), bty="n")
})

#plot 4
with(dataframe, plot(Fulldate,Global_reactive_power, type = "l", xlab="datetime"))

dev.off()