library(ggplot2)

data("diamonds")
head(diamonds)

with(diamonds, hist(price))
#GGPLOT
qplot(price, data=diamonds, color="red")

with(diamonds, plot(carat,price))

#GGPLOT
qplot(carat, price, data=diamonds, color="red")
qplot(price, data=diamonds, geom = "density", fill = "red")

with(diamonds, plot(carat,price, xlab="Weight in carats", ylab="Price in USD", main="Diamonds are expensive!"))
qplot(carat, price, data=diamonds, xlab="Weight in carats", ylab="Price in USD", main="Diamonds are expensive!", color="red")


qplot(carat, price, data=diamonds, facets = color~.)
qplot(carat,price, data=diamonds, facets=clarity~.)


qplot(carat, price, data=diamonds, facets=clarity~color)
