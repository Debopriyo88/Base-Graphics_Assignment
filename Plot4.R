library(dplyr)
library(lubridate)
#Read csv file
elec <- read.csv("./data/household_power_consumption.txt", sep = ";",stringsAsFactors=FALSE, na.strings = "?")

#Filter by dates Feb. 1, 2007 to Feb. 2, 2007
myelec <- filter(elec,Date == "1/2/2007" | Date == "2/2/2007")

#Remove incomplete obs
myelec <- myelec[complete.cases(myelec),]

#Convert Date to date type
myelec$Date <- as.Date(myelec$Date,"%d/%m/%Y")

#Add extra DateTime column by concatenating date and time 
myelec <- myelec %>% mutate(DateTime=paste(Date," ",Time))

#Format date time to lubridate 
myelec$DateTime <- ymd_hms(myelec$DateTime)

#Changing characters to numerics
myelec$Sub_metering_1 <- as.numeric(myelec$Sub_metering_1)
myelec$Sub_metering_2 <- as.numeric(myelec$Sub_metering_2)
myelec$Global_active_power <- as.numeric(myelec$Global_active_powe)
myelec$Global_reactive_power <- as.numeric(myelec$Global_reactive_power)

par(mfcol = c(2,2),mar=c(4,4,2,1), oma=c(0,0,2,0))

#1st plot
with(myelec,plot(DateTime,Global_active_power,type = "l",ylab = "Global Active Power(kilowatts)",xlab = ""))

#2nd plot
with(myelec,plot(DateTime,Sub_metering_1,type = "l",ylab = "Energy sub metering",xlab = ""))
with(myelec, points(DateTime,Sub_metering_2,type = "l",col = "red"))
with(myelec, points(DateTime,Sub_metering_3,type = "l",col = "blue"))
legend("topright",col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = "solid",cex = 0.5)

#3rd Plot
with(myelec,plot(DateTime,Voltage,type = "l",ylab = "Voltage",xlab = "datetime"))

#4th plot
with(myelec,plot(DateTime,Global_reactive_power,type = "l",ylab = "Global_reactive_power",xlab = "datetime"))

dev.copy(png,file = "./Base-Graphics_Assignment/plot4.png",width = 480, height = 480, units = "px")
dev.off()