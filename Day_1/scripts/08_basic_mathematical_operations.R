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
# Lets start by creating a numerical vector containing the values 1 to 20

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

# Common data transformations ---------------------------------------------

# Square root

sqrt(x)

# log 

log(x)