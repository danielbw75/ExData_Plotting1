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

#make plot 2
png(file="plot2.png")
with(dataframe, plot(Fulldate,Global_active_power, type = "l", ylab= "Global Active Power (kilowatts)", xlab=""))
dev.off()