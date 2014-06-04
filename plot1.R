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
output <- "plot1.png"
#width and height of plot area
w <- 480
h <- 480
#other features
cl <- "red"
ttl <- "Global Active Power"
xlb <- "Global ACtive Power (kilowatts)"

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
GAP <- temp[dt,c(1,3)]
#remove temporary objects
rm(temp, dt)

##output
#plot a histgram of "Global Active Power"
png(filename = output, width = w, height = h)
hist(GAP[[2]],
     col = cl,
     main = ttl,
     xlab = xlb)
dev.off()