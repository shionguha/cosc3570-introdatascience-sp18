install.packages("mlbench")
library("mice")

data("BostonHousing", package = "mlbench")
orig_data <- BostonHousing
test_data <- BostonHousing

md.pattern(orig_data)

test_data[sample(1:nrow(test_data), 40), "rad"] <- NA
test_data[sample(1:nrow(test_data), 40), "ptratio"] <- NA

md.pattern(test_data)

summary(test_data)

mean_rad <- mean(test_data$rad, na.rm = TRUE)
mean_rad

mean_ptratio <- mean(test_data$ptratio, na.rm = TRUE)
mean_ptratio

test_data$rad[is.na(test_data$rad)] <- mean_rad
test_data$ptratio[is.na(test_data$ptratio)] <- mean_ptratio

summary(test_data)
summary(orig_data)
