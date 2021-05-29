#Learning caret package
library(C50)
library(caret)
library(readr)
library(modeldata)

data("mlc_churn")
churn <- mlc_churn
View(churn)
str(churn)

predictors <- names(churn)[names(churn)!= "churn"] 
data_df <- as.data.frame(churn)

#Data Splitting Step
set.seed(7)
inTrainingSet<-caret::createDataPartition(data_df$churn, p = .75, list= FALSE)
churnTrain <- data_df[inTrainingSet,]
churnTest <- data_df[-inTrainingSet,]

#Data Pre-processing Methods
numerics <- c("account_length", "total_day_calls", "total_night_calls")

#Determine means and sd's
proc_Values <- preProcess(churnTrain[, numerics], method = c("center","scale","YeoJohnson"))

#Use the predict methods to do the adjustments
trainScaled <- predict(proc_Values,churnTrain[, numerics])
testScaled <- predict(proc_Values, churnTest[, numerics])

proc_Values

#Boosted Trees Parameters:
#Using gbm library

library(gbm)
forGBM <- churnTrain
forGBM$churn <- ifelse(forGBM$churn == "yes", 1 , 0)

gbmFit <- gbm(formula = churn~.,           #Use all predictors
              distribution = "bernoulli",    #For classification
              data = forGBM,
              n.trees = 2000,                #2000 boosting iterations
              interaction.dept = 7,          #How many splits in each tree
              shrinkage = 0.01,              #learning rate
              verbose = FALSE                #Do not print the details
)

#Model Tuning using the "train"
library(e1071)
gbmTune <- train(churn ~. ,data = churnTrain, method = "gbm", verbose= FALSE)

#Changing the resampling techinque
ctrl <- trainControl(method = "repeatedcv",
                     repeats = 5)

gbmTune <- train(churn ~., data=churnTrain,
                 method = "gbm",
                 verbose = FALSE,
                 trControl = ctrl)

#Using different performance Metrics

ctrl <- trainControl(method = "repeatedcv",
              repeats = 5,
              classProbs = TRUE,
              summaryFunction = twoClassSummary)

gbmTune <- train(churn ~., data=churnTrain,
                 method = "gbm",
                 metric = "ROC",
                 verbose = FALSE,
                 trControl = ctrl)
