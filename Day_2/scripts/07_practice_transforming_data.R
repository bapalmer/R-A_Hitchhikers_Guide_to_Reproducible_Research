#########################################################################
# 3-day R workshop 
# Day 2
# Morning
# 07_practice_transforming_data.R
#########################################################################
# Lets take what we've seen so far and apply it to the example RNA data

# Loading data ------------------------------------------------------------

# library(tidyverse)

messy_data <- read_csv('Day_2/data/rna_data.csv')

# 1. Ensure the data is loaded correctly

View(messy_data)

# 2. Examine the column names to inform the following steps

colnames(messy_data)

# 3. Explore the content of the columns
# e.g.

table(messy_data$GWEIGHT)
unique(messy_data$GWEIGHT)

# select() ----------------------------------------------------------------

# Use the select function to remove columns GID, YORF, and GWEIGHT

data_v1 <- messy_data %>%
  
  select()

# pivot_longer() ----------------------------------------------------------

# 3. Use 'pivot_longer' to gather the columns starting at G0.05 to G0.3
# Call the key column 'nutrient' and the value column 'rate'
# Include the argument na.rm = TRUE

data_v2 <- data_v1 %>%
  
  pivot_longer('Can you remember what arguments to add here?') 

# separate() --------------------------------------------------------------

# 4a. Use separate() on the 'NAME' column
# What separator argument will you use (sep = ?)
# How many columns will be returned?
# What names will you give them?
# Hint: The data dictionary comes in useful here
# c('gene_name', 'biological_process', 'molecular_function', 
#   'public_id', 'additional_id')

data_v3 <- data_v2 %>%

  separate('column to be separated',
           c('put', 'new', 'column', 'names', 'here'),
           sep = '\\|\\|') # I'll explain why if/when you ask me!!

# 4b. Separate on the nutrient column into c('glucose', 'concentration')

data_v4 <- data_v3 %>%
  
  separate() # Hint: You can separate by one character by using sep = 1

# Reality check: data_v4 should contain 33222 rows and 8 columns

# mutate() ----------------------------------------------------------------

# 5. Create a new unique 'id' column using mutate
# Hint: 1:33222 will give a continuous sequence from 1 to 33222

data_v4 <- data_v4 %>%
  
  mutate()

# We'll reorder our data slightly now

data_v4 <- data_v4 %>%
  
  select(id, everything()) # Just reordering the columns here so 'id' is first
                           # 'everything' is a helper function mentioned previously

# 6. Check for NA values in the 'rate' column (if you called it rate in step 3)

table(is.na(data_v4$rate))

# 7. Identify the rows containing these NAs

na_rows <- which(is.na(data_v4$rate)) # Identifies the NA entries in 'rate'

na_rows # These are row numbers that should match your unique 'id' column

# We can remove them as follows...

data_v5 <- data_v4 %>%

  filter(!(id %in% na_rows)) # Keep rows not in the 'na_rows' vector
  
table(is.na(data_v5$rate)) 

# The data should now comprise of 33144 rows

# 8. NOTE: When we separated our columns, we probably generated whitespace
# To avoid this giving us problems later we need to remove it

data_v5 <- data_v5 %>%

  mutate_at(vars(id:values), # The columns to apply the function to 
            list(trimws)) 

# Note to self - Warning message:
#                funs() is soft deprecated as of dplyr 0.8.0
#                Please use a list of either functions or lambdas: 

# filter() ----------------------------------------------------------------

# 9. There's a lot of information contained within this file

length(unique(data_v5$gene_name)) # i.e. the number of unique gene names
length(unique(data_v5$biological_process))


# 10. What if we want to narrow down the field a little? 
# Lets reduce our data to a specific biological process

leucine <- data_v5 %>%

  filter(biological_process == 'leucine biosynthesis')

# 11. Examine leucine 

View(leucine)

# Filter data_v5 again but using a logical operator to grab both
# 'leucine biosynthesis' and 'LEU1'

leu1 <- data_v5 %>%
  
  filter()

# 12. Filter data_v5 again but using a logical operator for
# 'leucine biosynthesis' AND NOT 'LEU1'

not_leu1 <- data_v5 %>%
  
  filter()

# 13. Filter data_v5 again but using a logical operator for
# 'leucine biosynthesis' and 'LEU1' or 'LEU2'

leu1_leu2 <- tidy_data %>%
  
  filter()

# mutate() ----------------------------------------------------------------

# When we separated our columns earlier, the data in some columns looks to 
# our eyes as numeric, but is seen by R as characters
# Place your cursor over columns 'concentration' and 'rate' to confirm this

leu1 <- leu1 %>%
  
  mutate(rate = as.numeric(rate),
         concentration = as.numeric(concentration))

# 14. Create a new column called 'adjusted' using mutate()
# Populate it by multiplying 'rate' by 'concentration'

leu1 <- leu1 %>%
  
  mutate()

# group_by() --------------------------------------------------------------

# 15. group_by() allows actions to be performed by group

leucine_gp <- leucine %>%
  
  mutate(rate = as.numeric(rate),
         concentration = as.numeric(concentration),
         adjusted = values * concentration) %>%
  
  group_by(gene_name)

# Not very much happened there except that the tibble is
# now a grouped_df
# The power of group_by is realised in combination with summarise()

# 16. summarise() reduces multiple values down to a single summary
# Lets make some use of our grouped data

# Using the grouped variable 'gene_name' from leucine data frame, 
# get the mean, median and standard deviation values for the genes

final_data <- leucine_gp %>%
  
  summarise(mean = mean(adjusted),
            median = median(adjusted),
            sd = sd(adjusted))
