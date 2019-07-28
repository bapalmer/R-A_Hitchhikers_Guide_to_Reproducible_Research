###########################################################################
# 3-day R workshop 
# Day 2
# Morning
# 01_correct_the_errors.R
###########################################################################

# Start by loading the tidyverse package using the library() function

library(tidyverse)

# Correct paths to files --------------------------------------------------

# This code worked yesterday, but it won't work today

data <- read_csv("data/bad_habits_data.csv")

# The reason is that the .csv data file is not in your current working
# directory, hence error below

# Rather than having multiples if the same file in different locations
# lets try and direct R to the Day1 data folder
# For now, use the import button and navigate to the file location
# Copy the code identifying the path the the file from the "Code Preview"
# box and use it to load the file

# Out of range indexing ---------------------------------------------------

# As with base R, tidyverse packages come with data we can practise on
# These are loaded when the tidyverse is loaded, but the don't appear in
# our global environment unless we assign them to an object

# Do this now

diamonds <- diamonds

# The diamonds dataset comes in ggplot2 and contains information 
# about ~54,000 diamonds, including the price, carat, color, clarity, cut and
# dimensions of each diamond 

# We're now to go through some examples and correct the errors as we go 

# 1. Inaccurate indexing can throw your code out
# Correct the following for the diamonds (dia_df) data set
# Remember when indexing data sets the syntax is [row number, column number]
# a. Return the first value in the last column
diamonds[1, 11]

# 2. Return the last value in the first column
diamonds[53941, 1]

# 3. Return the first four values for the last four columns
diamonds[1:4, 8:11]

# 4. Return the first and last value of all columns
diamonds[c(1, 53941), ]

# Missing functions -------------------------------------------------------

diamonds %$% 
  cor(price, carat)

# The function %$% is in the magrittr package

# It's very common to get an error message like to one that has appeared below
# It's due to the package containing the function not being loaded

# magrittr is part of the tidyverse, but not one of the 8 core tidyverse
# packages loaded at the start of this session

library(magrittr)

diamonds %$% 
  cor(price, carat)


# Common mistakes ---------------------------------------------------------

# 1. What's the problem here?

View(diamond)

# 2. Correct the issues below

all_chars <- c('This', 'is', 'wrong', 'but', 'why', ?)

all_chars <- c('This', 'is','also' 'wrong', 'but', 'why', '?')

all_chars <- c('What's', 'going', 'on', 'here?')
           
# 3. Spot the error here

View(All_chars)

# 4. And here?

class(all_char[[1])

# 5. # Computers use finite precision arithmetic, therefore all numbers
# are an approximation

# Compare the following results?

1/49*49 == 1

# We can resolve this using the 'near()' function

near(1/49*49, 1)

# Package conflicts -------------------------------------------------------

# There are thousands of R packages and many of them share function names
# Where two packages are loaded you can get conflicts in your code

# The dplyr package has a function called select
# dplyr was loaded when we loaded the tidyverse earlier so lets use it

select(diamonds, carat, cut, clarity)

# The MASS package also has a function called select()
# Run the following lines of code

install.packages("MASS")
library(MASS)

select(diamonds, carat, cut, clarity)

# To avoid this problem we can specifically point to the correct package

dplyr::select(diamonds, carat, cut, clarity)

# We can also unload loaded packaged

detach("package:MASS", unload = TRUE)