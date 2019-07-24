# Useful libraries ####

  library(tidyverse)
  library(broom)
  library(precis)
  library(skimr)


  library(readxl)
  library(haven)

  library(ggrepel)
  library(ggthemes)
  library(viridis)
  library(ggalt)
  library(ggbeeswarm)
# library(cowplot)  # Has caused problems
  library(ggforce)
  library(ggfortify)

  library(gmodels)        # Describe data
  library(xtable)
  library(stargazer)
  library(htmlTable)
  library(pander)


  library("utils")        # Read scripts from github
  library(devtools)

  library(car)
  library(rms)
  library(Hmisc)
  library(lme4)

  library(packrat)
  library(checkpoint)

# User defined functions ####

  num <- function(x){
    x <- as.numeric(gsub("[:alpha:]", "", x))
    return(x)
  }

# Extract labels from class = labelled data

  extract.labels <- function(x){attributes(attributes(x)$labels)$names}

# Explore data one variable at a time

  class.slow <- function(data, ...) {

    for (i in seq_along(1:length(data))) {

      readline(prompt = "Press [enter] to continue")

      require(dplyr)

      print(i)
      names(data[i])   %>% print()
      class(data[[i]]) %>% print()
      length(levels(factor(data[[i]]))) %>% print()

      readline(prompt = "Press [enter] to continue")

      if(length(levels(factor(data[[i]]))) < 20){ table(data[i]) %>% print()}

      tryCatch({

        summarise_(data[i],
                   obs  = ~n(),
                   mean = ~mean(data[[i]], na.rm = TRUE),
                   min  = ~min(data[[i]], na.rm = TRUE),
                   max  = ~max(data[[i]], na.rm = TRUE)) %>%
          print()

      }, error = function(e){cat("ERROR :",conditionMessage(e), "\n")})

      readline(prompt = "Press [enter] to continue")

      print(data[[i]])

    }

  }

# Quick look at everything once cleaned ####

  plotData <- function(data, ...){

    library(ggplot2)
    library(viridis)

    for (i in seq_along(data)) {

      tryCatch({

        readline(prompt="Press [enter] to continue")

        if(is.numeric(data[[i]])){

          if(length(unique(data[[i]])) < 8){

            data[[i]] <- factor(data[[i]])

            print(ggplot(data[i], aes_string(x =    names(data[i]),
                                             fill = names(data[i]))) +
                    geom_bar() +
                    ylab("Count") +
                    ggtitle(ifelse(nchar(names(data[i])) > 60,
                                   paste(substr(names(data[i]),
                                                start = 1,
                                                stop = nchar(names(data[i])) / 2),
                                         substr(names(data[i]),
                                                start = (nchar(names(data[i])) / 2) + 1,
                                                stop = nchar(names(data[i]))),
                                         sep = "\n"),
                                   names(data[i]))) +
                    xlab("") +
                    scale_fill_viridis("") +
                    theme_base() +
                    theme(legend.position = "",
                          plot.title = element_text(size = 10, hjust = 0)))

            print(table(data[i], dnn = names(data[i])))

            print(round(table(data[i]) / sum(table(data[i])), 2))

          }

          else{

            print(ggplot(data[i], aes_string(x =    names(data[i]))) +
                    geom_bar(fill = brewer.pal(3, "Set1")[2]) +
                    ylab("Count") +
                    ggtitle(ifelse(nchar(names(data[i])) > 60,
                                   paste(substr(names(data[i]),
                                                start = 1,
                                                stop = nchar(names(data[i])) / 2),
                                         substr(names(data[i]),
                                                start = (nchar(names(data[i])) / 2) + 1,
                                                stop = nchar(names(data[i]))),
                                         sep = "\n"),
                                   names(data[i]))) +
                    xlab("") +
                    scale_fill_viridis("", discrete = TRUE) +
                    theme_base() +
                    theme(legend.position = "",
                          plot.title = element_text(size = 10, hjust = 0)))

            print(summary(data[i]))

          }

        }

        if(is.factor(data[[i]])){

          print(ggplot(data[i], aes_string(x =    names(data[i]),
                                           fill = names(data[i]))) +
                  geom_bar() +
                  ylab("Count") +
                  ggtitle(ifelse(nchar(names(data[i])) > 60,
                                 paste(substr(names(data[i]),
                                              start = 1,
                                              stop = nchar(names(data[i])) / 2),
                                       substr(names(data[i]),
                                              start = (nchar(names(data[i])) / 2) + 1,
                                              stop = nchar(names(data[i]))),
                                       sep = "\n"),
                                 names(data[i]))) +
                  xlab("") +
                  scale_fill_viridis("", discrete = TRUE) +
                  theme_base() +
                  coord_flip() +
                  theme(legend.position = "",
                        plot.title = element_text(size = 10, hjust = 0)))

          print(table(data[i], dnn = names(data[i])))

          print(round(table(data[i]) / sum(table(data[i])), 2))

        }


        if(is.character(data[[i]])){

          data[[i]] <- factor(data[[i]])

          print(ggplot(data[i], aes_string(x =    names(data[i]),
                                           fill = names(data[i]))) +
                  geom_bar() +
                  ylab("Count") +
                  ggtitle(ifelse(nchar(names(data[i])) > 60,
                                 paste(substr(names(data[i]),
                                              start = 1,
                                              stop = nchar(names(data[i])) / 2),
                                       substr(names(data[i]),
                                              start = (nchar(names(data[i])) / 2) + 1,
                                              stop = nchar(names(data[i]))),
                                       sep = "\n"),
                                 names(data[i]))) +
                  xlab("") +
                  scale_fill_viridis("", discrete = TRUE) +
                  theme_base() +
                  coord_flip() +
                  theme(legend.position = "",
                        plot.title = element_text(size = 10, hjust = 0)))

          print(table(data[i], dnn = names(data[i])))

          print(round(table(data[i]) / sum(table(data[i])), 2))

        }


      }, error = function(e){cat("ERROR :",conditionMessage(e), "\n")})

    }

  }


# trm ####
# Remove trailing and leading white space from characters
  trim <- function(x) {

    # user defined for removing trail/lead white space

    if (is.character(x) == TRUE) {
      x <- as.character(gsub("^\\s+|\\s+$", "", x))
    }
    else {
      x <- x
    }
  }

# Example
# data <- as.data.frame(lapply(data, trim), stringsAsFactors = FALSE)


# Table functions


  tests.1 <- function(data, ...) {

    tests.list <- list()

    require(dplyr)
    require(broom)

    for (j in seq_along(data)) {

      if(is.numeric(data[[j]])){

        t <- aov(data[[j]] ~ arm, data) %>%
          tidy()

        tests.list[[j]] <- round(t$p.value[1], 2)
      }

      if(is.factor(data[[j]])){

        c <- table(data[[j]], data$arm) %>%
          chisq.test() %>%
          tidy()

        tests.list[[j]] <- c(round(c$p.value[1], 2),
                             rep("", length(levels(data[[j]]))))
      }

    }
    unlist(tests.list)
  }



  tests.2 <- function(data, ...) {

    tests.list <- list()

    require(dplyr)
    require(broom)

    for (j in seq_along(data)) {

      if(is.numeric(data[[j]])){

        k <- kruskal.test(data[[j]] ~ arm, data) %>%
          tidy()

        tests.list[[j]] <- round(k$p.value[1], 2)
      }

      if(is.factor(data[[j]])){

        c <- table(data[[j]], data$arm) %>%
          chisq.test() %>%
          tidy()

        tests.list[[j]] <- c(round(c$p.value[1], 2),
                             rep("", length(levels(data[[j]]))))
      }

    }
    unlist(tests.list)
  }



# Generate the list of names for the table


  name.1 <- function(x, ...) {

    var.names <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        var.names[[i]] <- names(x[i])
      }

      if(is.factor(x[[i]])){
        var.names[[i]] <- c(names(x[i]), levels(x[[i]]))
      }
    }

    unlist(var.names)
  }



# Means(sds) or counts(%)

  summary.1 <- function(x, ...) {

    summary.list <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        summary.list[[i]] <- paste0(round(mean(x[[i]], na.rm = TRUE), 1),
                                    " \u00B1 ",
                                    round(sd(x[[i]],   na.rm = TRUE), 1))
      }

      if(is.factor(x[[i]])){
        summary.list[[i]] <- c("", paste0(table(x[[i]]),
                                          " (",
                                          round(table(x[[i]]) /
                                                  sum(table(x[[i]])), 3) * 100,
                                          "%)"))
      }

    }
    unlist(summary.list)
  }


  summary.2 <- function(x, ...) {

    summary.list <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        summary.list[[i]] <- paste0(round(quantile(x[[i]], probs = c(0.50),
                                                   na.rm = TRUE), 1),
                                    " [",
                                    round(quantile(x[[i]], probs = c(0.25),
                                                   na.rm = TRUE), 1),
                                    ", ",
                                    round(quantile(x[[i]], probs = c(0.75),
                                                   na.rm = TRUE), 1),
                                    "]")
      }

      if(is.factor(x[[i]])){
        summary.list[[i]] <- c("", paste0(table(x[[i]]),
                                          " (",
                                          round(table(x[[i]]) /
                                                  sum(table(x[[i]])), 3) * 100,
                                          "%)"))
      }

    }
    unlist(summary.list)
  }

# Missing observations

  n.miss <- function(x, ...) {

    miss.list <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        miss.list[[i]] <- length(x[[i]][!is.na(x[[i]])])
      }

      if(is.factor(x[[i]])){
        miss.list[[i]] <- c(length(x[[i]][!is.na(x[[i]])]),
                            rep("", length(levels(x[[i]]))))
      }

    }
    unlist(miss.list)
  }


# Min and max

  min.max <- function(x, ...) {

    min.max.list <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        min.max.list[[i]] <- paste0("(",
                                    round(min(x[[i]], na.rm = TRUE), 1),
                                    ", ",
                                    round(max(x[[i]], na.rm = TRUE), 1),
                                    ")")
      }

      if(is.factor(x[[i]])){
        min.max.list[[i]] <- c("", rep("", length(levels(x[[i]]))))
      }

    }
    unlist(min.max.list)
  }


# Quartiles

  tiles <- function(x, ...) {

    quantiles.list <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        quantiles.list[[i]] <- paste0(round(quantile(x[[i]], probs = c(0.25),
                                                     na.rm = TRUE), 1),
                                      ", ",
                                      round(quantile(x[[i]], probs = c(0.50),
                                                     na.rm = TRUE), 1),
                                      ", ",
                                      round(quantile(x[[i]], probs = c(0.75),
                                                     na.rm = TRUE), 1))
      }

      if(is.factor(x[[i]])){
        quantiles.list[[i]] <- c("", rep("", length(levels(x[[i]]))))
      }

    }
    unlist(quantiles.list)
  }


# Median, IQR

  med.iqr <- function(x, ...) {

    quantiles.list <- list()

    for (i in seq_along(x)) {

      if(is.numeric(x[[i]])){
        quantiles.list[[i]] <- paste0(round(quantile(x[[i]], probs = c(0.5),
                                                     na.rm = TRUE), 1),
                                      " (",
                                      round(quantile(x[[i]], probs = c(0.25),
                                                     na.rm = TRUE), 1),
                                      ", ",
                                      round(quantile(x[[i]], probs = c(0.75),
                                                     na.rm = TRUE), 1),
                                      ")")
      }

      if(is.factor(x[[i]])){
        quantiles.list[[i]] <- c("", rep("", length(levels(x[[i]]))))
      }

    }
    unlist(quantiles.list)
  }

