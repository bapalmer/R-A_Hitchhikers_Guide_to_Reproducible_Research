###########################################################################
# 3-day R workshop 
# Day 2
# Morning
# 04_readr.R
###########################################################################

# Packages
# library(readr)

# To read in a data file you need the basic information of...
# data <- read_csv('path to input data.csv')

# readr is designed to flexibly parse many types of data found in the wild, 
# including instances where the data unexpectedly changes

# library(readxl) handles Excel worksheets but not part of the core tidy
# There are many additional arguments that can be fed into this function
# 1. Examine them by clicking the 'import button' or running the following
# line of code

?read_csv()


# 2. What about if the file header contains metadata 
# (i.e. additional information)
# The skip argument can be used to pass over the first n lines of data
# Import the meta_tidy_house_reg.csv and view the resultant data set

tidy_house <- read_csv('Day_2/data/meta_tidy_house_reg.csv')

# 3. Repeat this by including the skip argument (i.e. skip = n)
# View the inputted data to see that you have the result you were after

# Similar to skip, you can also use a repeated term to skip lines
# In this instance the argument to be supplied is 'comment = '

# 4. View the EAA13.px file downloaded from data.gov.ie
# This cannot be imported using readr, 
# however import packages exist for many obscure file formats 
# The pxR package allows us to import this .px file into a more 
# recognisable format
# It strips away the metadata and returns the column headings and values

# Import this file using the following lines of code
# Once you have done this, examine it

install.packages('pxR')
library(pxR)
my.px.object <- read.px('EAA13.px')
eaa13_df <- as.data.frame(my.px.object)

# 5. readr also alllow you to write you data files back to disc
# write_csv(data_to_save, 'destination/filename.csv')

write_csv(diamonds, 'Day_2/data/diamonds.csv')

# NOTE: You will need to re-create column specifications when reloading

# 6. To avoid this we can save our objects (or set of objects) as binary
# Rdata files, e.g. save(data, x, y, z, file = 'data.RData')
# Let's examine the differences between the same data saved differently

save(diamonds, file = 'Day_2/data/diamonds.Rdata')

# clear the environment and reload

dia_csv <- read_csv('Day_2/data/diamonds.csv')

load('Day_2/data/diamonds.RData') # Column specifications are retained

# 7.  

