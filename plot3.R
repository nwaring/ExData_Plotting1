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
par(cex=0.75, bg=NA)
plot(dt$Sub_metering_1, type='l', col='black', xaxt="n", main='', xlab='', ylab='Energy sub metering')
lines(dt$Sub_metering_2, type='l', col='red')
lines(dt$Sub_metering_3, type='l', col='blue')
axis(1,at=c(1, nrows %/% 2, nrows), labels=c('Thu', 'Fri', 'Sat'))
legend("topright", legend=tail(names(dt), 3), col=c('black', 'red', 'blue'), lwd=1)

dev.copy(png, "plot3.png", width=480, height=480)
dev.off()

