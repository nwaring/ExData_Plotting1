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
par(cex=0.75, bg=NA)
hist(dt$Global_active_power, col='red', xlab='Global Active Power (kilowatts)', main='Global Active Power')

dev.copy(png, "plot1.png", width=480, height=480)
dev.off()

