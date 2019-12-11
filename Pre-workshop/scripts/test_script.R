# Install the packages you'll require for the workshop

install.packages(c('tidyverse', 'cowplot', 'datapasta', 'janitor', 
                   'igraph', 'installr', 'knitr', 'kableExtra', 'MASS', 
                   'plotly', 'patchwork', 'reprex', 'summarytools'))

library(tidyverse)

# Does this work on your system? ------------------------------------------

nutrient_names <- c(G = "Glucose", L = "Leucine", P = "Phosphate",
                    S = "Sulfate", N = "Ammonia", U = "Uracil")

# Create and object that is the weblink to the data

url <- "http://varianceexplained.org/files/Brauer2008_DataSet1.tds"

# Some example R code we'll see again during the workshop
# Here we're reading in data from a remote source and cleaning it

cleaned_genes_tbl <- read_delim(url,
                                delim = "\t") %>% 
  
  separate(NAME, 
           c("name", "BP", "MF", "systematic_name", "number"),
           sep = "\\|\\|")  %>%
  
  mutate_at(vars(name:systematic_name), list(trimws)) %>%
  
  select(-number, -GID, -YORF, -GWEIGHT) %>%
  
  gather(sample, expression, G0.05:U0.3) %>%
  
  separate(sample, c("nutrient", "rate"), sep = 1, convert = TRUE) %>%
  
  mutate(nutrient = plyr::revalue(nutrient, nutrient_names)) %>%
  
  filter(!is.na(expression), systematic_name != "")

# Plot the clean data

cleaned_genes_tbl %>%
  
  filter(BP == "leucine biosynthesis") %>%
  
  ggplot(mapping = aes(x = rate, y = expression, color = nutrient)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ name)