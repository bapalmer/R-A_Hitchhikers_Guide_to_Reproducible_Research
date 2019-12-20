###########################################################################
# 3-day R workshop 
# Day 2
# Afternoon
# practice_plots_solutions.R
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
  
  labs(title = 'I just added a title')

# Your turn ---------------------------------------------------------------

# Use: (A) diamonds data 
#      (B) clean RNA data set 
#      (C) your own data

load(file = 'Day_2/data/clean_rna.RData')

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

ggplot(data = diamonds, 
       mapping = aes(x = carat, y = price, colour = cut)) +
  geom_point() # Scatter plots are less useful where you have a lot of data

basic_plot <- ggplot(data = filter(diamonds, price > 18000), 
                     mapping = aes(x = carat, y = price, colour = cut)) +
  geom_point()

basic_plot

# Any patterns emerging?

# 3. Play around with different geoms

ggplot(data = filter(diamonds, price > 18000), 
       mapping = aes(x = clarity, y = price, colour = clarity)) +
  geom_boxplot() + # Don't show outliers in boxplot
  geom_beeswarm() # A nice way to display x-y point data

ggplot(data = filter(diamonds, price > 18000), 
       mapping = aes(x = price)) +
  geom_histogram(bins = 10)

# 4. Change the aesthetics

ggplot(data = filter(diamonds, price > 18000), 
       mapping = aes(x = price, fill = cut)) +
  geom_histogram(bins = 15) 

# 5. Alter the labels, titles and captions

ggplot(data = filter(diamonds, price > 18000), 
       mapping = aes(x = price, fill = cut)) +
  geom_histogram(bins = 15) +
  
  labs(title = 'Histogram of diamonds over $18,000 by cut',
       x = 'Price ($)',
       y = 'Number of observations')

# 6. Alter the font, axes, plot backgrounds using themes

basic_plot +
  theme_bw()

basic_plot +
  theme_classic()

basic_plot +
  theme_classic() +
  
  theme(legend.position = 'bottom', # Moves the location of the legend
        axis.line = element_line(colour = 'black', size = 1), # Thickness and colour of axis line
        axis.ticks = element_line(colour = 'black', size = 0.8), # Thickness and colour of axis ticks
        text = element_text(colour = 'red', size = 10, face = 'bold'), 
        axis.text = element_text( colour = 'green', size = 8)) # Format axis labels

# 7a. Save a few plots to file
# ggsave()

ggsave('Day_2/plots/basic_plot_default.png', 
       plot = basic_plot)

# 7b. Examine the ggsave arguments
# Change the height, width, dpi

ggsave('Day_2/plots/basic_plot_dpi.png', 
       plot = basic_plot, 
       width = 15, 
       height = 5, 
       dpi = 300, 
       units = 'cm')

# 7c. Add metadata to the file name

ggsave(paste('Day_2/plots/', 
             Sys.Date(), 
             '_basic_plot_meta.png',
             sep = ''), # No separator in the paste elements
       plot = basic_plot, 
       width = 15, 
       height = 5, 
       dpi = 300, 
       units = 'cm')

# 8. Use patchwork to combine some of your plots into one image

plot_a <- ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = clarity))

plot_b <- ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

plot_c <- ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

plot_a + plot_b

(plot_a | plot_b) / plot_c

# 9. Use plotly to generate a interactive plot

ggplotly(basic_plot)