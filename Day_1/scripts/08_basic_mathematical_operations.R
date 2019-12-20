###########################################################################
# 3-day R workshop 
# Day 1
# Morning
# 08_basic_mathematical_operations.R
###########################################################################

# Simple maths ------------------------------------------------------------

# Addition: '+'

4 + 3

# You can also add, subtract, multiply and divide numerical vectors

c(1, 2, 3) + c(-1, -2, -3)

c(1, 2, 3) - c(-1, -2, -3)

c(1, 2, 3) * c(-1, -2, -3)

c(1, 2, 3) / c(-1, -2, -3)

# But they need to be of equal length

c(1, 2, 3, 4) + c(-1, -2, -3)

# To raise a number to the power use '^'
# For example 3 squared

3 ^ 2

# Common functions --------------------------------------------------------
# 1. Lets start by creating a numerical vector containing the values 1 to 20

x <- 1:20

# The length of the vector

length(x)

# The minimum value

min(x)

# The maximum value

max(x)

# The mean

mean(x)

# The median

median(x)

# The range

range(x)

# The variance

var(x)

# Standard deviation

sd(x)

# Standard deviation is equal to the square root of the variance

sd(x) == sqrt(var(x))

# Numbers in brackets are enumerated first
#e.g. A

(3 * 3) - 2
3 * (3 - 2)

# e.g. B

(1 + 1) - ((2 * 1) / (1 + 1)) 
((1 + 1) - (2 * 1)) / (1 + 1) 
(1 + 1) - ( 2 * (1 / 1) + 1) 

# 2. Many of the statistical functions are located in the stats package
# In the R console type stats:: and scroll through some of the options

stats::
  
# 3. Let's create a  vector to look at some straightforward functions
  
x <-  c(70, 800, 1000, 1400, 1500, 2300, 10000, 27000)

hist(x)

# Is x normally distributed?
# We can use Shapiro-Wilks to test our data for normality

shapiro.test(x)

# 4. Where the data isn't normally distributed, you might look to 
# transform the data

log(x) # Take the log of the values in x

log2(x) # Take log to the base 2, the values in x

sqrt(x) # Square root

# 5. What will Shapiro Wilk test tell us about our log transformed data?

shapiro.test(log(x))

hist(log(x))

# 6. Information about the test can be accessed using ?
?t.test

# 7. Run a one sample t-test on x and examine the output

t.test(x, mu = 5)

# 8. Save the output of the test and access the outputs individually using '$'

test_output <- t.test(x, mu = 5)

# 9. Generate a series of random numbers

runif(100, min = 1, max = 100) # The uniform distribution

# This will give us an approximately uniform distribution of numbers

hist(runif(100, min = 1, max = 100))

# 10. Generate random numbers from a normal distribution

rnorm(100, 4, 1) # i.e. 100 numbers, with mean of 4 and sd of 1
hist(rnorm(100, 4, 1))