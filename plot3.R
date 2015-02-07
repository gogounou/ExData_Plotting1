## Check if zip file is already downloaded. If not download to working directory.
zipfile <- "household_power_consumption.zip"
if (!file.exists(zipfile)) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      destfile=zipfile, method="curl")
}

## Unzip the file
datafile <- "household_power_consumption.txt"
unzip(zipfile, datafile)

## Read the unzipped text file
dataframe <- read.csv(datafile, header=TRUE,
                    sep=";", stringsAsFactors=FALSE, na.strings="?",
                    colClasses=c(rep("character", 2), rep("numeric",7)))

## Subset the dataframe to include only 2007-02-01 and 2007-02-02
dataframe <- dataframe[dataframe$Date == "1/2/2007" | dataframe$Date == "2/2/2007", ]

## Add new field combining both Date and Time, formatted as dd/mm/yyyy hh:mm:ss
dataframe$DateTime <- strptime(paste(dataframe$Date, dataframe$Time),
                               "%d/%m/%Y %H:%M:%S")

## Create the plot
png(filename="plot3.png", width=480, height=480)
plot(dataframe$DateTime, dataframe$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(dataframe$DateTime, dataframe$Sub_metering_2, col="red")
lines(dataframe$DateTime, dataframe$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=1)
dev.off()