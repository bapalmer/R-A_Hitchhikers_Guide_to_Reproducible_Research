# Question asked:
# "When using the following code" - is there a simple way to include 
# a summarise row to the end of the output that is ungrouped 
# (i.e. the totals for the whole sample)?

# Ans: NO, there isn't an easy way that I could find immediately
# My 'hacky' attempt below works, it but isn't very pretty

#Load the data and tidy it
tidy_data <- read_csv('Day_2/data/messy_data.csv') %>%
  
  # Select the columns we need
  select(-name, -dob) %>%
  
  # Gather columns work and play
  gather(key = condition, 
         value = value, 
         work:play) %>%
  
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
                funs(ifelse(is.character(.), "overall", .)))
    
    # Above we refered to the column by "." 
    # Refer back to the lecture slide on tibbles to explain why
    
  ) # This bracket closes the bind_rows function call

tidy_summaries
      
     
      
