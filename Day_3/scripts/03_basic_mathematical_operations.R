###########################################################################
# 3-day R workshop 
# Day 3
# Morning
# 03_basic_mathematical_operations.R
###########################################################################

# 1. Basic mathematical operations
# + is addition 

2 + 3

# - is subtraction

8 - 2

# * is multiplication

3 * 2

# / is division 

8 / 2

# ^ will raise to the power

2 ^ 4

# %% give a division remainder  

5 %% 2

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

# 8. Save the output of the test and access the outputs individually

test_output <- t.test(x, mu = 5)

# 9. Generate a series of random numbers

runif(100, min = 1, max = 100)

# This will give us an approximately uniform distribution of numbers

hist(runif(100, min = 1, max = 100))

# 10. If I want us all to generate the same set of numbers we need...

set.seed(1) 
same <- runif(100, min = 1, max = 100)
mean(same)
sd(same)

# 11. Generate random numbers from a normal distribution

rnorm(100, 4, 1) # i.e. 100 numbers, with mean of 4 and sd of 1
hist(rnorm(100, 4, 1))
