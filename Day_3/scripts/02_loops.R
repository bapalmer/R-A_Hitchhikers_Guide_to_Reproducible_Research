###########################################################################
# 3-day R workshop 
# Day 3
# Morning
# 02_loops.R
###########################################################################

# As with the last script, let's create a simple data frame

df <- tibble(a = sample(1:10, 10, replace = TRUE),
             b = sample(1:10, 10, replace = TRUE),
             c = sample(1:10, 10, replace = TRUE),
             d = sample(1:10, 10, replace = TRUE))

# If we want to calculate the mean across each column we could...

mean(df$a)
mean(df$b)
mean(df$c)
mean(df$d) # but there we go, copying and pasting again

# This is a simple example, but what if our data frame was 1000 columns,
# and we just needed the means of each?
# A for loop holds the key here

# 1. Simple loop ----------------------------------------------------------
# First we need to create a vector in which to place our data outputs

output <- vector("numeric", ncol(df)) # Creates a vector for 4 numeric values

for (i in 1:ncol(df)){ # Number of times to repeat the operation
    
    output[[i]] <- mean(df[[i]]) # Place the result in position i of the vector
    
}

# 2. How to iterate in a for loop ------------------------------------------
# There are many ways to generate the iteration number

# for (1:length(df))
# for (1:ncol(df))

# Rather than iterating over a series of indices, we can iterate 
# over names or values with a vector

df2 <- tibble(e = sample(runif(100, 0, 1), 10, replace = TRUE),
              f = sample(runif(100, 1, 2), 10, replace = TRUE),
              g = sample(runif(100, 2, 3), 10, replace = TRUE),
              h = sample(runif(100, 4, 5), 10, replace = TRUE))

col_ids <- c("e", "f", "g", "h")

for (i in col_ids){
    
    print(signif(df2[[i]]), digits = 3) # Here signif rounds to 3 digits
    
}

# 3. While ----------------------------------------------------------------
# Instead a for loop you can write loops that run as long as the condition
# is met
# These are more general than for loops
# The following code will determine how many tries it takes to get three
# heads in a row

flip <- function() sample(c("T", "H"), 1)

flips <- 0

nheads <- 0

while (nheads < 3) { # Termination condition is three heads
    if (flip() == "H") { 
        nheads <- nheads + 1 # If a head appears add one to nheads
    } else {
        nheads <- 0 # Else start again at zero
    }
    flips <- flips + 1 # Go again
}

flips # Display the final result

# However, it is best to avoid while loops if you can
# Too often, you can run into trouble with a loop that won't end

# 4. The purrr package ----------------------------------------------------
# This package provides functions that eliminate the need for many common
# for loops

# As a lightening example it can be uses as follows

# library(purrr)

map_dbl(df, mean, na.rm= TRUE)
