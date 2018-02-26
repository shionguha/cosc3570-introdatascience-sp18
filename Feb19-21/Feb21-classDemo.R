library(mice)
library(VIM)
library(car)

?Prestige
raw_data <- Prestige
head(raw_data)
summary(raw_data)
marginplot(raw_data[, c("education", "income")], pch =20, col = c("red"))

lm_model <- lm(income ~ education ,data = raw_data)
summary(lm_model)

mean(raw_data$income)
#===============================================================================
#introduce NAs in dataset

test_data <- raw_data
test_data[sample(1:nrow(test_data), 30), "education"] <- NA
test_data[sample(1:nrow(test_data), 30), "income"] <- NA

imputed_data <- mice(test_data, m =30, maxit = 40)
imp_1 = complete(imputed_data, 1)

summary(imp_1)
summary(raw_data)
imputed_data$method

#Check the fitness of the imputed data
xyplot(imputed_data, education~income | .imp, pch =20, cex =1.4)
densityplot(imputed_data)

#Create a linear model to fit education and income
lm_imputed <- with(imputed_data, lm(income ~ education))
summary(lm_imputed)

combined_model <- pool(lm_imputed)
summary(combined_model)
