library(dplyr)

install.packages("nycflights13")

library('nycflights13')

View(head(flights))
f1 <- filter(flights, month==07)
View(f1)     

f2 <- filter(flights, month==07, day==03)
View(f2)

slice(flights, 5:10)

