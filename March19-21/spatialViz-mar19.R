#install packages
install.packages("maps")
install.packages("gglot2")

#load GGPlot2
library(ggplot2)
library(datasets)

#GGplot bar graph example
iris

bar <- ggplot(data=iris, aes(x=Species))
bar + geom_bar() + 
  xlab("Species") +  ylab("Count") + ggtitle("Bar plot of Sepal Length")

#Create a basemap with no data
ggplot() + 
  borders(database = "world", colour = "grey60", fill = "grey60") +
  ggtitle("Base Map of the World") +
  xlab("") +
  ylab("") +
  theme(
        panel.background = element_blank(),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank())

#Set working directory
setwd("D:/DataViz")

#Reading movies by country from csv
movies <-read.csv("Movies by Country.csv")
head(movies)

# Create a dot density map
ggplot(
  data = movies) +
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  geom_point(
    aes(
      x = Longitude,
      y = Latitude)) +
  ggtitle("Movies by Country") +
  xlab("") +
  ylab("") +
  theme(
    panel.background = element_blank(),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank())

# Create a contour map
ggplot(
  data = movies) +
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  geom_density2d(
    aes(
      x = Longitude, 
      y = Latitude)) +
  ggtitle("Density of Movies by Country") +
  xlab("") +
  ylab("") +
  theme(
    panel.background = element_blank(),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank())

# Zoom into a map
ggplot(
  data = movies) +
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  coord_cartesian(
    xlim = c(-20, 59), 
    ylim = c(35, 71)) +
  geom_density2d(
    aes(
      x = Longitude, 
      y = Latitude)) +
  ggtitle("Density of Movies by Country") +
  xlab("") +
  ylab("") + 
  theme(
    panel.background = element_blank(),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank())

# Create a level map
ggplot(
  data = movies) +
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  coord_cartesian(
    xlim = c(-20, 59), 
    ylim = c(35, 71)) +
  stat_density2d(
    aes(
      x = Longitude, 
      y = Latitude,
      alpha = ..level..), 
    geom = "polygon",
    fill = "blue") +
  ggtitle("Density of Movies by Country") +
  xlab("") +
  ylab("") +
  labs(alpha = "Density") +
  theme(
    panel.background = element_blank(),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank())

#Read countries from CSV file
countries <-read.csv("Countries.csv")
head(countries)

# Create a bubble map
ggplot(
  data = countries) +
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  geom_point(
    aes(
      colour = "red",
      x = Longitude,
      y = Latitude,
      size = Count)) +
  scale_size_area(
    max_size = 5) + 
  ggtitle("Count of Movies by Country") +
  xlab("") +
  ylab("") +
  labs(size = "Movies") +
  theme(
    panel.background = element_blank(),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank())



# Load map data as dataframe
map <- map_data("world")

# Look at the map data
head(map)

# Load dplyr
library(dplyr)

# Join countries and map data
countries2 <- countries %>%
  left_join(map, 
            by = c("Country" = "region")) %>%
  select(
    Country, 
    Longitude = long, 
    Latitude = lat, 
    Group = group,
    Order = order,
    Count) %>%
  arrange(Order) %>%
  as.data.frame()

#Look at countries2
head(countries2)

# Create a choropleth
ggplot(
  data = countries2) + 
  borders(
    database = "world",
    colour = "grey60",
    fill = "grey90") +
  geom_polygon(
    aes(
      x = Longitude, 
      y = Latitude, 
      group = Group,
      fill = Count), 
    color = "grey60") +
  scale_fill_gradient(
    low = "white",
    high = "red") +
  ggtitle("Count of Movies by Country") +
  xlab("") +
  ylab("") +
  labs(color = "Movies") +
  theme(
    panel.background = element_blank(),
    axis.title.x=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks.x=element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank())


