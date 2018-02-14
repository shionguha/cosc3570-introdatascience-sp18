library(tidyverse)
library(reshape2)

#Importing dataset weather.csv
rawData <- read.csv("weather.csv")

#Clear global environment
#rm(list = ls())

names(rawData)[1] <- "id"
names(rawData)[2] <- "year-month"
names(rawData)[3] <- "measurement"
"names(rawData)[-(1:3)] <- str_c("d", 1:31)
"
rawData <- separate(rawData, col = "year-month", into = c("year", "month"), sep = 4)
#raw$year <- str_sub(raw$year-month, 1, 4)
#raw$month <- str_sub(raw$year-month, 5)

#rawData <- subset(rawData, select=c(1, 34, 35, 2, 3:33))

rawData <- subset(rawData, year == 1955)


#MELTING DATA to get all the days under a single column (One column for one variable)

cleanData <- melt(rawData, id = 1:4)

cleanData$day <- as.integer(str_replace(cleanData$variable, "d", ""))
cleanData$date <- as.Date(ISOdate(cleanData$year, cleanData$month, cleanData$day))

cleanData$year <- NULL
cleanData$month <- NULL
cleanData$day<- NULL
cleanData$variable <- NULL

cleanData <- cleanData[c("id", "date", "measurement", "value")]
cleanData <- arrange(cleanData, date, measurement)

cleanData <- na.omit(cleanData, cols="date")

#CASTING DATA

casted_data <- dcast(cleanData, id + date ~ measurement, value.var = "value")
#casted_data <- dcast(cleanData, ... ~ measurement)



