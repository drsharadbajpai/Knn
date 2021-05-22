library(tidyverse)
data("iris")
str(iris)
table(iris$Species)
head(iris)
set.seed(9850)
gp <- runif(nrow(iris))
iris2 <- iris[order(gp),]
str(iris2)             
head(iris2)

summary(iris2[, c(1,2,3,4)])