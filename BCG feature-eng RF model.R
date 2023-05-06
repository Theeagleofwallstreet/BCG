# load necessary libraries
library(dplyr)
library(randomForest)
library(caret)

# set seed to ensure reproducibility
set.seed(123)

# read in data
price_data <- read.csv("C:/Users/JKFX/Downloads/price_data_power.co.csv")
power_co <- read.csv("C:/Users/JKFX/Downloads/power_co.csv.csv")


# merge datasets
power_price_data <- merge(price_data, power_co, by = "id")

# Split the data into train and test sets
set.seed(123)
train_idx <- sample(1:nrow(power_co), size = round(0.8*nrow(power_co)), replace = FALSE)
train <- power_co[train_idx, ]
test <- power_co[-train_idx, ]



# remove unnecessary columns
power_price_data <- power_price_data %>% select(-c(id, price_date))

# create churn variable
power_price_data$churn <- ifelse(power_price_data$months_active == 1, 1, 0)

# split data into train and test sets
train_index <- createDataPartition(power_price_data$churn, p = 0.8, list = FALSE)
train <- power_price_data[train_index, ]
test <- power_price_data[-train_index, ]

# train random forest classifier
 rf_model <- randomForest(churn ~ ., data=train, classProbs=TRUE)

# make predictions on test set
predictions <- predict(rf_model, test)

# evaluate performance
confusionMatrix(predictions, test$churn)

# calculate discount effect
high_churn_prob_customers <- subset(test, predict(rf_model, test, type = "prob")[,2] > 0.8)
discount_effect <- sum(high_churn_prob_customers$price_off_peak_var * 0.2)
nrow(test)
table(test$churn)



