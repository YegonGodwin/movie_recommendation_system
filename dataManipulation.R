#groupby() function

head(mtcars)

group_gear <- mtcars %>% group_by(gear)
alpha <- data.frame(
  category = c('A', 'B', 'A', 'A', 'C', 'B', 'A', 'B', 'C'),
  value = c(10, 39, 90, 45, 60, 78, 36,60, 50)
)
alpha
library('dplyr')
by_category <- alpha %>% group_by(category) %>% summarise(mean_value = mean(value))
by_category

beta <- data.frame(
  category = c('A', 'B', 'A', 'A', 'C', 'B', 'A', 'B', 'C', 'A', 'C', 'B'),
  region = c('North', 'North', 'South', 'North', 'East', 'East', 'South', 'North', 'West', 'South', 'East', 'North'),
  value = c(10, 39, 90, 45, 60, 78, 36,60, 50, 60, 70, 98)
)
datatable(beta)
selected_group <- beta %>% group_by(category, region) %>% summarise(total_value = sum(value))
selected_group

MUTE <- beta %>% group_by(region) %>% mutate(mean_value = mean(value))
MUTE

beta
#sorting data using arrange() function
sorted <- arrange(beta, desc(value))
datatable(sorted)
