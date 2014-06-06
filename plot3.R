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
output <- "plot3.png"
#width and height of plot area
w <- 480
h <- 480
#other features
typ <- "l"
ttl <- ""
xlb <- ""
ylb <- "Energy sub metering"

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
ESM <- temp[dt,c(1,2,7:9)]
ESM[[1]] <- as.Date(ESM[[1]], format = "%d/%m/%Y")
ESM[[6]] <- strptime(paste(ESM[[1]],ESM[[2]]),
                     format = "%Y-%m-%d %H:%M:%S")
#remove temporary objects
rm(temp, dt)

#shape the data
temp1 <- ESM[,c(6,3)]
names(temp1)[[2]] <- "Sub_metering"
temp1[,3] <- "Sub_metering_1"

temp2 <- ESM[,c(6,4)]
names(temp2)[[2]] <- "Sub_metering"
temp2[,3] <- "Sub_metering_2"

temp3 <- ESM[,c(6,5)]
names(temp3)[[2]] <- "Sub_metering"
temp3[,3] <- "Sub_metering_3"

temp <- rbind(temp1, temp2, temp3)

#remove ESM
rm(ESM)

##output
#plot a time series of "Energy Sub Metering"
png(filename = output, width = w, height = h)
with(temp, plot(temp[[1]],
                Sub_metering,
                main = ttl,
                xlab = xlb,
                ylab = ylb,
                type = "n"))
with(subset(temp, V3=="Sub_metering_1"),
     lines(V6, Sub_metering, col = "black"))
with(subset(temp, V3=="Sub_metering_2"),
     lines(V6, Sub_metering, col = "red"))
with(subset(temp, V3=="Sub_metering_3"),
     lines(V6, Sub_metering, col = "blue"))
legend("topright",
       col = c("black",
               "red",
               "blue"),
       lty = c(1,1,1),
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"))
dev.off()