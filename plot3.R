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

#make plot 3
png(file="plot3.png")
with(dataframe, plot(Fulldate,Sub_metering_1, type = "l", ylab= "Energy sub metering", xlab=""))
with(dataframe, {lines(Fulldate, Sub_metering_2, col= "red", type="l")
                lines(Fulldate,Sub_metering_3, type = "l", col="blue")
                legend("topright",lty= 1,
                   legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                   col= c("black", "red","blue"))
                })

                
dev.off()