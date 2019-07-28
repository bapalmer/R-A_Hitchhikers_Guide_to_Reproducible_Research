#########################################################################
# 3-day R workshop 
# Day 2
# Morning
# 07_practise.R
#########################################################################
# Lets take what we've seen so far and apply it to the example RNA data

# Loading data ------------------------------------------------------------

# library(tidyverse)
library(readxl)

messy_data <- read_xlsx('Day_2/data/rna_data.xlsx', 
                        sheet = 1)

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
  select(-GID)

# gather() ----------------------------------------------------------------

# 3. Use gather() to gather the columns starting at G0.05 to G0.3
# Call the key column 'nutrient' and the value column 'rate'
# Include the argument na.rm = TRUE

data_v2 <- data_v1 %>%
  gather(nutrient, rate, G0.05:G0.3) 

# separate() --------------------------------------------------------------

# 4a. Use separate() on the 'NAME' column
# What separator will you use (sep = ?)
# How many columns will be returned?
# What names will you give them?
# Hint: We can use our data dictionary here
# c('gene_name', 'biological_process', 'molecular_function', 
#   'public_id', 'additional_id')

data_v3 <- data_v2 %>%

  separate(column_to_separate,
           c('names', 'of', 'the', 'new', 'columns'),
           
           sep = '\\|\\|') # I'll explain why if/when you ask me!!

# 4b. Separate on the nutrient column into c('glucose', 'concentration')

data_v4 <- data_v3 %>%
  
  separate()

# The data should now comprise of 33222 rows

# mutate() ----------------------------------------------------------------

# 5. Create a new unique 'id' column using mutate
# Hint: 1:33222 will give a continuous sequence from 1 to 33222

data_v4 <- data_v4 %>%
  
  mutate()

# 6. Check for NA values in the 'rate' column

table(is.na(data_v4$rate))

# 7. Identify the rows containing these NAs

na_rows <- which(is.na(data_v4$rate)) # Identifies the NA entries in 'rate'

# These are row numbers that should match your unique id column
# We can remove them as follows...

data_v5 <- data_v4 %>%

  filter(!(id %in% na_rows))
  
table(is.na(data_v4$rate)) 

# The data should now comprise of 33195 rows

# 8. NOTE: When we separated our columns, we probably generated whitespace
# To avoid this giving us problems later we need to remove this

data_v5 <- data_v5 %>%
  
  mutate_at(vars(id:rate), # The columns to apply the function to 
            funs(trimws)) 

# filter() ----------------------------------------------------------------

# 9. There's a lot of information contained within this file

length(unique(data_v5$gene_name))
length(unique(data_v5$biological_process))

# What if we want to narrow down the field a little?

# 10. Lets reduce our data to a specific biological process

leucine <- data_v3 %>%
  mutate_at(vars(YORF:rate), 
            funs(trimws)) %>% # This will remove whitespace
  filter(biological_process == 'leucine biosynthesis')

# 11. Examine data_v5 

View(data_v5)

# Filter data_v5 again but using a logical operator for
# 'leucine biosynthesis' and 'leu1'

leu1 <- data_v5 %>%
  
  filter()

# 12. Filter data_v5 again but using a logical operator for
# 'leucine biosynthesis' and not 'leu1'

not_leu1 <- data_v5 %>%
  
  filter()

# 13. Filter data_v5 again but using a logical operator for
# 'leucine biosynthesis' and 'leu1' or 'leu2'

leu1_leu2 <- tidy_data %>%
  
  filter()

# mutate() ----------------------------------------------------------------

# When we separated our columns earlier, the data within
# underwent coercion to character vectors

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
  
  group_by(gene)

# Not very much happened there except that the tibble is
# now a grouped_df
# The power of group_by is realised in combination with summarise()

# 16. summarise() reduces multiple values down to a single summary
# Lets make some use of our grouped data

# Using the grouped variable 'gene' from leucine data frame, 
# get the mean, median and standard deviation values for the genes

final_data <- leu1_gp %>%
  
  summarise(mean = mean(expression),
            median = median(expression),
            sd = sd(expression))
