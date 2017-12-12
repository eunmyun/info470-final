# Load necessary libraries
install.packages("dplyr")
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
ride.per.day$Date <- levels(droplevels(ride.per.day$Date))

weather$Date <- as.Date(weather$Date, "%m/%d/%Y")

weather <- filter(weather, Date <= as.Date("2015-04-17", "%Y-%m-%d"))
weather$rides <- ride.per.day$Rides

everything <- lm(rides ~ Mean_Temperature_F + MeanDew_Point_F + Mean_Humidity + Mean_Sea_Level_Pressure_In + Mean_Visibility_Miles + Mean_Wind_Speed_MPH + Precipitation_In, data=weather)
summary(everything)

four <- lm(rides ~ MeanDew_Point_F + Mean_Humidity + Mean_Wind_Speed_MPH + Precipitation_In, data=weather)
summary(four)

three <- lm(rides ~ Mean_Humidity + Mean_Wind_Speed_MPH + Precipitation_In, data=weather)
summary(three)

two <- lm(rides ~ Mean_Wind_Speed_MPH + Precipitation_In, data=weather)
summary(two)
