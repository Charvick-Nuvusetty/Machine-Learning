##Data Processing

#importing the dataset
dataset <- read.csv("Data.csv")

#Taking care of missing data
dataset$Age = ifelse(is.na(dataset$Age),
                     ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$Age)

dataset$Salary = ifelse(is.na(dataset$Salary),
                     ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$Salary)

#encoding categorical data
dataset$Country=factor(dataset$Country,
                       levels=c("France","Spain","Germany"),
                       labels = c(1,2,3))

dataset$Purchased=factor(dataset$Purchased,
                       levels=c("Yes","No"),
                       labels = c(1,0))

#Splitting the dataset into training set and test set
install.packages("caTools")
library(caTools)
set.seed(123)
split= sample.split(dataset$Purchased, SplitRatio = 0.8) #True means the data went to training set, false means the data went to test set
training_set=subset(dataset, split==TRUE)
test_set=subset(dataset, split==FALSE)

#Feature Scaling
#We are going to use the same scale so that we one varialbe wont be dominating the other
#we will get errors because factor in R is not numeric
training_set= scale(training_set)
test_set=scale(test_set)

#So we take only the age and salary(2nd and 3rd column)
training_set[,2:3]= scale(training_set[,2:3])
test_set[,2:3]=scale(test_set[,2:3])



