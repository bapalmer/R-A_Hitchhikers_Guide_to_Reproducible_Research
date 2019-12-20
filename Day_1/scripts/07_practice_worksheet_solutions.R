###########################################################################
# 3-day R workshop 
# Day 1
# Morning
# practice_worksheet_solutions.R
###########################################################################

# As you go, fill in this script and run the individual lines of code
# You can save the script and come back to it later for reference

# Vectors -----------------------------------------------------------------

# 1. Create the object x and assign it a value of ten

x <- 10

# 2. Create a numeric atomic vector called all_numbers

all_numbers <- c(1, 2, 3, 4, 5, 6)

# 3. Create a character atomic vector of five firstnames called all_characters

all_characters <- c('John', 'Mary', 'Joan', 'Freddy', 'Paul', '1')

# 4. Create a logical atomic vector called all_logical

all_logical <- c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)

# 5. Convert your numeric vector to a character vector and back to numeric again

some_chars <- as.character(all_numbers)

back_to_nums <- as.numeric(all_characters)

back_to_nums <- as.numeric(some_chars)

# 6. Use ':' to generate a vector containing a sequence of numeric values

lots_nums <- c(3:10, 20:11)

# Functions ---------------------------------------------------------------

# 1. Read the help page about the sample() function
?sample()

# 2. Use a numeric vector you created as the input to the sample function

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
# Hint: Look at the arguments for the mean() function on how to deal with NA values

mean(eg_numeric, na.rm = TRUE)

# Indexing ----------------------------------------------------------------

# Consider the following dataframe 

a_dataframe <- data.frame(num = 1:10,
                           char = rep(c('John', 'Jane', 'Jimmy', 'Joanne', 'Joe'), 2),
                           logi = rep(c(TRUE, FALSE), 5))

# 1. Retrieve the first name in the char column

a_dataframe$char[1]

# 2. Retrieve the last four values in the num column

a_dataframe$num[7:10]

# 3. Use 'subset' to subset the dataframe using 'Jane' as the condition

subset(a_dataframe, char == 'Jane')

# 4. Subset the dataframe for all 'num' greater than six

subset(a_dataframe, num > 6)

# Consider the following list

a_list <- list(nums = c(1, 2, 0.5, -0.5, 3.4), 
               chars = c('One', 'TRUE', '3'), 
               logi = c(TRUE, FALSE))

# 5. Extract the last value of 'chars' from a_list

a_list[[2]][3]

# 6. Multiply the second and fourth values in 'nums' from a_list

a_list[[1]][2] * a_list[[1]][4] 

# Dataframes --------------------------------------------------------------

# 1. Create a dataframe with four columns and five rows
# Column 1: Firstnames
# Column 2: Ages
# Column 3: Gender
# Column 4: A sample of numbers from the normal distribution (rnorm()),
#           with a mean of 2 and a standard deviation of 3

data <- data.frame(firstnames = c('John', 'Mary', 'Joan', 'Freddy', 'Paul'),
                   ages = c(5, 10, 15, 16, 20),
                   gender = c('m', 'f', 'f', 'm', 'm'),
                   nums = sample(rnorm(100, 2, 3), 5, replace = FALSE))
