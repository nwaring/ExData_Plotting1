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
plot(dt$Global_active_power, ylab='Global Active Power (kilowatts)', type='l', xaxt="n", main='', xlab='')
axis(1,at=c(1, nrows %/% 2, nrows), labels=c('Thu', 'Fri', 'Sat'))

dev.copy(png, "plot2.png", width=480, height=480)
dev.off()

