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


plot3 <- function() {
  
  ##plot using base plot
  plot(newdata$DateTime,newdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(newdata$DateTime,newdata$Sub_metering_2,col="red")
  lines(newdata$DateTime,newdata$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
  
  ##Copy the plot into a png device
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
  cat("Plot3.png has been saved in", getwd())
}
plot3()