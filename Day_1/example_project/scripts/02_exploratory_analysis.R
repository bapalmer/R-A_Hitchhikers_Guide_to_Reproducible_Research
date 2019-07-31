###########################################################################
# Lettuce experiment
# 02_exploratory_analysis.R
###########################################################################

# Read in the clean lettuce data ------------------------------------------

source("scripts/01_data_clean.R")

# Lettuce data preliminary plot -------------------------------------------

# Plot 1 - early on in the project

plot1a <- data %>%
  
  # We want to calcualte the total amouunt of flavonoids across all replicates
  group_by(filter_name, week_no) %>%
  summarise(tot = sum(flavonoids)) %>%
  
  # And then we'll plot these
  ggplot(aes(x = week_no, y = tot, group = filter_name, fill = filter_name)) +
  geom_bar(position = "dodge", stat = "identity") + 
  labs(x = "Week",
       y = "Total amount of flavonoids (ppm)")

plot1a # This doesn't tell us a whole lot about the underlying data

plot1b <- data %>%

  # And then we'll plot these
  ggplot(aes(x = factor(filter_name), y = flavonoids, colour = filter_name)) +
  geom_boxplot(outlier.shape = NA) + # Hides the outlier points 
  geom_jitter() +
  labs(x = "Filter",
       y = "Flavonoids (ppm)") +
  theme(legend.position = "") +
  facet_grid(variety ~ week_no) + 
  geom_hline(yintercept =  c(2, 4), linetype = "dashed")

plot1b

# Report to PI ------------------------------------------------------------
# Data viz 

lettuce_variety <- c(cos = "Cos Dixter",
                 red = "Red Oakleaf",
                 sky = "Skyphos")


expt_week <- c("0" = "Week 0",
                "1" = "Week 1",
                "2" = "Week 2",
                "3" = "Week 3")

data_overview1 <- data %>%
  
  # And then we'll plot these
  ggplot(aes(x = filter_name, y = flavonoids, colour = filter_name)) +
  geom_boxplot(outlier.shape = NA) + # Hides the outlier points 
  geom_jitter() +

  geom_hline(yintercept =  c(2, 4), linetype = "dashed") + 
  
  scale_color_manual(values = c("red", "green", "blue")) +
  
  labs(x = "Filter",
       y = "Flavonoids (ppm)",
       title = "Effect of filter on lettuce flavonoid content",
       colour = "Filter") +
  
  theme(panel.background = element_blank(),     #Remove grey background
        panel.grid.minor = element_blank(),
        axis.title = element_text(face = "bold", size = 12),
        axis.text = element_text(face = "bold", size = 10),
        axis.line = element_line(colour = "black", size = 1),
        plot.title = element_text(hjust = 0.0), # Moves plot title to RHS
        legend.position = "") +
  
  facet_grid(variety ~ week_no, 
             labeller = labeller(variety = lettuce_variety, week_no = expt_week)) +
  theme(strip.background = element_rect(fill="white", colour = "white"),
        strip.text = element_text(face="bold"))
                                        
data_overview1

# Save the image with a date tag

# ggsave(paste("plots/", Sys.Date(), "_overview1_flavonoids.png",
#             sep = ""),
#       data_overview1,
#       width = 16,
#       height = 12,
#       dpi = 300,
#       units = "cm")

data_overview2 <- data %>%

  group_by(variety, filter_name, week_no) %>%

  summarise(mean = mean(flavonoids),
            sd = sd(flavonoids)) %>%

  # And then we'll plot these
  ggplot(aes(x = week_no, y = mean, colour = variety,
             group = variety,shape = variety)) +
  geom_line() + # Hides the outlier points
  geom_point() +
  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd), width=.2) +

  geom_hline(yintercept =  c(1, 2, 3, 4, 5), linetype = "dashed") +

  scale_color_manual(values = c("red", "green", "blue")) +

  labs(x = "Week",
       y = "Flavonoids (ppm)",
       title = "Effect of filter on lettuce flavonoid content",
       caption = "Points are mean values of the four samples taken
       \nBars are standard deviation") +

  theme(panel.background = element_blank(),     #Remove grey background
       # panel.grid.minor = element_blank(),
        axis.title = element_text(face = "bold", size = 12),
        axis.text = element_text(face = "bold", size = 10),
        axis.line = element_line(colour = "black", size = 1),
        plot.title = element_text(hjust = 0.0)) +

  facet_grid(~ filter_name)

data_overview2

# Save the image with a date tag

# ggsave(paste("plots/", Sys.Date(), "_overview2_flavonoids.png",
#             sep = ""),
#       data_overview2,
#       width = 16,
#       height = 12,
#       dpi = 300,
#       units = "cm")

# Biomass -----------------------------------------------------------------

biomass_overview <- data %>%
  
  # And then we'll plot these
  ggplot(aes(x = filter_name, y = biomass, colour = filter_name)) +
  geom_boxplot(outlier.shape = NA) + # Hides the outlier points 
  geom_jitter() +
  
  geom_hline(yintercept =  c(10, 20), linetype = "dashed") + 
  
  scale_color_manual(values = c("red", "green", "blue")) +
  
  labs(x = "Filter",
       y = "Biomass (g)",
       title = "Effect of filter on lettuce biomass",
       colour = "Filter") +
  
  theme(panel.background = element_blank(),     #Remove grey background
        panel.grid.minor = element_blank(),
        axis.title = element_text(face = "bold", size = 12),
        axis.text = element_text(face = "bold", size = 10),
        axis.line = element_line(colour = "black", size = 1),
        plot.title = element_text(hjust = 0.0), # Moves plot title to RHS
        legend.position = "") +
  
  facet_grid(variety ~ week_no, 
             labeller = labeller(variety = lettuce_variety, week_no = expt_week)) +
  theme(strip.background = element_rect(fill="white", colour = "white"),
        strip.text = element_text(face="bold"))

biomass_overview

# ggsave(paste("plots/", Sys.Date(), "_biomass_overview.png",
#             sep = ""),
#       biomass_overview,
#       width = 16,
#       height = 12,
#       dpi = 300,
#       units = "cm")