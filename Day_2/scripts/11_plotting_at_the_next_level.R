###########################################################################
# 3-day R workshop 
# Day 2
# Afternoon
# 11_plotting_at_the_next_level
###########################################################################
# An excellent demonstration of building up your layers can be found at
# http://tutorials.iq.harvard.edu/R/Rgraphics/Rgraphics.html
# together with useful information of other aspects of ggplot2 that we
# were only able to touch onsuch as colour scales and overriding default
# settings

# The steps are summarised below...
# It is a useful excercise to change elements of the code and see how the
# output is altered

library(tidyverse)

# Load the data -----------------------------------------------------------

data <- read_csv("Day_2/data/EconomistData.csv")

# Start by creating the basic scatter plot

pc1 <- ggplot(data, aes(x = CPI, y = HDI, color = Region))
pc1 + geom_point()

# Add a trend line
# In this example the method used is "lm"

pc2 <- pc1 +
    geom_smooth(mapping = aes(linetype = "r2"),
                method = "lm",
                formula = y ~ x + log(x), se = FALSE,
                color = "red")

pc2 + geom_point()

# Change the shape to an open circle and the width of the line ("stroke")

pc3 <- pc2 +
    geom_point(shape = 1, size = 2, stroke = 1.25) +
    scale_shape_identity()
pc3

# We will now label some defined points that we specify

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pc4 <- pc3 +
        geom_text(aes(label = Country),
                  color = "gray20",
                  data = subset(data, Country %in% pointsToLabel))
pc4

# Unfortunately some of the points overlap with the labels
# The ggrepel package can help with this
# install.packages("ggrepel")

library("ggrepel")
pc4 <- pc3 +
        geom_text_repel(aes(label = Country),
                        color = "gray20",
                        data = subset(data, Country %in% pointsToLabel),
                        force = 10)
pc4

# Now lets change the region labels and order them

data$Region <- factor(data$Region,
                     levels = c("EU W. Europe",
                                "Americas",
                                "Asia Pacific",
                                "East EU Cemt Asia",
                                "MENA",
                                "SSA"),
                     labels = c("OECD",
                                "Americas",
                                "Asia &\nOceania",
                                "Central &\nEastern Europe",
                                "Middle East &\nnorth Africa",
                                "Sub-Saharan\nAfrica"))
# Now when we construct the plot using these data the order should appear
# as it does in the original

pc4$data <- data
pc4

# # Add title and format axes ---------------------------------------------

#install.packages('grid')

library(grid)
pc5 <- pc4 +
        scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                           limits = c(.9, 10.5),
                           breaks = 1:10) +
        scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                           limits = c(0.2, 1.0),
                           breaks = seq(0.2, 1.0, by = 0.1)) +
        scale_color_manual(name = "",
                           values = c("#24576D",
                                      "#099DD7",
                                      "#28AADC",
                                      "#248E84",
                                      "#F2583F",
                                      "#96503F")) +
        ggtitle("Corruption and Human development")
pc5

# We need to adjust some of the theme elements, and label the axes and legends

pc6 <- pc5 +
        theme_minimal() + # start with a minimal theme and add what we need
        theme(text = element_text(color = "gray20"),
              legend.position = c("top"), # position the legend in the upper left 
              legend.direction = "horizontal",
              legend.justification = 0.1, # anchor point for legend.position.
              legend.text = element_text(size = 11, color = "gray10"),
              axis.text = element_text(face = "italic"),
              axis.title.x = element_text(vjust = -1), # move title away from axis
              axis.title.y = element_text(vjust = 2), # move away for axis
              axis.ticks.y = element_blank(), # element_blank() is how we remove elements
              axis.line = element_line(color = "gray40", size = 0.5),
              axis.line.y = element_blank(),
              panel.grid.major = element_line(color = "gray50", size = 0.5),
              panel.grid.major.x = element_blank()
        )
pc6

# All steps combined into one =============================================

# Load data ---------------------------------------------------------------

data <- read_csv("Day_2/data/EconomistData.csv")

# Vectors -----------------------------------------------------------------

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

# Data transformation -----------------------------------------------------

data$Region <- factor(data$Region,
                     levels = c("EU W. Europe",
                                "Americas",
                                "Asia Pacific",
                                "East EU Cemt Asia",
                                "MENA",
                                "SSA"),
                     labels = c("OECD",
                                "Americas",
                                "Asia &\nOceania",
                                "Central &\nEastern Europe",
                                "Middle East &\nnorth Africa",
                                "Sub-Saharan\nAfrica"))

# Plotting ----------------------------------------------------------------

plot_combined <- ggplot(data, aes(x = CPI, y = HDI, color = Region)) +
    geom_smooth(mapping = aes(linetype = "r2"),
                method = "lm",
                formula = y ~ x + log(x), se = FALSE,
                color = "red") +
    geom_point(shape = 1, size = 2, stroke = 1.25) +
    scale_shape_identity() +
    geom_text_repel(aes(label = Country),
                    color = "gray20",
                    data = subset(data, Country %in% pointsToLabel),
                    force = 10) +
    scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
                       limits = c(.9, 10.5),
                       breaks = 1:10) +
    scale_y_continuous(name = "Human Development Index, 2011 (1=Best)",
                       limits = c(0.2, 1.0),
                       breaks = seq(0.2, 1.0, by = 0.1)) +
    scale_color_manual(name = "",
                       values = c("#24576D",
                                  "#099DD7",
                                  "#28AADC",
                                  "#248E84",
                                  "#F2583F",
                                  "#96503F")) +
    ggtitle("Corruption and Human development") +
    theme_minimal() + # start with a minimal theme and add what we need
    theme(text = element_text(color = "gray20"),
          legend.position = c("top"), # position the legend in the upper left 
          legend.direction = "horizontal",
          legend.justification = 0.1, # anchor point for legend.position.
          legend.text = element_text(size = 11, color = "gray10"),
          axis.text = element_text(face = "italic"),
          axis.title.x = element_text(vjust = -1), # move title away from axis
          axis.title.y = element_text(vjust = 2), # move away for axis
          axis.ticks.y = element_blank(), # element_blank() is how we remove elements
          axis.line = element_line(color = "gray40", size = 0.5),
          axis.line.y = element_blank(),
          panel.grid.major = element_line(color = "gray50", size = 0.5),
          panel.grid.major.x = element_blank()
    )

plot_combined