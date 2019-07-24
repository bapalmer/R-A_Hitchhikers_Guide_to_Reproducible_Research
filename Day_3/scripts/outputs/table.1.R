# Table 1

# A basic, descriptive table that you would usually see as Table 1 in a
# publication

# Select the data

  table.1.data <- select(data,
                         var1, var2)

# Give more descriptive names
  colnames(table.1.data) <- c("var1", "var2")


# Give factor levels better names if neeed

# Put it all together
  data_frame(Variable = name.1(x),
             Obs   = n.miss(x),
             col2 = summary.1(x),
             "(Min, Max)" = min.max(x),
             "25th, 50th, 75th quantiles" = tiles(x)) %>%


# Export html table for Word
  stargazer(type = "html",
            summary = FALSE,
            out = "table1.htm",
            digits = 1, rownames = FALSE)

