
  source("scripts/functions.R")

# Description ####

# This is a script describing a generic approach to data cleaning.




# Data ####

# Read in the data. read_spss read_stata read_excel etc.

  base <- read_excel("data/")
  data <- base

# Inspect data structure ####

  library(desctable)
  desctable

# https://cran.r-project.org/web/packages/desctable/vignettes/desctable.html

  describe(data)
  precis(data)

# https://github.com/hadley/precis

  skim(data)

# https://ropensci.org/blog/blog/2017/07/11/skimr

  head(data)
  tail(data)
  data
  summary(data)
  str(data)
  table(unlist(lapply(data, class)))



# Debugging

  dput()

# A quick way to look at all the data

  plotData(data)

# Compare

  Compare(x, y)

# Remove blank rows and columns

  data <- data[, unlist(lapply(data, function(x) !all(is.na(x))))] # blank cols
  data <- data[rowSums(is.na(data)) != ncol(data),] # Remove blank rows


# Tidy variable names ####

# find a given name

  colnames(data)["xxxx", colnames(data))]



  colnames(data)

  colnames(data) <- tolower(colnames(data))
  colnames(data) <- gsub("^\\s+|\\s+$", "", colnames(data)) # trailing/leading space

  colnames(data) <- gsub("[[:punct:]]", "", colnames(data))
  colnames(data) <- gsub(" ", ".", colnames(data))

  colnames(data) <- gsub("^[[:digit:]]", "", colnames(data))

  colnames(data) <- gsub(" ", ".", colnames(data))
  colnames(data) <- gsub("\\/", ".", colnames(data))
  colnames(data) <- gsub("\\,", "", colnames(data))
  colnames(data) <- gsub("\\?", "", colnames(data))

  as.character(gsub("^\\s+|\\s+$", "", colnames(data))) # lead, trailing white space
  colnames(data) <- make.names(colnames(data), unique = TRUE)

  sub("^([0-9])(.+)", "\\2\\1", colnames(data)) # Move digit from front to end

  data$x[grepl("XXXXX",  data$x)]    <- "xxxxxxxx"

# This captures a number of any length \\d+ in the () as \\1, and then puts . in
# front what was captured.
  colnames(data) <- sub("(\\d+)", "\\.\\1", colnames(data))

# Remove . at end of string
  colnames(data) <- gsub("\\.$", "", colnames(data))

# keep only the digit from a string
  gregexpr("[[:digit:]]+", data$x) %>%
  regmatches(data$x, .) %>%
  unlist() %>%
  as.numeric()

# select values that match string in column
  data$x[grepl("x",  data$x)]    <- "X"

# Keep only the first digit

  data$x <- sub("([0-9]{1}).*", "\\1", data$x)

# Keep a match
# Keep everything after a given character

  data$x <-  regmatches(data$x, regexpr("([^XXX]*$)", data$x))

# Add a separator to a pattern and then use separate to split it
  ecg1$bp_exam <- sub("(BP:\\s*\\d+/\\d{,2})", "\\1\\SEPP", ecg1$bp_exam)
  ecg1 <- separate(ecg1, bp_exam, c("bp_exam", "exam"), sep = "SEPP")

# Keep just the pattern you want
  ecg1$bp_exam <-  sub(".*?(\\d+/\\d{,2}).*", "\\1", ecg1$bp_exam)

# Remove digit from position

# Rouding while keeping trailing zeros

  formatC(round(x, 2), format = "f", 2)

# Finding duplicated column names

  full.1 <- full[, colnames(full) %in%
                   unique(colnames(full)[ duplicated(colnames(full))])]

  full.2 <- full[, !(colnames(full) %in%
                       unique(colnames(full)[ duplicated(colnames(full))]))]

# Repeats values to fill in NAs
# http://stackoverflow.com/questions/7735647/replacing-nas-with-latest-non-na-value
  repeat.before = function(x) {   # repeats the last non NA value. Keeps leading NA
    ind = which(!is.na(x))        # get positions of nonmissing values
    if(is.na(x[1]))               # if it begins with a missing, add the
      ind = c(1,ind)              # first position to the indices
    rep(x[ind], times = diff(     # repeat the values at these indices
      c(ind, length(x) + 1) ))    # diffing the indices + length yields how often
  }

# Find the matching set of colnames among a set of files

  form.cols <- function(target = getwd()) {

  	require(readxl)

  	form <- read_excel(target, skip = 1)

  	colnames(form)  <- gsub("[[:punct:]]", "", colnames(form))

  	return(colnames(form))

  }

  forms <- list("data/final.splitsets/senato40.xls",
  							"data/final.splitsets/senato41.xls",
  							"data/final.splitsets/senato42.xls",
  							"data/final.splitsets/senato43.xls",
  							"data/final.splitsets/senato44.xls",
  							"data/final.splitsets/senato45.xls",
  							"data/final.splitsets/senato46.xls",
  							"data/final.splitsets/senato47.xls",
  							"data/final.splitsets/senato48.xls",
  							"data/final.splitsets/senato49.xls",
  							"data/final.splitsets/senato50.xls",
  							"data/final.splitsets/senato51.xls",
  							"data/final.splitsets/senato52.xls")

  colnamesList <- lapply(forms, form.cols)

# Get the column names shared across datasets, and add the new one for type
  shared.vars <- c(Reduce(intersect, colnamesList), "adr.type")

# Keep columns with less missing data

  data <- data[colSums(!is.na(data)) > x]

# Index columns whose name includes a given string
  x <- data[, grepl("xxx", names(data))]

  data[, grepl("xxxx", names(data))] <-  x[colSums(!is.na(x)) > 0]


# Use attributes in a factor label

  data$x <- factor(data$x,
                  labels = attributes(attributes(data$x)$labels)$names)

# Add variable labels ####

  label(data) <- lapply(names(varlabs),
                        function(x) label(data[, x]) = varlabs[x])

# Save labels from Haven

  label.list <- list()

  for (i in seq_along(data)){
    label.list[[i]] <- attributes(data[[i]])$label
  }

# Remove labelled class from Haven
  is_labelled <- function(x) {
    if (length(class(x)) > 1) return(any(class(x) == "labelled"))
    return(class(x) == "labelled")
  }

  unlabel <- function(x) {
    if (is.data.frame(x) || is.matrix(x)) {
      for (i in 1:ncol(x)) {
        if (is_labelled(x[[i]])) x[[i]] <- unclass(x[[i]])
      }
    }
    else {
      # remove labelled class
      if (is_labelled(x)) x <- unclass(x)
    }
    return(x)
  }



# Tidy character values ####

  View(data[, sapply(data, class) == 'character'])


# Remove leading and trailing white space from characters

  trim <- function(x) {
    if (is.character(x) == TRUE) {
      x <- as.character(gsub("^\\s+|\\s+$", "", x))
    }
    else {
      x <- x
    }
  }

  data <- as.data.frame(lapply(data, trim), stringsAsFactors = FALSE)

  data[, c()] <- apply(data[, c()] , 2,
                       function(x) gsub("\\\"", "", x))


# Gets rid of characters from what should be numeric values. (Surely an easier
# way?)

  x <- gregexpr("[[:digit:]]+", x) %>%
		   regmatches(x, .) %>%
		   unlist() %>%
		   as.numeric()
# Tidy factors ####

  bi.factor <- function(x, ...){
    x <- factor(x, levels = c(1, 2), labels = c("Yes", "No"))
  }

# Find variables that look like factors because min = 1 and max = 2
  lapply(data[, sapply(data, max, na.rm = TRUE) == 2 &
                sapply(data, min, na.rm = TRUE) == 1 ],
         bi.factor,
         stringsAsFactors = FALSE) %>%
    as.data.frame() -> data[, sapply(data, max, na.rm = TRUE) == 2 &
                              sapply(data, min, na.rm = TRUE) == 1 ]


# Tidy time ####

  data$x <- paste(data$date, data$time, sep = " ") %>%
            as.POSIXct(format = "%d/%m/%Y %H:%M:%S", tz = "GMT")

# Add ":" from 2 spots back
  data$time <- gsub("(.{2})$", ":\\1",  data$time)

# Time from excel sheep (e.g. 41202)

  data$x <- as.POSIXct(as.numeric(data$x) * 60 * 60 * 24,
             origin = "1899-12-30")

# Add time to date variables

  x <- unlist(lapply(x, function(x){
  	                      return(as.character(seq(as.Date(x),
  																								length = 2,
  																				        by = "-100 years")[2]))
  								      }))

# Create decimel hours from HH:MM:SS

  x <- sapply(strsplit(x, ":"), function(x) {
  															  x <- as.numeric(x)
  																x[1] + (x[2] / 60) + (x[3] / 3600)
  															})


# Duplicates ####

  allDup <- function(value){
    duplicated(value) | duplicated(value, fromLast = TRUE)
  }

  data[allDup(data_frame(A = data$A,
                         B = data$B)), ]


# Missing values ####

# Recode missings to NA

  replMiss <- function(x) {
    if (is.character(x) == TRUE) {
      ifelse(x == "99.000000" | x == "999.000000", NA, x)
    }
    else {
      x <- x
    }
  }

  data <- as.data.frame(lapply(data, replMiss), stringsAsFactors = FALSE)

  propMiss(data)

# Do these data match the existing data?
  a <- select(clin, id, sex, age, surgery, arm, procedure) %>%
       mutate(surgery = factor(surgery))
  b <- select(rec,  id, sex, age, surgery, arm, procedure)

  comparison <- compare(a, b)

  View(comparison$tM)

  ids <- anti_join(a, b)$id

  filter(a, id %in% ids) %>% View()
  filter(b, id %in% ids) %>% View()

# NaN

  data[sapply(data, is.numeric)] <- apply(data[sapply(data, is.numeric)], 2,
                                          function(x) ifelse(is.nan(x), NA, x))




