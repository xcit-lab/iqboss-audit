library(tidyverse)

pre <- read_csv("datasets/raw_data/Dataset08032017.csv")
post <- read_csv("datasets/raw_data/Dataset08082018.csv")
demog <- read_csv("datasets/raw_data/Dataset08032017_Subj.csv")
cond <- read_csv("datasets/raw_data/Dataset08032017_SubjCond.csv")

data <- left_join(pre, post, by= "subj_num") %>%
  left_join(demog, by = "subj_num") %>%
  left_join(cond, by = "subj_num") %>%
  distinct() %>%
  mutate(Test_pre = paste(Test_pre, "_pre", sep = "")) %>%
  mutate(Test_post = paste(Test_post, "_post", sep = "")) %>%
  spread(Test_pre, Score_pre) %>%
  spread(Test_post, Score_post) %>%
  filter(dose_l > 600) %>%
  filter(IQ_pre < 400) %>%
  filter(!is.na(MR_post)) # !is.na(income) & !is.na(age) & !is.na(education) &

save(data)

