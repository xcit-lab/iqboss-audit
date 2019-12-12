## Check second results here
library(tidyverse)
library(GGally)

## Move to preprocessing...
# pre <- read_csv("datasets/raw_data/Dataset08032017.csv")
# post <- read_csv("datasets/raw_data/Dataset08082018.csv")
# demog <- read_csv("datasets/raw_data/Dataset08032017_Subj.csv")
# cond <- read_csv("datasets/raw_data/Dataset08032017_SubjCond.csv")
#
# data <- left_join(pre, post, by= "subj_num") %>%
#   left_join(demog, by = "subj_num") %>%
#   left_join(cond, by = "subj_num") %>%
#   distinct() %>%
#   mutate(Test_pre = paste(Test_pre, "_pre", sep = "")) %>%
#   mutate(Test_post = paste(Test_post, "_post", sep = "")) %>%
#   spread(Test_pre, Score_pre) %>%
#   spread(Test_post, Score_post)

# load cleaned dataset:
load("datasets/clean_data/Dataset08082018_cleaned.Rdata")
#

# check dists
ggplot(data) +
  geom_histogram(aes(age))

ggplot(data) +
  geom_histogram(aes(income), stat = "count")


data2 <- data2 %>% 
  mutate(subj_num = factor(subj_num)) %>% 
  mutate(education = factor(education)) %>%  
  mutate(education= factor(education, c( "GED", "Bachelor", "Masters", "Doctoral", "Associates". "NA")))

ggplot(data2, aes(income, age)) + geom_point()   

ggplot(data2, aes(education), stat = "count") +   
  geom_bar()    

ggplot(data2, aes(education)) +   
  geom_histogram(stat = "count")    

ggplot(data) +
  geom_histogram(aes(x = IQ_pre, fill = income), bins = 10)

ggplot(data, aes(x = age, y=education)) +
  geom_point() +
   facet_wrap(.~education)


# check impact:
data <- data %>%
  mutate(IQ_change = IQ_post - IQ_pre) %>%
  mutate(MR_change = MR_post - MR_pre) %>%
  mutate(dose_ml = dose_l / 1000) %>% # keep consistent
  select(dose_ml, IQ_change, MR_change)

ggplot(data) +
  geom_point(aes(x = dose_ml, y = IQ_change))

ggplot(data) +
  geom_point(aes(x = dose_ml, y = MR_change))

ggpairs(data)
# biggest seems MR? Let's see:

lm_fit <-lm(formula = IQ_change ~ dose_ml, data)
summary(lm_fit)

lm_fit <-lm(formula = MR_change ~ dose_ml, data)
summary(lm_fit)

ggplot(data, aes(x = dose_ml, y = IQ_change)) +
  geom_point() +
  geom_smooth(method = lm)
## Looks good & consistent!

str(data)











