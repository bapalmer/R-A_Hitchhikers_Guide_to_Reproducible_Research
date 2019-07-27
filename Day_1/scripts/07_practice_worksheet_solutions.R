###########################################################################
# 3-day R workshop 
# Day 1
# Morning
# 03_practice_worksheet.R
###########################################################################

# As you go, fill in this script and run the individual lines of code
# You can save the script and come back to it later for reference

# Vectors -----------------------------------------------------------------

# 1. Create the object x and assign it a value of ten

x <- 10

# 2. Create a numeric atomic vector

some_nums <- c(1, 2, 3, 4, 5, 6)

# 3. Create a character atomic vector of five firstnames

firstnames <- c('John', 'Mary', 'Joan', 'Freddy', 'Paul')

# 4. Create a logical atomic vector

true_false <- c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)

# 5. Convert your numeric vector to a character vector and back again

some_chars <- as.character(some_nums)

back_to_nums <- as.numeric(some_chars)

# 6. Use ':' to generate a vector containing various numeric values

lots_nums <- c(3:10, 20:11)

# Functions ---------------------------------------------------------------

# 1. Read the help page about the sample() function
?sample()

# 2. Use the numeric vector you created as the input to the sample function

sample(lots_nums, 4)

# 3. Look and the arguments for sample() and implement some of them
# Look at the examples at the bottom of the help page as a guide
# Do you understand how they all work?
# If not, post a question to the HackMD course page

sample(lots_nums, 6, replace = FALSE) # i.e. sample without replacement

# 4. Apply the mean(), median, sd(), min(), max() functions to the vector
# Do you understand what they all do?

mean(lots_nums)
median(lots_nums)
sd(lots_nums)
min(lots_nums)
max(lots_nums)

# 5. Consider the following numeric vector containing missing values

eg_numeric <- c(1:3, NA, 9, NA, 11:34)

# Calculate the mean of this
# Hint: Look at the arguments for the mean() function

mean(eg_numeric, na.rm = TRUE)

# Indexing ----------------------------------------------------------------

# Consider the following dataframe 

a_data_frame <- data.frame(num = 1:10,
                           char = rep(c('John', 'Jane', 'Jimmy', 'Joanne', 'Joe'), 2),
                           logi = rep(c(TRUE, FALSE), 5))

# 1. Retrieve the first name in the char column

a_data_frame$char[1]

# 2. Retrieve the last four values in the num column

a_data_frame$num[7:10]

# 3. Subset the dataframe using 'Jane' as the condition

subset(a_data_frame, char == 'Jane')

# 4. Subset the dataframe for all 'nums' greater than six

subset(a_data_frame, num > 6)

# Consider the following list

a_list <- list(nums = c(1, 2, 0.5, -0.5, 3.4), 
               chars = c('One', 'too', '3'), 
               logi = c(TRUE, FALSE))

# 5. Extract the last value of 'chars' from a_list

a_list[[2]][3]

# 6. Multiply the second and fourth values in 'nums'

a_list[[1]][2] * a_list[[1]][4] 

# Dataframes --------------------------------------------------------------

# 1. Create a dataframe with three columns and three rows
# Column 1: Firstnames
# Column 2: Ages
# Column 3: Gender
# Column 4: A sample of numbers from the normal distribution (rnorm()),
#           with a mean of 2 and a standard deviation of 3

data <- data.frame(firstnames = c('John', 'Mary', 'Joan', 'Freddy', 'Paul'),
                   ages = c(5, 10, 15, 16, 20),
                   gender = c('m', 'f', 'f', 'm', 'm'),
                   nums = sample(rnorm(100, 2, 3), 5, replace = FALSE))
