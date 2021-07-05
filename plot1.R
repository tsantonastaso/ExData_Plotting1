#Plot 1 - Global Active Power Histogram
#Load data into object, 'data' from online zip file:
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
data <- read.table(unz(temp, "household_power_consumption.txt") , sep = ";", header = TRUE)
unlink(temp)

#subset the data: I first pulled out the rows for the 2 dates requested,
#then I bound them together vertically
data2 <- subset(data, Date == "1/2/2007")
data3 <- subset(data, Date == "2/2/2007")
data1 <- rbind(data2, data3)

#make a single column with date and time together 
#transform the date, in place
#cbind the datetime vector to the front
dt <- with(data1, dmy(Date) + hms(Time))
data1 <- transform(data1, Date = as.Date(Date))
data1 <- cbind(dt, data1)

#go through and transform the rest to numbers, in place
data1 <- transform(data1, Global_reactive_power = as.numeric(Global_reactive_power))
data1 <- transform(data1, Voltage = as.numeric(Voltage))
data1 <- transform(data1, Global_intensity = as.numeric(Global_intensity))
data1 <- transform(data1, Global_active_power = as.numeric(Global_active_power))
data1 <- transform(data1, Sub_metering_1 = as.numeric(Sub_metering_1))
data1 <- transform(data1, Sub_metering_2 = as.numeric(Sub_metering_2))

#check in on the data:
str(data1)

#save a png file
png('plot1.png')
##Construct the histogram:
hist(data1$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
#close the png connection
dev.off()



