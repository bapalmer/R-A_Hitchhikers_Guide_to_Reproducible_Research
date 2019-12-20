###########################################################################
# 3-day R workshop 
# Day 3
# Morning
# a_reproducible_example.R
###########################################################################

# Question: ---------------------------------------------------------------
# When using group_by() %>% summarise()
# "is there a simple way to include a summarise row to the end of
# the output that is ungrouped, (i.e. the totals for the whole sample)?"

# Initial answer: ---------------------------------------------------------
# No, there isn't an easy way that I could find immediately
# My 'hacky' attempt below works, it but isn't very pretty

# Packages
library(tidyverse)

#Load the data and tidy it
tidy_data <- read_csv('Day_2/data/messy_data.csv') %>%
  
  # Select the columns we need
  select(-name, -dob) %>%
  
  # Gather columns work and play
  gather(key = condition, 
         value = value, 
         all_work:no_play) %>%
  
  drop_na()

tidy_summaries <- tidy_data %>%
  
  # Group by the required variables
  group_by(drug, gender, condition) %>% 
  
  summarise(mean = mean(value),
            median = median(value),
            min = min(value),
            max = max(value)) %>%
  
  # Bind rows will bind this output to the following one
  bind_rows(
    
    # This code chunk is contained within the 'bind_rows' function
    tidy_data %>%
      
      # Generate the overall summary values
      mutate(mean = mean(value),
             median = median(value),
             min = min(value),
             max = max(value)) %>%
    
    # We need to know what the structure of the grouped_by tibble first
    # as our overall output format needs to match that
    select(drug, gender, condition, mean:max) %>% # Keep columns of interest
      
      # The same information will be appended to all rows, so just need the first one
      filter(row_number() == 1) %>% 
      
      # Change the values in drug, gender, condition to "overall"
      mutate_at(vars(drug:condition), # The columns to apply the function to 
                list(~ifelse(is.character(.), "overall", .)))
    
    # Above we refered to the column by "." 
    # Refer back to the lecture slide on tibbles to explain why
    
  ) # This bracket closes the bind_rows function call

tidy_summaries

# Reproducible example ----------------------------------------------------
# Let's ask the R community by generating a reprex for Stackoverflow

# install.packages(c("reprex", "datapasta"))

library(reprex)
library(datapasta)

# reprex code -------------------------------------------------------------
# First used the 'datapasta add-in to grab some data

tibble::tribble(
  ~id,       ~drug, ~gender, ~condition, ~value,
    1,   "control",     "f", "all_work",   0.06,
    2, "treatment",     "m", "all_work",   0.42,
    3, "treatment",     "f", "all_work",   0.22,
    5,   "control",     "m", "all_work",   0.38,
    6, "treatment",     "m", "all_work",   0.57,
    7, "treatment",     "f", "all_work",   0.24,
    8,   "control",     "f", "all_work",   0.61,
    1,   "control",     "f",  "no_play",   0.27,
    2, "treatment",     "m",  "no_play",    0.3,
    3, "treatment",     "f",  "no_play",   0.09,
    4,   "control",     "m",  "no_play",   0.84,
    5,   "control",     "m",  "no_play",   0.65,
    6, "treatment",     "m",  "no_play",   0.98,
    7, "treatment",     "f",  "no_play",   0.38
  )

tidy_summaries <- tidy_data %>%
  
  # Group by the required variables
  group_by(drug, gender, condition) %>% 
  
  summarise(mean = mean(value),
            median = median(value),
            min = min(value),
            max = max(value)) %>%
  
  # Bind rows will bind this output to the following one
  bind_rows(
    
    # Now for the overall version
    tidy_data %>%
      
      # Generate the overall summary values
      mutate(mean = mean(value),
             median = median(value),
             min = min(value),
             max = max(value)) %>%
      
      # We need to know what the structure of the 'grouped_by' tibble first
      # as the overall output format needs to match that
      select(drug, gender, condition, mean:max) %>% # Keep columns of interest
      
      # The same information will be appended to all rows, so we just need to retain one
      filter(row_number() == 1) %>% 
      
      # Change the values in drug, gender, condition to "overall"
      mutate_at(vars(drug:condition), 
                list(~ifelse(is.character(.), "overall", .)))
  ) 

# Link --------------------------------------------------------------------

# https://stackoverflow.com/questions/57262084/how-can-i-easily-combine-the-output-of-grouped-summaries-with-an-overall-output


# Offered solution --------------------------------------------------------

# install.packages('hablar')

library(hablar)

funs <- list(mean   = ~mean(.), 
             median = ~median(.), 
             min    = ~min(.), 
             max    = ~max(.))

tidy_summaries <- tidy_data %>% 
  group_by(drug, gender, condition) %>% 
  summarise_at(vars(value), funs) %>% 
  ungroup() %>% 
  bind_rows(., tidy_data %>% summarise_at(vars(value), funs)) %>% 
  #  mutate_if(is.character, ~if_na(., "Overall")) # if_na from hablar
  mutate_all(~replace(., is.na(.), "overall")) #my version

tidy_summaries
