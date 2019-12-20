###########################################################################
# 3-day R workshop 
# Day 3
# Morning
# practice_worksheet_solutions.R
###########################################################################

# 1. Look up the help for functions

help('function')

# 2. Let's attempt to create a function by writing the code for each stage 
# of the operation we are trying to execute

# Write a function that will identify the largest number from a series of 
# numbers and then multiply it by itself
# i.e c(1:10): Biggest number is 10 so we want 10 x 10

# (i) Start by writing a line of code that will find the largest number in 'nums'

nums <- c(1:59, 63, 99)

largest <- max(nums)
largest

# (ii) And now try it for 'nums_na' as need to assume the presence of NA values

nums_na <- c(1:59, NA, 63, 99)
largest <- max(nums_na)
largest

largest <- max(nums_na, na.rm = TRUE)
largest

# (iii) Then look at how you might multiply this number by itself

largest * largest

# (iv) Wrap the code within a function and run it

largest.sq <- function(x){
  
  if (is.numeric(x)){ # Check that the input is numeric
    largest <- max(x, na.rm = TRUE)
    largest * largest

  } else {
    print('You failed to supply a numeric vector to this function')
  }
} 

# Test it with a numeric vector

largest.sq(nums_na)

# Test it with a character vector

some_chars <- letters[1:10]

largest.sq(some_chars)

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

output_list[1]
output_list[[1]]

typeof(output_list[1])
typeof(output_list[[1]])

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

