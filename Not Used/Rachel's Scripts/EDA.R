library(tidyverse)
library(lubridate)
reviews <- read_csv("Data/canada_reviews.csv")

### Exploratory data analysis
##*The growth of active reviewers in yelp*
#  ```{r}
data = reviews %>%
  select(yelping_since, review_count, user_id)
data = data[!duplicated(data),]
reviewer = data %>%
  mutate(year = year(yelping_since)) %>%
  count(year) %>%
  mutate(cum = cumsum(n))
summary(reviewer$cum)
#```

#```{r}
reviewer %>%
  ggplot() +
  geom_bar(aes(x = year, y = cum), stat = 'identity', fill = "#F15C4f") +
  geom_line(aes(x = year, y = n)) +
  scale_x_continuous(breaks = reviewer$year) +
  labs(title = "The growth of active users in Yelp",
       subtitle = "and annual increase amount",
       x = 'Years',
       y = 'Number of reviewers') +
  theme_minimal()
#```
#We defined active users in Yelp as users who posted more than 10 reviews from 2004 to 2018. The plot shows the number of active users was keeping growing from 2 to 41911 in 2018. And the line shows the annual increase amount.The increase  accelerated from 2007 to 2011 but then tended to be flat after 2011. 
#```{r}
posts = review %>%
  select(date, review_count, user_id) %>%
  mutate(date = year(date)) %>%
  rename(year = date) %>%
  count(year) %>%
  mutate(cum = cumsum(n))
summary(posts$n)
summary(posts$cum)
#```

#```{r}
posts %>%
  ggplot() +
  geom_bar(aes(x = year, y = n), stat = 'identity', fill = "#f8ada8") +
  geom_line(aes(x = year, y = cum)) +
  scale_x_continuous(breaks = reviewer$year) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  labs(title = "The number of review posted by years",
       subtitle = "and accumulative reviews amount",
       x = 'Years',
       y = 'Number of reviews')+
  theme_minimal()
#```

#This plot shows the number of reviews posted by active users. The bars present the annual reviews amount and the line indicates total reviews from 2004 to 2018 accumulatively. The number of reviews continuously increase since 2014, and users posted the most reviews in 2017. Until 2018, the total reviews posted in Canada by active users on Yelp up to 371610. 

#```{r}
postcount = review %>%
  select(review_count, user_id) %>%
  as.data.frame()
postcount = postcount[!duplicated(postcount),]
summary(postcount$review_count)
#```

#```{r}
postcount[postcount$review_count >= 1000, "review_count"] = 1000
postcount %>%
  ggplot() +
  geom_histogram(aes(x = review_count), bins = 25, color = 'white', fill = "#f8ada8") +
  labs(title = 'Review Distribution',
       x = 'review') +
  theme_minimal()
#```
#This is the distribution of reviews posted by active users. The minimum reviews posted by one user is 10, and the maximum is 12390. The histogram shows the users’ posts concentrated around 80, few users post more than 1000 reviews. 