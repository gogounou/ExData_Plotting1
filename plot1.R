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
dataframe <- read.csv(datafile, header=TRUE, sep=";",
                      stringsAsFactors=FALSE, na.strings="?",
                      colClasses=c(rep("character", 2), rep("numeric",7)))

## Subset the dataframe to include only 2007-02-01 and 2007-02-02
dataframe <- dataframe[dataframe$Date == "1/2/2007" | dataframe$Date == "2/2/2007", ]

## Create the plot
png(filename="plot1.png", width=480, height=480)
hist(dataframe$Global_active_power, col = "red",
     main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()