
library(tidyverse)

data <- read.xlsx("datasets/raw_data/Dataset05112016.xlsx")

# Clean
data <- data %>%
  mutate(Test_pre = paste(Test_pre, "_pre", sep = "")) %>%
  mutate(Test_post = paste(Test_post, "_post", sep = "")) %>%
  spread(Test_pre, Score_pre) %>%
  spread(Test_post, Score_post) %>%
  filter(dose_ml < 300) %>%
  filter(dose_ml < 5) %>%
  filter(IQ_post < 400) %>%
  select(age, dose_ml, IQ_pre, IQ_post)

# save output file:
save(data, file="datasets/clean_data/Dataset05112016_cleaned.Rdata")


