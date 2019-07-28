###########################################################################
# 3-day R workshop 
# Day 2
# Morning
# 06_dplyr.R
###########################################################################
# dplyr is loaded when the tidyverse package is called

# library(tidyverse)

# 1. Let's recreate our tidy_data from the last script

# Load the data
tidy_data <- read_csv('Day_2/data/messy_data.csv') %>%
  
  # Separate name column
  separate(name,
           c('firstname', 'surname'),
           sep = ' ') %>%
  
  # Gather columns work and play
  gather(key = condition, 
         value = value, 
         work:play)

View(tidy_data)
colnames(tidy_data)

# 2. We can keep or remove columns using 'select()'
# Let's get rid of it using select()

tidy_data %>%
  
  select(-firstname, -surname) 
  # A minus sign in front of the column signifies removal

# Note: 
# Should column names include spaces you'll need to use back ticks (``)

# Example:
# separate(crappy column name, ... would throw an error
# separate(`crappy column name`, ... would solve this

# 3a. We can use the 'filter()' function to filter the informations we need

tidy_data %>%
  
  filter(gender == 'f')

# 3b. Repeat this using a logical operator

tidy_data %>%
  
  filter()

# 3c. Repeat this '!' for not

tidy_data %>%
  
  filter()

# 4. Some mutate() examples
# Currently our 'dob' column is a character vector
# Using the lubridate package we can convert it into a 'data' vector

tidy_data <- tidy_data %>% # We will overwrite the tidy_data here
  
  mutate(percent = value * 100, # We are creating a new column here
         
         # gender should be a factor
         gender = as_factor(gender)) # Matching brackets
         # We are overwriting the gender column

# 5. group_by() allows actions to be performed by group

tidy_group <- tidy_data %>%
  
  group_by(drug, gender, condition)

# Note that the tibble type has changed
# We can undo this action using 'ungroup'

tidy_group <- ungroup(tidy_group)

# Not very much happened there except that the tibble is
# now a grouped_df
# The power of group_by is realised in combination with summarise()

# 6. summarise() reduces multiple values down to a single summary
# Lets make some use of our grouped data

tidy_group <- tidy_data %>%
  
  drop_na() %>% # Lets remove the NA vals for convienence
  
  group_by(drug, gender, condition) %>%
  
  summarise(mean = mean(value),
            median = median(value),
            min = min(value),
            max = max(value))

# 7. Joins
# Lots of options: left_join(), right_join(), full_join()

new_data <- tibble(id = 1:8,
                   location = c('cork', 'cork', 'kerry', 'kerry',
                                'cork', 'cork', 'dublin', 'dublin'))

joined_data <- full_join(tidy_data,
                         new_data,
                         by = 'id')

# 8. Other useful dplyr functions:
# arrange()
# rename
# bind_rows()
# bind_cols

# 8. Some useful helper functions
# vars()
# everything()
# contains()
# n()
