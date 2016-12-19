
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


plot1 <- function() {
  
  ##Plot the histogram
  hist(newdata$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
  
  ##Copy the histogram into a png device
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  cat("Plot1.png has been saved in", getwd())
}
plot1()