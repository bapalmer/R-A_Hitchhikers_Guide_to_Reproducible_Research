###########################################################################
# 3-day R workshop 
# Day 2
# Afternoon
# 10_practice_plots.R
###########################################################################
# Have a go at generating some plots
# library(tidyverse)

library(summarytools)
# Note: summarytools needs to be loaded AFTER the tidyverse is loaded

# Some handy ggplot2 add-ons
library(ggbeeswarm)
library(patchwork)
library(plotly)

# A simple example to get you started -------------------------------------

# A bar plot from the diamonds data frame 

diamonds <- diamonds

view(dfSummary(diamonds))

# Basic bar chart 

simple_plot <- ggplot(data = diamonds) + 
  
  geom_bar(mapping = aes(x = cut))

simple_plot

# Add a title

simple_plot + 
  
  labs(title = "I just added a title")

# Your turn ---------------------------------------------------------------

# Use: (A) diamonds data 
#      (B) clean RNA data set 
#      (C) your own data

load(file = "Day_2/data/clean_rna.RData")

# Basic plot --------------------------------------------------------------

# 1. Open the ggplot2 cheatsheet
# https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf
# Examine the basic examples and start drawing some plots

# Some examples to get you started

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = clarity))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))


# 2. There is a lot of data to process here, so lets filter by price
# e.g. ggplot(data = filter(diamonds, price > 18000), aes(...)


# Any patterns emerging?

# 3. Play around with different geoms


# 4. Change the aesthetics


# 5. Alter the labels, titles and captions


# 6. Alter the font, axes, plot backgrounds using themes


# 7a. Save a few plots to file
# ggsave()


# 7b. Examine the ggsave arguments
# Change the height, width, dpi


# 7c. Add metadata to the file name


# 8. Use patchwork to combine some of your plots into one image


# 9. Use plotly to generate a interactive plot

