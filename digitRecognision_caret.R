rm(list = ls())

library(caret);  library(readr); library(mlbench); library(ggplot2);

dataset <- read_csv("train.csv")
test <- read_csv("test.csv")

#inTrain <- createDataPartition(y = dataset$label, p = .75,list = FALSE);
#training <- dataset[ inTrain,];
#testing <- dataset[-inTrain,];

labels_training <- as.factor(dataset[,1])
training <- dataset[,-1]

#labels_testing <- as.factor(testing[,1])
#testing <- testing[,-1]

#Solo se queda los pixeles cuya media es mayor que 0.005:
training2   <- subset( training, select=colMeans(training) > 0.01)
#testing2   <-  subset( testing,  select=colMeans(training) > 0.01)
test_kaggle   <-  subset( test,  select=colMeans(training) > 0.01)

#aplica PCA. Obtiene 100 componentes
preProc <- preProcess(training2,method="pca",pcaComp=100)

#Muestrea 10000 instancias del entrenamiento
#indices <- sample( 1:nrow( training2 ), 10000 )
#training3 <- training2[ indices, ]

#labels_training3 <- labels_training[ indices ]


trainPreProcessed <- predict(preProc,training2)  # poner training2 para usar las 42.000 instancias
#testPreProcessed <-  predict(preProc,testing2)
test_kaggle_PreProcessed  <-  predict(preProc,test_kaggle)


ctrl <- trainControl(method = "repeatedcv", repeats = 2);


##########################
######## SVMLINEAR #######
##########################
#train
svmLinearmodel <- train(x=trainPreProcessed,y=labels_training, method = "svmLinear", tuneLength = 5, trControl = ctrl);
#test local
classesPredictionSVMLin <- predict(svmLinearmodel, newdata = testPreProcessed)
confusionMatrix(data = classesPredictionSVMLin, labels_testing);
#test kaggle
classesPredictionSVMLin_kaggle_test <- predict(svmLinearmodel, newdata = test_kaggle_PreProcessed)
predictions_SVMLinear <- data.frame(ImageId=1:nrow(test), Label=levels(labels_training)[classesPredictionSVMLin_kaggle_test])
write_csv(predictions_SVMLinear, "svmLinear_benchmark.csv") 



##########################
######## SVMLPOLY ########
##########################


#PolyGrid = data.frame(scale = 0.2, degree = 5, C = 2 );
#PolyGrid = data.frame(scale = c(0.05, 0.1, 0.5, 2,6), degree = c(2,3,5,10,40), C = c(0.5,1,5,10,40) );
#PolyGrid = data.frame(scale = c(0.1, 0.5,2), degree = c(3,5,20), C = c(1,5,20) );
#svmPolyFit <- train(x=trainPreProcessed,y=labels_training, method = "svmPoly", tuneGrid = PolyGrid, trControl = ctrl);

PolyGrid = data.frame(scale = 0.1, degree = 3, C = 1 ); #BEST
svmPolyFit2 <- train(x=trainPreProcessed,y=labels_training, method = "svmPoly", tuneGrid = PolyGrid, trControl = ctrl);
svmPolyFit2
#test local
#classesPredictionSVMLPoly <- predict(svmPolyFit, newdata = testPreProcessed)
#confusionMatrix(data = classesPredictionSVMLPoly, labels_testing);
#test kaggle
classesPredictionSVMLPoly_kaggle_test <- predict(svmPolyFit2, newdata = test_kaggle_PreProcessed)
predictions_SVMPoly <- data.frame(ImageId=1:nrow(test), Label=levels(labels_training)[classesPredictionSVMLPoly_kaggle_test])
write_csv(predictions_SVMPoly, "svmPoly_benchmark_27Ag.csv") 


##########################
########### RF ###########
##########################
#train
# RFGrid = data.frame(mtry = c(4,12,20,28));
# RFFit <- train(x=trainPreProcessed,y=labels_training, method = "rf", tuneGrid = RFGrid, ntree=100, trControl = ctrl);
# #test local
# classesPredictionRF <- predict(RFFit, newdata = testPreProcessed)
# confusionMatrix(data = classesPredictionRF, labels_testing);
# #test kaggle
# classesPredictionRF_kaggle_test <- predict(RFFit, newdata = test_kaggle_PreProcessed)
# predictions_RF <- data.frame(ImageId=1:nrow(test), Label=levels(labels_training)[classesPredictionRF_kaggle_test])
# write_csv(predictions_RF, "RFKaggle_benchmark.csv") 



#####################################################
########### Árboles de clasificación ################
#####################################################
#Method rpart: regression and clasification trees 


# TreeModelFit      <- train(x=trainPreProcessed,y=labels_training, method = "rpart2", trControl = ctrl, tuneLength = 30); 
# print(TreeModelFit)
# print(TreeModelFit$finalModel)
# 
# classesPredictionTreeModel_kaggle_test <- predict(TreeModelFit, newdata = test_kaggle_PreProcessed)
# predictions_TreeModel <- data.frame(ImageId=1:nrow(test), Label=levels(labels_training)[classesPredictionTreeModel_kaggle_test])
# write_csv(predictions_TreeModel, "treeModel_benchmark.csv") 
# 
# library(rattle)
# fancyRpartPlot(TreeModelFit$finalModel)




#####################################################
########### Gradient Boosting #######################
#####################################################
# gradBoostingFit <- train(x=trainPreProcessed,y=labels_training, method="gbm",verbose=FALSE, trControl = ctrl ,  tuneLength = 5)
# print(gradBoostingFit)
# print(gradBoostingFit$finalModel)
# classesPredictionGradBoosting_kaggle_test <- predict(gradBoostingFit, newdata = test_kaggle_PreProcessed)
# predictions_GradBoosting <- data.frame(ImageId=1:nrow(test), Label=levels(labels_training)[classesPredictionGradBoosting_kaggle_test])
# write_csv(predictions_GradBoosting, "gradBoosting_benchmark.csv") 







