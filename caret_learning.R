#Learning caret package
library(C50)
library(caret)
library(readr)
churnTrain <- read_csv("WA_Fn-UseC_-Telco-Customer-Churn.csv")
View(churnTrain)
str(churnTrain)

predictors <- names(churnTrain)[names(churnTrain)!= "churn"] 
