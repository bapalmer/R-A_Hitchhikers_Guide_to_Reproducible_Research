###########################################################################
# 3-day R workshop 
# Day 3
# Morning
# first_reprex.R
###########################################################################

# reprex code -------------------------------------------------------------
# First use the 'datapasta' add-in to grab some data

library(tidyverse)

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

# No include your attempt a getting the answer

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
