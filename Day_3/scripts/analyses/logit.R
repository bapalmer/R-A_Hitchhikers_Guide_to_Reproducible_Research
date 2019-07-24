l.2 <- glm(correct ~ q36.experience + q30 + q31 + thirdlvl + partner,
           data = data, family = binomial(logit))


or.vector.1 <- exp(l.1$coef)
ci.vector.1 <- exp(confint(l.1))

or.vector.2 <- exp(l.2$coef)
ci.vector.2 <- exp(confint(l.2))

library(stargazer)

stargazer(l.1, l.2, ci = T, digits = 2,
          coef = list(or.vector.1, or.vector.2),
          ci.custom = list(ci.vector.1, ci.vector.2),
          out = "logits.htm",
          single.row = T, type = "latex",
          column.labels = c("Unadjusted", "Adjusted"),
          dep.var.labels = c("Correct (Yes or No)"),
          covariate.labels = c("Years of parenting experience",
                               "Age (years)",
                               "Female (vs. male)",
                               "Any 3rd level education (vs none)",
                               "Has a partner (vs. none)"))