###########################################################################
# 3-day R workshop 
# Day 3
# Morning
# 06_practice_worksheet_solutions.R
###########################################################################

# 1. Look up the help for functions

help('function')

# 2. Let's attempt to create a function
# Write a function that will identify the largest number
# from a series of numbers and then multiply it by itself

# (i) Start by writing a line of code that will find the biggest number

# (ii) Then look at how you might multiply this number by itself

# (iii) Do you need to plan ahead for potential NA's?

# (iv) Test it out on some numeric vectors

# (v) Place the code in a function, give the function a name and run it

# Numeric vector

some_nums <- c(1:59, NA, 63, 99)
some_chars <- letters[1:12]

big.sq <- function(x){
  
  if (is.numeric(x)){ # Check the input
    biggest <- max(x, na.rm = TRUE)
    biggest * biggest

  } else {
    print('You failed to supply a numeric vector to this function')
  }
} 

big.sq(some_nums)

big.sq(some_chars)

# 3. Conditional execution
# Write a function that evaluates the numeric input as positive or negative
# Print out a confirmation message whether the number is positive/negative

num.test <- function(x){
  
  if (x < 0) {
    print('The number is negative')
    
  } else if (x > 0) {
    print('The number is positive')
    
  }  else {
    print('The number is zero')
  }
}

# 4. Use num.test to evaluate the following vectors

num.test(4)
num.test(-3)
num.test(0)

# 5. Write a for loop to get the mean of every column of mtcars
# Recall: mtcars is one of the data sets that comes with the tidyverse

mtcars <- mtcars

output <- vector('numeric', 11)
output_list <- list()

for (i in 1:ncol(mtcars)){
  
  output[[i]] <- mean(mtcars[[i]], na.rm = TRUE)
  
  output_list[[i]] <- mean(mtcars[[i]], na.rm = TRUE)
  names(output_list[[i]]) <- colnames(mtcars[i])
  
}

# Note the difference

output
output_list

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

for (i in colnames(df2)){
  df2[i] <- rescale.01(df2[[i]]) # Note the '[' usage
  
}

# 7. Want some more practice? ---------------------------------------------
# Create a customised function called area to calculate the area of a circle,
# given the radius r 
# Hint: the formula for the area of a circle is pi * r^2

area <- function(r){
  pi*(r^2)
}

# Check using a simple radius input
area(10)

# Check using multiple radius inputs

area(c(3.1, 4.6, 9.9))

# 8. One more -------------------------------------------------------------
# Write a function called statistics that calculates the mean, median, and 
# standard deviation of a vector of numbers 

statistics <- function(x){
  c(mean(x), median(x), sd(x))
}

statistics(c(1:10, 14, 20, 100))

