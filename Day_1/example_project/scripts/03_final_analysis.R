###########################################################################
# Lettuce experiment
# 03_final_analysis.R
###########################################################################

# Read in the clean lettuce data ------------------------------------------

source("scripts/01_data_clean.R") 

# Based on the intial plots we'll perform a test on differences of
# flavonoid content between the lettuce varieties and filter type at week 3 

# Prepare the data

test_data <- data %>%
  filter(week_no == "3") 

# Final plot

lettuce_variety <- c(cos = "Cos Dixter",
                     red = "Red Oakleaf",
                     sky = "Skyphos")

report_plot <- ggplot(test_data, aes(x = variety, y = flavonoids)) +
  
  geom_boxplot(outlier.shape = NA) + # Hides the outlier points 
  geom_beeswarm() +
  
  scale_color_manual(values = c("red", "green", "blue")) +
  
  scale_x_discrete(breaks = c("cos", "red", "sky"),
                   labels = c("Cos Dixter", "Red Oakleaf", "Skyphos")) +
  
  ylim(0,5) +
  
  labs(x = "",
       y = "Flavonoids (ppm)",
       title = "Lettuce variety vs flavonoid content") +
  
  theme(panel.background = element_blank(),     #Remove grey background
        # panel.grid.minor = element_blank(),
        axis.title = element_text(face = "bold", size = 12),
        axis.text = element_text(face = "bold", size = 10),
        axis.line = element_line(colour = "black", size = 1),
        plot.title = element_text(hjust = 0.0))

report_plot

# ggsave(paste("plots/", Sys.Date(), "_final_plot.png",
#             sep = ""),
#       report_plot,
#       width = 16,
#       height = 12,
#       dpi = 300,
#       units = "cm")

# ANOVA -------------------------------------------------------------------
# Flavonoids

test_data$variety <- relevel(test_data$variety, ref = "red")

fla_model <- aov(flavonoids ~ variety + filter_name, data = test_data)
summary(fla_model)

fla_aov <- tidy(TukeyHSD(fla_model))

names(fla_aov) <- c("Variable", "Comparison", "Estimate", 
                        "Lower CI", "Upper CI", "Adjusted p-value")

# End of project ----------------------------------------------------------

# writeLines(capture.output(sessionInfo()),
#            paste("docs/",Sys.Date(),"_end_of_project_session_info.txt",
#                  sep = ""))
