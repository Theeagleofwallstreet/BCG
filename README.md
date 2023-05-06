# BCG  


# Power Co Customer Churn Prediction

This repository contains code and data for a customer churn prediction project for Power Co, an electricity company. The goal of this project is to build a machine learning model that can predict which customers are most likely to churn (i.e., stop using Power Co's services), and use that prediction to inform targeted retention efforts.

## Data

The data for this project comes from Power Co's customer database and includes information on customer demographics, usage patterns, and payment history. The dataset includes the following variables:

- `customer_id`: unique identifier for each customer
- `gender`: customer gender (M or F)
- `age`: customer age
- `region`: customer location (region of the country)
- `payment_method`: customer payment method (bank transfer, credit card, or cash)
- `monthly_usage`: average monthly electricity usage
- `months_active`: number of months the customer has been with Power Co
- `churned`: binary variable indicating whether the customer has churned (1) or not (0)

## Code

The code for this project includes data cleaning, exploratory data analysis, and machine learning model building and evaluation. The main code files are:

- `data_cleaning.R`: R script for cleaning and preprocessing the raw data
- `eda.R`: R script for exploratory data analysis and visualization
- `modeling.R`: R script for building and evaluating machine learning models

## Results

The best-performing model was a random forest classifier with an AUC-ROC score of 0.85. This model was used to predict customer churn probabilities, and the results were used to identify the top 10% of customers most likely to churn. A retention campaign was launched targeting these high-risk customers, resulting in a 20% decrease in churn rate over the following quarter.



##License:

This dataset is available under the Creative Commons Attribution 4.0 International (CC BY 4.0) license.
