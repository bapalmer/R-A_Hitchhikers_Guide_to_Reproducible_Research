####################################################################
#                     The tidyverse and beyond 
#                            Workshop 7
#                          What's going on
#                       27th November 2017
#                    Worksheet D: Linear models
####################################################################
# Forbes (1857) measured the boiling point of water and atmospheric 
# pressure at 17 locations
# The data suggests a linear relationship between the boiling point
# of water in degree Farenheit (X) and 100*log(Pressure) (Y) 
# Y = β0 + β1X == y = mx + c

# Load packages
library(tidyverse)
library(broom)

# Load the data
bp_df <- read_delim("forbes.txt", delim = "\t", trim_ws = TRUE)

# 1. Plot the data
ggplot(data = bp_df, aes(x = Boilingpt, y = 100*log(Pressure))) +
    geom_point() 

# We are testing hypothesis that β1 = 0,
# The alternative hypothesis is that β1 != 0

# 2. Build the linear model
forbes_lm <- lm(100*log10(Pressure) ~ Boilingpt, data = bp_df)

# 3. Plot the data with the fitted line from the model
ggplot(data = bp_df, aes(x = Boilingpt, y = 100*log(Pressure))) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE)

summary(forbes_lm)

forbes_lm$residuals
plot(forbes_lm$residuals)

# The residual for sample number 12 is quite large and will greatly
# inflate the residual sum of squares calculation
# Is this point an outlier, should it be removed?
# Need to consider leverage, influence, Cooks distance :S

# 4. Using the tidy() function from the broom package we can 
# collect the important outputs in a data frame 
forbes_lm_df <- tidy(forbes_lm)
View(forbes_lm_df)

# Interpretation of the results
# The slope of the line (β1) = 0.8956178
# For every unit increase in boiling point (°F) of water there is a
# 0.8956178 unit increase in the corresponding 100*log(Pressure)

# Multiple R-squared: 0.995
# 99.5% of the variability in the 100*log(Pressure) data is explained
# by the change in boiling point (°F)

# F-statistic:  2962, p-value: < 2.2e-16
# We reject the null hypothesis that H0: β1 = 0 and conclude that 
# boiling point can be used as a predictor of 100*log(Pressure)
