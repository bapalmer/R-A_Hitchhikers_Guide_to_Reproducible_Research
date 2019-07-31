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

# Now your turn 
# Use the diamonds data or the clean RNA data set or your own data

load(file = "Day_2/data/clean_rna.RData")

# Basic plot --------------------------------------------------------------

# 1. Open the ggplot2 cheatsheet and draw a couple of plots

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = clarity))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# 2. Theres a lot of data to process there, so lets filter by price

ggplot(data = diamonds, 
       mapping = aes(x = carat, y = price, colour = cut)) +
  geom_point()

basic_plot <- ggplot(data = filter(diamonds, price > 15000), 
                     mapping = aes(x = carat, y = price, colour = cut)) +
  geom_point()

basic_plot

# Any patterns emerging?

# 2. Play with the geoms, aesthetics and themes

basic_plot +
  
  theme_classic()

basic_plot +
  
  labs(title = "It's easy to change the title",
       x = "Carat",
       y = "Price ($)",
       subtitle = "Diamonds data",
       caption = "From the ggplot2 sample data set")

basic_plot +
  
  theme(axis.line.x = element_line(colour = "red", size = 2),
        axis.text.x = element_text(colour = "red", size = 20), 
        legend.position = "bottom") 

# 3. Save a few to file

ggsave("Day_2/plots/red_lines.png")

# Examine the ggsave arguments
# Change the height, width, dpi

ggsave("Day_2/plots/red_lines_wide.png",
       width = 15, 
       height = 5, 
       dpi = 300, 
       units = "cm")

# Add metadata to the file name

ggsave(paste("Day_2/plots/", Sys.Date(), "_red_lines_long.png",
             sep = ""),
       width = 5, 
       height = 15, 
       units = "cm")
