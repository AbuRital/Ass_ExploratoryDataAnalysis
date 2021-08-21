temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
power <- read.table(unz(temp,"household_power_consumption.txt"), 
                    sep=";", 
                    header = T, 
                    na="?", 
                    colClasses = c("character",
                                   'character',
                                   'numeric',
                                   'numeric',
                                   'numeric',
                                   'numeric',
                                   'numeric',
                                   'numeric',
                                   'numeric'))

unlink(temp)
power <- power[which(power$Date == '2/2/2007' | power$Date=='1/2/2007'),]

power$POSIX <-as.POSIXlt.character(paste(power$Date,power$Time),format = "%d/%m/%Y %H:%M:%S")

#First_Plot
png(filename="First_plot.png",width=480, height=480)
hist(power$Global_active_power, col = 'red', main = 'Global-Active-Power', xlab = 'Global Active Power in(kilowatts)')
dev.off()

#Second_Plot
png(filename="Second_Plot.png",width=480, height=480)
plot(x=power$POSIX ,y=power$Global_active_power, type = 'l', xlab='',ylab = 'Global Active Power in(kilowatts)')
dev.off()

#Third_Plot
png(filename="Third_Plot.png",width=480, height=480)
plot(x=power$POSIX,y=power$Sub_metering_1, type='l', col = 'black', ylab = 'Energy sub metering', xlab = '')
lines(x=power$POSIX,y=power$Sub_metering_2, col='red')
lines(x=power$POSIX,y=power$Sub_metering_3, col='blue')
legend('topright', legend = c('Sub_metering_1',"Sub_metering_2","Sub_metering_3"), col = c('black','red','blue'), lty = 1)
dev.off()

#Fourth_Plot
png(filename="Fourth_Plot.png",width=480, height=480)
par(mfrow=c(2,2))
plot(x=power$POSIX ,y=power$Global_active_power, type = 'l', xlab='',ylab = 'Global-Active-Power')
plot(x=power$POSIX ,y=power$Voltage, type = 'l', xlab='datetime',ylab = 'Voltage')
plot(x=power$POSIX,y=power$Sub_metering_1, type='l', col = 'black', ylab = 'Energy subMetering', xlab = '')
lines(x=power$POSIX,y=power$Sub_metering_2, col='red')
lines(x=power$POSIX,y=power$Sub_metering_3, col='blue')
legend('topright', legend = c('Sub_metering_1',"Sub_metering_2","Sub_metering_3"), col = c('black','red','blue'), lty = 1, bty = "n")
plot(x=power$POSIX ,y=power$Global_reactive_power, type = 'l', xlab='datetime',ylab = 'Global_Reactive_Power')
dev.off()
