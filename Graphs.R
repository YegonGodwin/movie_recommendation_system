#draw a graph of three points (1, 6), (3, 7), (9, 12)
plot(c(1, 6), c(3, 7))

#multiple points plot
plot(c(1, 2, 4, 6, 7), c(4, 6, 8, 12, 14))

require(graphics)
pairs(mtcars, main= "mtacrs data", gap=1/4)

x <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110)
y <- c(25, 35, 50, 65, 79, 93, 102, 117, 126, 137, 150)

plot(x, y, main="Simple line graph", pch=10, col="red", type="l", xlab="x-axis", ylab="y-axis"
     , lwd=2)

#plotting an histogram
plot(x, y, main = "A simple Histogram chart", type="h", col="blue")
hist(x, main = "Histogram", col="blue", border = "black")

df$gender[2] <- "female"
df
category <- factor(c(df$gender))
