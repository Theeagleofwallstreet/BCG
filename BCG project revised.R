# Import necessary libraries
library(tidyverse)
library(caret)
library(ggplot2)
library(rsample)
# Load PowerCo dataset

power_co <- read.csv("C:/Users/JKFX/Downloads/power_co.csv.csv")
price_power_co<-read.csv( "C:/Users/JKFX/Downloads/price_data_power.co.csv")



# Replace missing rows with mean of rest of the dataset
power_co <- power_co %>%
  replace_na(list(varied = mean(varied, na.rm = TRUE),
                  nb_prod_act = mean(nb_prod_act, na.rm = TRUE),
                  net_margin = mean(net_margin, na.rm = TRUE),
                  num_years_antig = mean(num_years_antig, na.rm = TRUE)))

# Clean dataset
power_co <- power_co %>%
  filter(!is.na(churn)) %>%
  select(-id)

# Calculate original % of customers that churned
original_churn_percent <- mean(power_co$churn) * 100

# Calculate impact of 20% discount on churn
discount <- 0.2
power_co$price_change <- with(power_co, (forecast_price_energy_peak * discount) / margin_gross_pow_ele)
power_co$price_percent_change <- with(power_co, price_change * 100)
power_co$sales_percent_change <- with(power_co, -discount * 100)
power_co$sales_change <- with(power_co, (forecast_cons_12m * -discount))

# Create a new column indicating if a customer churned after the price change
power_co$churned_after_price_change <- ifelse(power_co$forecast_price_energy_peak - power_co$price_change > power_co$forecast_price_energy_p1_var,
                                              1, 0)

# Calculate new % of customers that churned after price change
new_churn_percent <- mean(power_co$churned_after_price_change) * 100

# Print original and new % of customers that churned
cat("Original % of customers that churned: ", original_churn_percent, "%\n")
cat("New % of customers that churned after price change: ", new_churn_percent, "%\n")

# Plot changes in price and sales
ggplot(power_co, aes(x = churn, y = price_percent_change, color = factor(churned_after_price_change))) +
  geom_boxplot() +
  labs(x = "Churn", y = "% Change in Price") +
  theme_classic()

ggplot(power_co, aes(x = churn, y = sales_percent_change, color = factor(churned_after_price_change))) +
  geom_boxplot() +
  labs(x = "Churn", y = "% Change in Sales") +
  theme_classic()

