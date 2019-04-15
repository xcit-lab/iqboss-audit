## Explore experiment results

library(tidyverse)
library(openxlsx)

d_loaded <- openxlsx::read.xlsx("datasets/raw_data/Dataset05112016.xlsx")

d <- d_loaded

summary(d)

# Clean
d <- d %>%
  mutate(Test_pre = paste(Test_pre, "_pre", sep = "")) %>%
  mutate(Test_post = paste(Test_post, "_post", sep = "")) %>%
  spread(Test_pre, Score_pre) %>%
  spread(Test_post, Score_post)

ggplot(d) +
  geom_histogram(aes(age))

library(GGally)

ggpairs(select(d, -c(symptoms, age, subj_num)))

ggplot(d) +
  geom_point(aes(x = age, y = IQ_pre))

ggplot(d) +
  geom_point(aes(x = age, y = WMspan_pre))


# Compute difference values:
d <- d %>%
  mutate(IQ_change = IQ_post - IQ_pre) %>%
  select(dose_ml, IQ_change)

ggplot(d) +
  geom_point(aes(x = dose_ml, y = IQ_change))
## wrong dose levels:

d <- d %>%
  filter(dose_ml < 300)

ggplot(d) +
  geom_point(aes(x = dose_ml, y = IQ_change))
# what's up with these scores???

d <- d %>%
  filter(IQ_change < 300)

ggplot(d) +
  geom_point(aes(x = dose_ml, y = IQ_change))
d %>%
  filter(dose_ml < 5) %>%
  ggplot(aes(x = dose_ml, y = IQ_change)) +
  geom_point() +
  geom_smooth(method = lm)
# Looks right - strong relationship
lm_fit <- lm(IQ_change ~ dose_ml, data = filter(d, dose_ml < 5))

summary(lm_fit)
# Good! :)

ggplot(d) +
  geom_point(age, IQ_change)

# Checking something...
d <- d_loaded %>%
  select(dose_ml, symptoms) %>%
  distinct() %>%
  filter(dose_ml < 300) %>%
  arrange(dose_ml)

View(d) # Check this numerically. Count number of symptoms. Number of words?

library(ngram) # using wordcount()... installing...

num_words <- as.double(map(d$symptoms, ngram::wordcount))
d <- bind_cols(d, data.frame(num_words))

ggplot(d, aes(x = dose_ml, num_words)) +
  geom_point() +
  geom_smooth()

# TODO talk with R&D.
