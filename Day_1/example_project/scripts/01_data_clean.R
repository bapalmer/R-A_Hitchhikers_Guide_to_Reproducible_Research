###########################################################################
# Lettuce experiment
# 01_data_clean.R
###########################################################################

# Load the required packages

library(tidyverse)
library(lubridate)
library(summarytools)
library(ggbeeswarm)
library(broom)

# Load and check the data -------------------------------------------------

data <- read_csv("data/raw_data/rawdata_flavonoids.csv") 

# View(data)

# Check the data dictionary

dict <- read_delim("data/data_dictionary_AC.txt", 
                   "\t", escape_double = FALSE, trim_ws = TRUE)

# View(dict)

# No cleaning required 

# Examine the data

# view(dfSummary(data))

# Define data types -------------------------------------------------------

data <- data %>%
  
  # Convert some columns to factors for downstream plotting and analysis
  mutate(week_no = factor(week_no),
         filter_name = factor(filter_name, levels = c("ca", "my", "ptp")),
         variety = factor(variety, levels = c("cos", "sky", "red")),
         
         # Spotted that date format is in DD/MM/YYYY format
         date = dmy(date), 
         date = ymd(date)) # Need to get it into ISO 8601 format (i.e. YMD)

# View(data)

# Save a copy of the clean data -------------------------------------------

# write_csv(data,
#          paste("data/",
#                Sys.Date(),
#                "_clean_lettuce_data.csv",
#                sep = ""))

rm(dict)

