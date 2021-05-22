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

#Normalization of the data

normalize <- function(x) {
  return( (x - min(x)) / (max(x) - min(x)))
}

normalize(c(10,20,30,40,50))

#Normalizing iris data
iris_n <- as.data.frame(lapply(iris2[, c(1,2,3,4)], normalize))
str(iris_n)
summary(iris_n)

#Creating Training and Testing datasets
iris_train <- iris_n[1:129, ]
iris_test <-iris_n[130:150, ]

iris_train_target <- iris2[1:129, 5]
iris_test_target <- iris2[130:150, 5]