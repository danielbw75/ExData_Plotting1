library(dplyr)
#select colnames
dir<-paste(getwd(),"household_power_consumption.txt",sep="/")
names<-names(read.table(dir,header = TRUE , sep= ";", nrow=1))

#open file
dataframe<-read.table(dir, na.strings = "?", sep=";", skip=24*60*45, nrow=24*60*60, col.names = c(names))
dataframe<-filter(dataframe, Date=="1/2/2007" | Date=="2/2/2007")

#make plot 1
png(file="plot1.png")
hist(dataframe$Global_active_power,ylim= c(0,1200) , main= "Global Active Power", col="red", xlab = "Global Active Power (kilowatts)")
dev.off()