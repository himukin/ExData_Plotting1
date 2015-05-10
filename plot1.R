# Create the dir using that name
if(!file.exists("data")) {
    dir.create("data")
}    
# Unzip the file into the dir
unzip("exdata-data-household_power_consumption.zip", exdir="data")


## Read the full data
all_data <- read.table("data//household_power_consumption.txt",
                       sep=";",na.strings="?",header=TRUE)
## Create new column 'datetime' with the exisiting columns 'Date' & 'Time'
all_data$datetime <- strptime(paste(all_data$Date,all_data$Time),
                              format="%d/%m/%Y %H:%M:%S")

## Update the Date variable with the 'Date' type
all_data$Date <- as.Date(all_data$Date,"%d/%m/%Y")

##carve only the subset which we are interested 
##     i.e. data belonging to the dates 1st  & 2nd of Feb 2007
sub_data <- subset(all_data,Date == as.Date("1/2/2007","%d/%m/%Y") 
                   |  Date == as.Date("2/2/2007","%d/%m/%Y"))

hist(sub_data$Global_active_power,xlab="Global Active Power (kilowatts)",
     col="red",main = "Global Active Power")


## Copy my plot to a PNG file
dev.copy(png, file = "plot1.png")
## Don't forget to close the PNG device!
dev.off()




