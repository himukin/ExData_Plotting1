# Create the dir using that name
if(!file.exists("data")) {
    dir.create("data")
}    
# Unzip the file into the dir
unzip("exdata-data-household_power_consumption.zip", exdir="data")

## first read the header info only
header <- read.table("data//household_power_consumption.txt", nrows = 1, 
                     header = FALSE, sep =';', stringsAsFactors = FALSE)
## read only rows relevant to the plot
subset_data <- read.table("data//household_power_consumption.txt",sep=";",
                          na.strings="?",skip=66637,nrows=2880)
## now assign the header names as column names
colnames( subset_data ) <- unlist(header)

## Create new column 'datetime' with the exisiting columns 'Date' & 'Time'
subset_data$datetime <- strptime(paste(subset_data$Date,subset_data$Time),
                                 format="%d/%m/%Y %H:%M:%S")

## start plotting in a PNG grDevice
png("plot4.png",width     = 3.25,
    height    = 3.25,
    units     = "in",
    res       = 1200,
    pointsize = 4
)

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

## first plot
plot(subset_data$datetime, subset_data$Global_active_power,
     ylab="Global Active Power (kilowatts)",xlab="", type="n")
lines(subset_data$datetime, subset_data$Global_active_power)

## second plot
with(subset_data,plot(datetime,Voltage,type="n"))
with(subset_data,lines(datetime,Voltage))

## Third Plot
plot(subset_data$datetime, subset_data$Sub_metering_1,
     ylab="Energy sub metering",xlab="", type="n")
lines(subset_data$datetime, subset_data$Sub_metering_1)
lines(subset_data$datetime, subset_data$Sub_metering_2,col="red")
lines(subset_data$datetime, subset_data$Sub_metering_3,col="blue")

legend("topright", lty=1, cex = 0.7, col = c("black","red", "blue"), 
       legend = c("Sub_metering_1", 
                  "Sub_metering_2",
                  "Sub_metering_3"))

## fourth plot
with(subset_data,plot(datetime,Global_reactive_power,type="n"))
with(subset_data,lines(datetime,Global_reactive_power))


## Don't forget to close the PNG device!
dev.off()