###########################################################################
# 3-day R workshop 
# Day 2
# Morning
# 05_tidyr.R
###########################################################################
# Packages

# library(tidyverse)

# Let's load some sample messy data

messy_data <- read_csv('Day_2/data/messy_data.csv')

# We'll start by converting 'dob' into day, month and year
# 1. The separate function will generate three new columns based on the 
# input column

messy_data_v1 <- messy_data %>%
  
  separate(dob, 
           c('day', 'month', 'year'), 
           sep = '/')

# 2. Now do the same for the name column. What will your new columns be?
# What will the separator be?

messy_data_v2 <- messy_data_v1 %>%
  
  separate()

# 3a. pivot_longer() takes multiple columns, and gathers them into key-value pairs: 
# i.e. it makes 'wide' data longer
# The orignal column names become observations in one new column and the values 
#associated with these are placed in the second new column
#
# e.g. long_data <- wide_data %>%
#       pivot_longer(names_to = 'new_column_for_names'
#              values_to = 'new_column_for_values',
#              column_1:column_n)

# Use the example code to gather columns 'all_work' and 'no_play' in messy_data

messy_data_v3a <- messy_data %>%
  
  pivot_longer()

# 3b. Rather than naming the columns, you can call on them by their positional number

messy_data_v3b <- messy_data %>%
  
  pivot_longer(names_to = 'condition', 
               values_to = 'value', 
               cols =  3:4)

# However if the column order changes, the output will be incorrect
# Better to specify the column names

# 3. What is the result of the following?

messy_data_v3a == messy_data_v3b

# 4. Missing data is a big problem in data analysis and requires careful consideration
# We'll talk about it in more detail later
# For now, lets just remove those rows with missing data using drop_na()

messy_data_v3_na <- drop_na(messy_data_v3a)

# drop_na() - will remove whole rows containing an NA value
# This is useful if your data does not contain much missing information
# but if there are a lot of NAs, you will remove a lot of useful data too

# Including the "na.rm = TRUE" argument within functions is another option

# 5. To reverse some of the actions above, we can use the functions 'unite'
# and 'pivot_wider'
# unite() collapses cells across the columns selected to give a single column 
# Lets reverse our 'dob' action from section 1

messy_data_dob <- unite(data, 
                        columns_to_be_combined, 
                        col = 'new_column_name', 
                        sep = ' - ')

# 6. 'pivot_wider' will essentially make long data wide
# Use spread() to reverse what you did in section 2

messy_data_wide <- messy_data_v3b %>%
  
  pivot_wider(names_from = condition,
              values_from = value)

# 7. Here's an example of creating a continuous code chunk

# Load the data
tidy_data <- read_csv('Day_2/data/messy_data.csv') %>%

  # Separate name column
  separate(name,
           c('firstname', 'surname'),
           sep = ' ') %>%
  
  # Gather columns 'all_work' and 'no_play'
  pivot_longer(names_to = 'condition', 
               values_to = 'value', 
               cols = all_work:no_play)
              # Or... cols = c('all_work', 'no_play'))

# 8. How do we manipulate NA values if they are present?

na_rows <- tidy_data %>% 
  
  # If the data is a data frame use a named list
  replace_na(list(value = list("unknown"))) 

# 9. Other useful tidyr functions:
# complete() - takes a set of columns and finds all unique combinations
# It ensures the original data set has all combinations by filling them with NA

# fill() - Somethings values are missing as the value is carried forward, just not entered
# Fill will replace empty cells with the most recent non-missing value

# 10. NOTE: Earlier versions of tidyr package contained functions 'gather' and 'spread'
# Users found the use of these unintuitive
# 'pivot_longer' and 'pivot_wider' are the replacement versions