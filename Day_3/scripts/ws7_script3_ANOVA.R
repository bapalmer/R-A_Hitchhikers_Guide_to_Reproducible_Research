####################################################################
#                     The tidyverse and beyond 
#                            Workshop 7
#                          What's going on
#                       27th November 2017
#               Worksheet C: Analysis of variance
####################################################################
# Load the tidyverse
library(tidyverse)
library(broom)

# ANOVA seeks to look at the difference between group means
# In this example there is a response variable examined under three
# explanatory variable conditions (namely soil composition)

# Load the soil data and examine the data
soil_df <- read_csv("soil_data.csv")

# We have an experiment in which crop yields per unit area were measured
# from 10 randomly selected fields on each of the three soil types

# Hypothesis to be tested:
# H0: the mean crop yields on each soil type are equal i.e. μ₁=μ₂=μ₃
# HA: at least one of the mean crop yields on each soil type are not equal
# We will test this assumption at the 5% significance level so α = 0.05

# Let's uses the tidyverse to help us out
soil_gr <- soil_df %>%
    gather(key = "soil", value = "yield") %>%
    group_by(soil)

summarise(soil_gr, mean = mean(yield))
ggplot(data = soil_gr, aes(x = soil, y = yield)) +
    geom_boxplot()

# 1. When using ANOVA on a data set we should check that the
# following assumptions hold:
# A. random sampling
# B. variances of different treatments are equal
# C. the error terms are independent from observation to observation
# D. the error terms are normally distributed with zero mean and the
# same variance

# 1. We can check the difference in variances a number of ways
# var.test(), fligner.test(), bartlett.test()
bartlett.test(soil_gr$yield~factor(soil_gr$soil))

# 2. Build the model using the aov() function
# aov(y ~ x)
# y is your response variable (dependent)
# x is your explanatory variable (independent)

soil_aov <- aov(soil_gr$yield ~ soil_gr$soil)

# Examine how the output is displayed in the global environment 

# 3. We can retrive the output using summary()
summary(soil_aov)

# 4. Many other outputs are available using $
# Examine some of them

# 5. Using the tidy() function from the broom package we can 
# collect the important outputs in a data frame 
soil_aov_df <- tidy(soil_aov)

