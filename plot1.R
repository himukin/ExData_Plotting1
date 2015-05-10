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
png("plot1.png",width = 480, height = 480)


hist(subset_data$Global_active_power,xlab="Global Active Power (kilowatts)",
     col="red",main = "Global Active Power")


## Don't forget to close the PNG device!
dev.off()




