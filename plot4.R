library(data.table)

setwd('~/data_science_specialization/ExData_Plotting1/')

get.data <- function(){
  dt <- fread('../household_power_consumption.txt', na.strings=c('?'))
  dt <- dt[grep("^[12]/2/2007", Date)]    # remove all but relevant data rows
  tonumeric <- names(dt)[-(1:2)]          # get column names to convert
  dt[,tonumeric] <- dt[,lapply(.SD, as.numeric), .SDcols=tonumeric]  # convert to numeric classes
  return(dt)
}


dt <- get.data()
nrows <- nrow(dt)
xlabels <- c('Thu', 'Fri', 'Sat')
png("plot4.png", width=480, height=480)
par(mfrow=c(2, 2), cex=0.75, bg=NA)

with(dt, {
  #top left
  plot(Global_active_power, ylab='Global Active Power', type='l', xaxt="n", main='', xlab='')
  axis(1, at=c(1, nrows %/% 2, nrows), labels=xlabels)

  #top right
  plot(Voltage, ylab='Voltage', type='l', xaxt="n", main='', xlab='datetime')
  axis(1, at=c(1, nrows %/% 2, nrows), labels=xlabels)

  # bottom left
  plot(Sub_metering_1, type='l', col='black', xaxt="n", main='', xlab='', ylab='Energy sub metering')
  lines(Sub_metering_2, type='l', col='red')
  lines(Sub_metering_3, type='l', col='blue')
  axis(1,at=c(1, nrows %/% 2, nrows), labels=xlabels)
  legend("topright", legend=tail(names(dt), 3), col=c('black', 'red', 'blue'), lwd=2, bty='n')

  # bottom right
  plot(Global_reactive_power, ylab='Global_reactive_power', type='l', xaxt="n", main='', xlab='datetime')
  axis(1, at=c(1, nrows %/% 2, nrows), labels=xlabels)
})

dev.off()
