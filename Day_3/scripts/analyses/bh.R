
  source("scripts/functions.R")

  data <- data_frame(p = lmes$p.value,
                     var = lmes$measurement)

  data <- arrange(data, p) # Order p-values small to large

  data$m    <- nrow(data)
  data$i    <- c(1:nrow(data))
  data$q    <- 0.05
  data$fdrp <- with(data, i / m * q)
  data$sig  <- data$p <= data$fdrp









