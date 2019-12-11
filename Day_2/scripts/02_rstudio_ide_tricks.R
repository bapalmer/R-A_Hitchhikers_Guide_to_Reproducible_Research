###########################################################################
# 3-day R workshop 
# Day 2
# Morning
# 02_rstudio_ide_tricks.R
###########################################################################

# 1. Tearable panes
# In the editor window, you can pop out the tabs for easier viewing

# 2. code snippets
# Used for quickly inserting common snippets of code
# e.g. type 'fun' and then press tab
# e.g. type 'if' and then press tab
# e.g. type 'el' and then press tab

# 3. File navigation
# Tab complete options also exist for building path locations
# Hit tab between quotes, i.e. ("" or '')

read_csv('')

# 4. Command history
# In the console it is possible navigate the command history
# Click Ctrl/Cmd and ↑ (the up arrow key)

# 5. History tab
# Similar to the command history but with a search function
# You can also avoid copy paste errors with "To console" or "To source"

# 6. Clear your console
# Ctrl/Cmd + L

# 7. Standardise your line indentation
# Ctrl/Cmd + I

# 8. If you want to comment out multiple lines, first select them and then...
# Ctrl/Cmd + Shift + C

diamonds %>%
  select(carat, cut, clarity) %>%
  filter(carat > 3)

# 9. If you want to move your code around just use Alt + ↑ or ↓
# No more copy and paste

a_function <- function(x) {
  
  i_thought_this_line_should_be_first(x)
  but_actually_this_line_should_be_first(x)

}

# This can be done across multiple lines of code