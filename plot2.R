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
output <- "plot2.png"
#width and height of plot area
w <- 480
h <- 480
#other features
typ <- "l"
ttl <- ""
xlb <- ""
ylb <- "Global ACtive Power (kilowatts)"

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
GAP <- temp[dt,1:3]
GAP[[1]] <- as.Date(GAP[[1]], format = "%d/%m/%Y")
GAP[[4]] <- strptime(paste(GAP[[1]],GAP[[2]]),
                     format = "%Y-%m-%d %H:%M:%S")
#remove temporary objects
rm(temp, dt)

##output
#plot a time series of "Global Active Power"
png(filename = output, width = w, height = h)
plot(GAP[[4]],GAP[[3]],
     type = typ,
     main = ttl,
     xlab = xlb,
     ylab = ylb)
dev.off()