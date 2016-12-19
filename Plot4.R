datafile <- "./household_power_consumption.txt"

## Read the date into a data frame called "data"
data <- read.table(datafile, header=TRUE, sep=";",na.strings = "?")
data$DateTime<-paste(data$Date, data$Time)

## Obtain the timestamps of all the time in the datetime format, this is used for plotting graphs subsequently
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

## Convert the Date into "Date" format which is in "YYYY-MM-DD" format, this is for easy comaprison with the specified date range
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Obtain the subset of data based on the specified date range
newdata <- data[ which((data$Date=="2007-02-01") | (data$Date=="2007-02-02")), ]


plot4 <- function() {
  ##Set the parameter for 2 rows and 2 columns of the plot
  par(mfrow=c(2,2))
  
  ##PLOT 1
  plot(newdata$DateTime,newdata$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  
  ##PLOT 2
  plot(newdata$DateTime,newdata$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  ##PLOT 3
  plot(newdata$DateTime,newdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(newdata$DateTime,newdata$Sub_metering_2,col="red")
  lines(newdata$DateTime,newdata$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) 
  
  #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
  
  #PLOT 4
  plot(newdata$DateTime,newdata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  #Copy the plot into a png device
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
  cat("plot4.png has been saved in", getwd())
  
  ##Set the parameter for 1 rows and 1 columns of the plot
  par(mfrow=c(1,1))
}
plot4()



