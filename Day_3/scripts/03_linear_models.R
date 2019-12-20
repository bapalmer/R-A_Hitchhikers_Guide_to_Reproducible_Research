###########################################################################
# 3-day R workshop 
# Day 3
# Morning
# 03_linear_models.R
###########################################################################

# Linear model ------------------------------------------------------------
# Forbes (1857) measured the boiling point of water and atmospheric 
# pressure at 17 locations

# The data suggests a linear relationship between the boiling point
# of water in degrees Farenheit (X) and 100*log(Pressure) (Y) 
# Y = β0 + β1X == y = mx + c

# Load packages
library(tidyverse)
library(broom)

# Load the data
bp_df <- read_delim("Day_3/data/forbes.txt", delim = "\t", trim_ws = TRUE)

# 1. Plot the data

ggplot(data = bp_df, aes(x = Boilingpt, y = 100*log(Pressure))) +
  geom_point() +
  labs(x = "Boiling point (°F)",
       y = "110 x log(Pressure)") +
  theme_classic()

# We are testing hypothesis that β1 = 0,
# The alternative hypothesis is that β1 != 0

# 2. Build the linear model

forbes_lm <- lm(100*log10(Pressure) ~ Boilingpt, data = bp_df)

# 3. Plot the data with the fitted line from the model

ggplot(data = bp_df, aes(x = Boilingpt, y = 100*log(Pressure))) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  labs(x = "Boiling point (°F)",
       y = "110 x log(Pressure)") +
  theme_classic()

# 4. Using the '$' operator, we can access individual outputs

forbes_lm$residuals

plot(forbes_lm$residuals)

# The residual for sample number 12 is quite large and will greatly
# inflate the residual sum of squares calculation
# Is this point an outlier, should it be removed?
# Need to consider leverage, influence, Cooks distance :S

# 5. Let's examine the lm output

forbes_lm

summary(forbes_lm)

# 6. Using the tidy() function from the broom package we can 
# collect the important outputs in a data frame 

forbes_lm_df <- tidy(forbes_lm)

forbes_lm_df
