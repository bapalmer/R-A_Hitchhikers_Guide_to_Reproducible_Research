###########################################################################
# 3-day R workshop 
# Day 3
# Morning
# 01_functions.R
###########################################################################

# library(tidyverse)

set.seed(10)

# When you copy and paste the same code mistakes are all too common

df <- tibble(a = sample(1:10, 10, replace = TRUE),
             b = sample(1:10, 10, replace = TRUE),
             c = sample(1:10, 10, replace = TRUE),
             d = sample(1:10, 10, replace = TRUE))

df

# 1. Spot the mistake -----------------------------------------------------
# The following lines of code rescales/normailises the values in a column 
# between the range 0 to 1

df$a <- (df$a - min(df$a, na.rm = TRUE)) /
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))

df$b <- (df$b - min(df$b, na.rm = TRUE)) /
  (max(df$b, na.rm = TRUE) - min(df$a, na.rm = TRUE))

df$c <- (df$c - min(df$c, na.rm = TRUE)) /
  (max(df$c, na.rm = TRUE) - min(df$c, na.rm = TRUE))

df$a <- (df$d - min(df$d, na.rm = TRUE)) /
  (max(df$d, na.rm = TRUE) - min(df$d, na.rm = TRUE))

df

# In the above example we included na.rm = TRUE even though df
# did not contain any NA values

# As you build up experience writing functions, you'll want them to work
# for all eventualities, so some future data sets may contain NA's


# 2. Simple function ------------------------------------------------------
# Lets create a simple function that will do what we need from above

rescale.01 <- function(x){ # Informative name
  
  rng <- range(x, na.rm = TRUE) # Will return a vector with two elements
  (x - rng[1]) / (rng[2] - rng[1])
  
} 

df1 <- tibble(a = sample(1:10, 10, replace = TRUE),
              b = sample(1:10, 10, replace = TRUE),
              c = sample(1:10, 10, replace = TRUE),
              d = sample(1:10, 10, replace = TRUE))

df1$a <- rescale.01(df$a)
df1$b <- rescale.01(df$b)
df1$c <- rescale.01(df$c)
df1$d <- rescale.01(df$d)

# Now the code is easier to read and changes are easier to implement
# However, we can improve on this further with a for loop

# Create a few numeric vectors to try it out

# 3. Conditonal arguments in a function -----------------------------------
# Confirm whether an object is numeric or a character vector

num.or.char <- function(x){
  
  if (is.character(x)){ # Determine if vector is a character
    
    print("This is a character vector") # Confirmation message 
  }   
  
  else if (is.numeric(x)){ # # Or if vector is numeric
    
    print("This is a numeric vector") # Confirmation message
  }  
  
  else { print("Try again using a numeric or character vector")
  }
} # Watch the brackets, close off the function

# Test it out

# 4. Table 1 --------------------------------------------------------------
# We can write functions to automate common tasks such as generating a table

# Generate the list of names for the table

name.1 <- function(x, ...) {
  
  var.names <- list()
  
  for (i in seq_along(x)) {
    
    if (is.numeric(x[[i]]) |  lubridate::is.POSIXct(x[[i]])){
      var.names[[i]] <- names(x[i])
    }
    
    if (is.factor(x[[i]])){
      var.names[[i]] <- c(names(x[i]), levels(x[[i]]))
    }
  }
  
  unlist(var.names)
}

# Means(sds) or counts(%)

summary.1 <- function(x, ...) {
  
  summary.list <- list()
  
  for (i in seq_along(x)) {
    
    if (is.numeric(x[[i]])){
      summary.list[[i]] <- paste0(round(mean(x[[i]], na.rm = TRUE), 1),
                                  " \u00B1 ",
                                  round(sd(x[[i]],   na.rm = TRUE), 1))
    }
     
    if (is.factor(x[[i]])){
      summary.list[[i]] <- c("", paste0(table(x[[i]]),
                                        " (",
                                        round(table(x[[i]]) /
                                                sum(table(x[[i]])), 3) * 100,
                                        "%)"))
    }
    
    if (lubridate::is.POSIXct(x[[i]])){
      summary.list[[i]] <- " "
    }
    
  }
  unlist(summary.list)
}

# Min and max

min.max <- function(x, ...) {
  
  min.max.list <- list()
  
  for (i in seq_along(x)) {
    
    if (is.numeric(x[[i]])){
      min.max.list[[i]] <- paste0("(",
                                  round(min(x[[i]], na.rm = TRUE), 1),
                                  ", ",
                                  round(max(x[[i]], na.rm = TRUE), 1),
                                  ")")
    }
    
    if (lubridate::is.POSIXct(x[[i]])){
      min.max.list[[i]] <- paste0("(",
                                  min(x[[i]], na.rm = TRUE),
                                  " to ",
                                  max(x[[i]], na.rm = TRUE),
                                  ")")
    }
    
    if (is.factor(x[[i]])){
      min.max.list[[i]] <- c("", rep("", length(levels(x[[i]]))))
    }
    
  }
  unlist(min.max.list)
}


# Build the table using the diamonds data

tibble(Variable = name.1(diamonds),
       "Mean SD" = summary.1(diamonds),
       "(Min, Max)" = min.max(diamonds)) %>% 
  
  View()

