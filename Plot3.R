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

#Plot line graph
with(myelec,plot(DateTime,Sub_metering_1,type = "l",ylab = "Energy sub metering",xlab = ""))
with(myelec, points(DateTime,Sub_metering_2,type = "l",col = "red"))
with(myelec, points(DateTime,Sub_metering_3,type = "l",col = "blue"))
legend("topright",col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = "solid",cex = 0.8)
dev.copy(png,file = "./Base-Graphics_Assignment/plot3.png",width = 480, height = 480, units = "px")
dev.off()