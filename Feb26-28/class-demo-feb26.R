library(datasets)
library(mice)
library(VIM)

#Look at IRIS dataset and save it in a dataframe
?iris
rawData <- iris
rawData

marginplot(rawData[, c("Sepal.Length", "Sepal.Width")], pch =20, col = c("red"), cex.numbers = 1.3)

#lm_model <- lm(Petal.Length ~ Petal.Width ,data = rawData)
#summary(lm_model)

#Look at the data summary
summary(rawData)

#Generate 10% missing values at Random 
missing_data <- prodNA(rawData, noNA = 0.1)

#Check missing values introduced in the data
summary(missing_data)

#Look at pattern of missingness
md.pattern(missing_data)

#remove categorical variables
missing_data <- subset(missing_data, select = -c(Species))
head(missing_data)

#Plot the missingness pattern
missingness_plot <- aggr(missing_data, col=c('navyblue','yellow'),
                         numbers=TRUE, sortVars=TRUE,
                         labels=names(missing_data), cex.axis=.7,
                         gap=3, ylab=c("Missing data","Pattern"))

#Plotting margin plot
marginplot(missing_data[, c("Sepal.Length", "Sepal.Width")], col = mdc(1:2), cex.numbers = 1.2, pch = 19)

#Generate complete imputed datasets
imputed_Data <- mice(iris.mis, m=5, maxit = 50, method = 'pmm', seed = 500)
summary(imputed_Data)

#Plotting and comparing values with xyplot()
xyplot(imputed_Data, Sepal.Length ~ Sepal.Width | .imp, pch = 20, cex = 1.4)

#make a density plot
densityplot(imputed_Data)

#check imputed values
imputed_Data$imp$Sepal.Width

#get complete data ( 2nd out of 5)
completeData <- complete(imputed_Data,2)
completeData

#build predictive model
fit <- with(data = imputed_Data, exp = lm(Sepal.Width ~ Sepal.Length + Petal.Width))

#combine results of all 5 models
combine <- pool(fit)
summary(combine)