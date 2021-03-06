###########################################################################
# 3-day R workshop 
# Day 3
# Morning
# 04_practice_worksheet.R
###########################################################################

# 1. Look up the help for functions

help('function')

# 2. Let's attempt to create a function by writing the code for each stage 
# of the operation we are trying to execute

# Write a function that will identify the largest number from a series of 
# numbers and then multiply it by itself
# i.e c(1:10): Biggest number is 10 so we want 10 x 10

# (i) Start by writing a line of code that will find the biggest number in 'nums'

nums <- c(1:59, 63, 99)

# (ii) And now try it for 'nums_na'

nums_na <- c(1:59, NA, 63, 99)

# (iii) Then look at how you might multiply this number by itself

# (iv) Wrap the code within a function and run it

# 3. Conditional execution
# Write a function that evaluates the numeric input as positive or negative
# Print out a confirmation message whether the number is positive/negative

num.test <- function(x){
  
}

# 4. Use num.test to evaluate the following vectors

num.test(4)
num.test(-3)
num.test(0)

# 5. Write a for loop to get the mean of every column of mtcars
# Recall: mtcars is one of the data sets that comes with the tidyverse

mtcars <- mtcars

output <- vector('numeric', 11)

# 6. You might want to modify and existing object using a for loop
# Recall our function rescale.01

# rescale.01 <- function(x){ # Informative name
#   
#   rng <- range(x, na.rm = TRUE) 
#   (x - rng[1]) / (rng[2] - rng[1])
#   
# } 

# Let's regenerate our data frame

df2 <- tibble(
  e = sample(1:10, 10, replace = TRUE),
  f = sample(1:100, 10, replace = TRUE),
  g = sample(1:1000, 10, replace = TRUE),
  h = sample(1:10000, 10, replace = TRUE))

# Now we apply a for loop to rescale the data frame

# 7. Want some more practice? ---------------------------------------------
# Create a customised function called area to calculate the area of a circle,
# given the radius r 
# Hint: the formula for the area of a circle is pi * r^2
# 'pi' is a built-in constant in R

# 8. One more -------------------------------------------------------------
# Write a function called statistics that calculates the mean, median, and 
# standard deviation of a vector of numbers 

