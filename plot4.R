##set parameters
#input file name
input <- "household_power_consumption.txt"
#delimiter
dlm <- ";"
#NA strings
nastr <- "?"
#specify column classes
cc <- c(rep("character",2),rep("numeric",7))
#dates
d <- c("1/2/2007",
       "2/2/2007")

#output file name
output <- "plot4.png"
#width and height of plot area
w <- 480
h <- 480
#other features
typ <- "l"
ttl <- ""
xlb1 <- ""
xlb2 <- "datetime"

##input
#read the input file
temp <- read.table(file = input,
                   sep = dlm,
                   header = TRUE,
                   na.strings = nastr,
                   colClasses = cc)

##process the data
#find rows with the following dates
dt <- temp[[1]] %in% d
#subset
dat <- temp[dt,c(1:5,7:9)]
dat[[1]] <- as.Date(dat[[1]], format = "%d/%m/%Y")
dat[[9]] <- strptime(paste(dat[[1]],dat[[2]]),
                     format = "%Y-%m-%d %H:%M:%S")
#remove temporary objects
rm(temp, dt)

#shape the data
ESM1 <- dat[,c(9,6)]
names(ESM1)[[2]] <- "Sub_metering"
ESM1[,3] <- "Sub_metering_1"

ESM2 <- dat[,c(9,7)]
names(ESM2)[[2]] <- "Sub_metering"
ESM2[,3] <- "Sub_metering_2"

ESM3 <- dat[,c(9,8)]
names(ESM3)[[2]] <- "Sub_metering"
ESM3[,3] <- "Sub_metering_3"

ESM <- rbind(ESM1, ESM2, ESM3)

#remove ESM1-3
rm(ESM1, ESM2, ESM3)

##output
png(filename = output, width = w, height = h)
par(mfrow=c(2,2))
#plot a time series of "Global Active Power"
plot(dat[[9]],dat[[3]],
     type = typ,
     main = ttl,
     xlab = xlb1,
     ylab = "Global Active Power")
#plot a time series of "Voltage"
plot(dat[[9]],dat[[5]],
     type = typ,
     main = ttl,
     xlab = xlb2,
     ylab = "Voltage")
#plot a time series of "Energy Sub Metering"
with(ESM, plot(ESM[[1]],
               Sub_metering,
               main = ttl,
               xlab = xlb1,
               ylab = "Energy sub mertering",
               type = "n"))
with(subset(ESM, V3=="Sub_metering_1"),
     lines(V9, Sub_metering, col = "black"))
with(subset(ESM, V3=="Sub_metering_2"),
     lines(V9, Sub_metering, col = "red"))
with(subset(ESM, V3=="Sub_metering_3"),
     lines(V9, Sub_metering, col = "blue"))
legend("topright",
       col = c("black",
               "red",
               "blue"),
       lty = c(1,1,1),
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"))
#plot a time series of "Global_reactive_power"
plot(dat[[9]],dat[[4]],
     type = typ,
     main = ttl,
     xlab = xlb2,
     ylab = "Global_reactive_power")
dev.off()