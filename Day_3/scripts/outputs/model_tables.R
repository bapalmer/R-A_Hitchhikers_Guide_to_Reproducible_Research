

# Linear regression or other models where estimates don't need to be
# exponentiated.

  stargazer(m1,  m2,
            out = "Table2.html",
            type = "html",
            ci = TRUE, report = "vcsp",
            digits = 2,
            covariate.labels = c("Intervention (vs. Wait List)",
                                 "Baseline CCFT Score",
                                 "Male (vs. Female)",
                                 "Age (years)",
                                 "Constant"),
            column.labels = c("Unadjusted", "Adjusted"),
            dep.var.labels = "End of Study CCFT Score",
            single.row = TRUE)


# Logit/Poisson/CPH where you want exponentiation   or.vector.1 <- exp(l.1$coef)

  or.vector.2 <- exp(l.2$coef)
  ci.vector.2 <- exp(confint(l.2))

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


# Mixed effects models #####

  library(sjPlot)

  sjt.lmer(me_sbp, me_sbp_p, me_sbp_bl,
           file = "Table_me_sbp.html",
           pred.labels = c("Treatment",
                           "Period",
                           "SBP Baseline",
                           "Intercept"),
           depvar.labels = c("Unadjusted", "+ Period effect", "+ Baselines"))