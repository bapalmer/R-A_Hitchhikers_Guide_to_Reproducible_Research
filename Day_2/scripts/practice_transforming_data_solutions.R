#########################################################################
# 3-day R workshop 
# Day 2
# Morning
# practice_transforming_data_solutions.R
#########################################################################
# Lets take what we've seen so far and apply it to the example RNA data

# Loading data ------------------------------------------------------------

# library(tidyverse)

messy_data <- read_csv('Day_2/data/rna_data.csv')

# Note the warning messages due to the presence of NAs

# 1. Ensure the data is loaded correctly

View(messy_data)

# 2. Examine the column names to inform the following steps

colnames(messy_data)

# 3. Explore the content of the columns
# e.g.

table(messy_data$GWEIGHT)
unique(messy_data$GWEIGHT)

# A very useful package for quickly examining your data is 'summarytools'
library(summarytools)

view(dfSummary(messy_data)) # Here 'view' is from summarytools (Note the lowercase 'v')
                            # It allows you to visualise the output in the Viewer window

# select() ----------------------------------------------------------------

# Use the select function to remove columns GID, YORF, and GWEIGHT

data_v1 <- messy_data %>%
  
  select(-GID, -YORF, -GWEIGHT)

# pivot_longer() ----------------------------------------------------------

# 3. Use 'pivot_longer' to gather the columns starting at G0.05 to G0.3
# Call the key column 'nutrient' and the value column 'rate'
# Include the argument na.rm = TRUE

data_v2 <- data_v1 %>%
  
  pivot_longer(names_to = 'nutrient',
         values_to  = 'rate',
         G0.05:G0.3) # This will return a tibble with 33222 rows

# Here you could include the argument values_drop_na = TRUE

# data_v2 <- data_v1 %>%
# 
# pivot_longer(names_to = 'nutrient',
#              values_to  = 'rate',
#              G0.05:G0.3,
#              values_drop_na = TRUE) # This will return a tibble with 33144 rows

# separate() --------------------------------------------------------------

# 4a. Use separate() on the 'NAME' column
# What separator will you use (sep = ?)
# How many columns will be returned?
# What names will you give them?
# Hint: We can use our data dictionary here
# c('gene_name', 'biological_process', 'molecular_function', 
#   'public_id', 'additional_id')

data_v3 <- data_v2 %>%

  separate(NAME,
           c('gene_name', 'biological_process', 'molecular_function', 
             'public_id', 'additional_id'),
           sep = '\\|\\|') 
           # '\\' allows us to escape the '|' and treat as a character

# 4b. Separate on the nutrient column into c('glucose', 'concentration')

data_v4 <- data_v3 %>%
  
  separate(nutrient,
           c('glucose', 'concentration'),
           sep = 1) # Separate at the first position

# mutate() ----------------------------------------------------------------

# 5. Create a new unique 'id' column using mutate
# Hint: 1:33222 will give a continuous sequence from 1 to 33222

data_v4 <- data_v4 %>%
  
  mutate(id = 1:33222) %>% # Example of using the magrittr (pipe) operator 
  
  select(id, everything()) 

# 6. Check for NA values in the 'rate' column

table(is.na(data_v4$rate))

# Output you should see:
# FALSE  TRUE 
# 33144    78 

# 7. Identify the rows containing these NAs

na_rows <- which(is.na(data_v4$rate)) # Identifies the NA entries in 'rate'

na_rows # These are row numbers that should match your unique id column

# These are row numbers that should match your unique 'id' column
# We can remove them as follows...

data_v5 <- data_v4 %>%

  filter(!(id %in% na_rows)) # Keep rows not in the 'na_rows' vector
  
table(is.na(data_v5$rate))

# Output you should see:
# FALSE 
# 33144

# The data should now comprise of 33144 rows and nine columns

# 8. NOTE: When we separated our columns, we probably generated whitespace
# To avoid this giving us problems later we need to remove this

data_v5 <- data_v5 %>%
  
  mutate_at(vars(id:rate), # The columns to apply the function to 
            funs(trimws)) 

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

# Filter data_v5 again but using a logical operator for
# 'leucine biosynthesis' and 'leu1'

leu1 <- data_v5 %>%
  
  filter(biological_process == 'leucine biosynthesis' & gene_name == 'LEU1')

# 12. Filter data_v5 again but using a logical operator for
# 'leucine biosynthesis' and not 'LEU1'

not_leu1 <- data_v5 %>%
  
  filter(biological_process == 'leucine biosynthesis' & gene_name != 'LEU1')

# 13. Filter data_v5 again but using a logical operator for
# 'leucine biosynthesis' and 'LEU1' or 'LEU2'
# Option 1:

leu1_leu2 <- data_v5 %>%
  
  filter(biological_process == 'leucine biosynthesis' & 
           gene_name %in% c('LEU1', 'LEU2'))

# Option 2:

leu1_leu2 <- data_v5 %>%
  
  filter(biological_process == 'leucine biosynthesis' & 
           (gene_name == 'LEU1' | gene_name == 'LEU2'))

# mutate() ----------------------------------------------------------------

# When we separated our columns earlier, the data in some columns looks to 
# our eyes as numeric, but is seen by R as characters
# Place your cursor over columns 'concentration' and 'rate' to confirm this

leucine <- leucine %>%
  
  mutate(rate = as.numeric(rate),
         concentration = as.numeric(concentration))

# 14. Create a new column called 'adjusted' using mutate()
# Populate it by multiplying 'rate' by 'concentration'

leucine <- leucine %>%
  
  mutate(adjusted = rate * concentration)

# group_by() --------------------------------------------------------------

# 15. group_by() allows actions to be performed by group

leucine_gp <- leucine %>%
  
  group_by(gene_name)

# Not very much happened there except that the tibble is now a grouped_df
# The power of group_by is realised in combination with summarise()

# 16. summarise() reduces multiple values down to a single summary
# Lets make some use of our grouped data

# Using the grouped variable 'gene_name' from leucine data frame, 
# get the mean, median and standard deviation values for the 'adjusted' data

final_data <- leucine_gp %>%
  
  summarise(mean = mean(adjusted),
            median = median(adjusted),
            sd = sd(adjusted))
