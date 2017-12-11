# Load necessary libraries
library(dplyr)

# Load CSV files
trip <- read.csv(file='data/trip.csv')
weather <- read.csv(file = 'data/weather.csv')
station <- read.csv(file = 'data/station.csv')

# Prepare data for map
forMap <- select(trip, "from_station_name",'to_station_name', 'from_station_id', 'to_station_id')
station <- select(station, "station_id", "lat", "long")
colnames(station) <- c("from_station_id", "from_lat", "from_long")
forMap <- merge(forMap,station)
colnames(station) <- c("to_station_id", "to_lat", "to_long")
forMap <- merge(forMap,station)
View(forMap)
write.csv(forMap,file = 'data/forMap.csv')

# General trends of gender, age, and member
trip <- mutate(trip, Date = as.Date(starttime, "%m/%d/%Y"))
ride.per.day <- table(trip$Date)
ride.per.day <- as.data.frame(ride.per.day)
colnames(ride.per.day) <- c("Date", "Rides")

hello <- filter(weather, Date %in% ride.per.day$Date)
d <- as.Date(c("08/15/17", "08/16/17", "08/17/17"), "%m/%d/%y")
d <- as.data.frame(d)
f <- as.Date(c("08/15/17", "08/16/17"), "%m/%d/%y")

nrow(weather)
nrow(ride.per.day)
nrow(hello)

