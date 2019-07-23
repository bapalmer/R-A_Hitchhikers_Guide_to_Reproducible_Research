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


# 2. Create a numeric atomic vector


# 3. Create a character atomic vector of five firstnames


# 4. Create a logical atomic vector


# 5. Convert your numeric vector to a character vector and back again


# 6. Use ':' to generate a vector containing various numeric values


# Functions ---------------------------------------------------------------

# 1. Read the help page about the sample() function
?sample()

# 2. Use the numeric vector you created as the input to the sample function


# 3. Look and the arguments for sample() and implement some of them
# Look at the examples at the bottom of the help page as a guide
# Do you understand how they all work?
# If not, post a question to the HackMD course page


# 4. Apply the mean(), median, sd(), min(), max() functions to the vector
# Do you understand what they all do?


# 5. Consider the following numeric vector containing missing values

eg_numeric <- c(1:3, NA, 9, NA, 11:34)

# Calculate the mean of this
# Hint: Look at the arguments for the mean() function


# Indexing ----------------------------------------------------------------

# Consider the following dataframe 

a_data_frame <- data.frame(num = 1:10,
                           char = rep(c('John', 'Jane', 'Jimmy', 'Joanne', 'Joe'), 2),
                           logi = rep(c(TRUE, FALSE), 5))

# 1. Retrieve the first name in the char column


# 2. Retrieve the last four values in the nums column


# 3. Subset the dataframe using 'Jane' as the condition


# 4. Subset the dataframe for all 'nums' greater than six


# Consider the following list

a_list <- list(nums = c(1, 2, 0.5, -0.5, 3.4), 
               chars = c('One', 'too', '3'), 
               logi = c(TRUE, FALSE))

# 5. Extract the last value of 'chars' from a_list


# 6. Multiply the second and fourth values in 'nums'



# Dataframes --------------------------------------------------------------

# 1. Create a dataframe with three columns and three rows
# Column 1: Firstnames
# Column 2: Ages
# Column 3: Gender
# Column 4: A sample of numbers from the normal distribution (rnorm()),
#           with a mean of 2 and a standard deviation of 3

