library(tidyverse)
library(DoubleML)

file_url <- "https://raw.githubusercontent.com/py-why/EconML/refs/heads/data/datasets/Pricing/pricing_sample.csv"
df <- read_csv(file_url)
glimpse(df)

# Define estimator inputs
Y = df["demand"]  # outcome of interest
T = df["price"]  # intervention, or treatment
X = df["income"]  # features
W = select(df, -c("demand", "price", "income"))  # confounders

# price elasticity of demand
ggplot(data = df, aes(y = demand, x = income))  +
    geom_point(col = 'blue') + 
    geom_smooth(method = 'lm', col = 'red', size = 0.5)

mod_elast_ing <- lm(log(demand) ~ log(income), data = df)
summary(mod_elast_ing)

# predict
ingresos_pred <- seq(0, 5, 0.01)
elast_pred <- predict(mod_elast_ing, newdata = data.frame(income = ingresos_pred))
plot(ingresos_pred, elast_pred, type = "l")
