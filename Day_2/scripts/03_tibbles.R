###########################################################################
# 3-day R workshop 
# Day 2
# Morning
# 03_tibbles.R
###########################################################################

# Load the tidyverse

# library(tidyverse)

# 1. Let's examine the main differences between a data frame and a tibble

example_tbl <- diamonds

# It has been imported as a tibble

# 2. Convert this tibble to a data.frame you might be more familiar with

example_df <- as.data.frame(example_tbl)

# 3. View it in the console by running the following code and note
# any differences between the outputs

example_df

# Tibbles are designed not to overwhelm your console when you print 
# large data frames
# It will print only the first 10 row and the number of columns that
# will fit on your screen

example_tbl

# Also, each column will report its type

# 4. If you want to change this, you can request it explicitly

example_tbl %>%
  print(n = 20, width = Inf) # Inf will print all the columns

# 5. You might find functions from other packages won't work with tibbles
# This is often due to the subsetting operations using '[' function

class(example_tbl[1,1])
class(example_df[1,1])

# This morning we saw how the object type returned can vary
# So with tibbles, '[' always returns another tibble

# If you get into trouble, you can convert the tibble to a data frame

example_tbl_now_a_df <- as.data.frame(example_tbl)

# 6. What's the difference between these two objects?

str(tibble(
  x = 1:5, 
  y = letters[1:5]
))

str(data.frame(
  x = 1:5, 
  y = letters[1:5]
))

# A tibble won't change the input
# Here, data.frame() converted a string to a factor

# 7. A useful function to stop your active environment cluttering up is rm()
# This removes data structures from your workspace

rm(url, example_df, example_tbl, example_tbl_now_a_df)
