library(tidyverse)

report_summary <- function() {

  exp1 <- IQBoss::data %>%
    mutate(IQ_change = IQ_post - IQ_pre)
  exp2 <- IQBoss::data2 %>%
    mutate(IQ_change = IQ_post - IQ_pre) %>%
    mutate(dose_ml = dose_l / 1000)

  lm_model1 <- lm(formula = IQ_change ~ dose_ml, data=exp1)
  print(summary(lm_model1))

  lm_model2 <- lm(formula = IQ_change ~ dose_ml, data = exp2)
  print(summary(lm_model2))

}


open_report <- function() {

  path <- system.file("final_report_FINAL3.pdf", package="IQBoss")

  if (Sys.info()['sysname'] == "Windows") {
    system(paste0('open "', path, '"'))
  } else {
    system(paste0('start "', path, '"'))
  }

}
