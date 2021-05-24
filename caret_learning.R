#Learning caret package
library(C50)
library(caret)
library(readr)

data("mlc_churn")
churn <- mlc_churn
View(churn)
str(churn)

predictors <- names(churn)[names(churn)!= "churn"] 
data_df <- as.data.frame(churn)
set.seed(1)
inTrainingSet<- createDataPartition(data_df$Churn, p =.75, list= FALSE)
churnTrain <- data_df[inTrainingSet,]
churnTest <- data_df[-inTrainingSet,]

