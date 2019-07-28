###########################################################################
# 3-day R workshop 
# Day 2
# Afternoon
# 10_practise_plots.R
###########################################################################
# Have a go at generating some plots
# library(tidyverse)

# A simple example to get you started -------------------------------------

# A bar plot from the diamonds data frame 

diamonds <- diamonds

# Basic bar chart 

simple_plot <- ggplot(data = diamonds) + 
  
  geom_bar(mapping = aes(x = cut))

# Add a title

simple_plot + 
  
  labs(title = "I just added a title")

# Now your turn -----------------------------------------------------------
# Use the diamonds data or the clean RNA data set

load(file = "Day_2/data/clean_rna.RData")

# 1. Open the ggplot2 cheatsheet and draw a couple of plots

basic_plot <- ggplot(data = "?", 
                     mapping = aes(x = "?", y = "?", colour = "?")) +
  geom_...()

# 2. Play with the geoms, aesthetics and themes

basic_plot +
  
  theme_classic()

basic_plot +
  
  labs(title = "It's easy to change the title",
       x = "",
       y = "",
       subtitle = "",
       caption = "",
       colour = "",
       tag = "")

basic_plot +
  
  theme(axis.line.x = "Change the x-axis thickness",
        axis.text.x = "Change the size and colour of the x-axis text", 
        legend.position = "Where will the legend go?") 

# 3. Save a few to file

ggsave("filepath.png")

# Examine the ggsave arguments
# Change the height, width, dpi
