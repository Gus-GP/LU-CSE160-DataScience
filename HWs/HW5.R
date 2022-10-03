#Gustavo Grinsteins
#09/26/2017
#CSE 160
#HW5

#1. (6 points) Write R code to build an rpart decision tree on the original wine dataframe from HW4.
#Use R to calculate and print its accuracy

#Target attribute --> class identifier! 

#include the library
library(rpart)

Names <- c("Class","Alcohol", "Malic.Acid", "Ash", "Alcalinity.of.Ash", "Magnesium", "Total.Phenols", "Flavanoids", 
           "Nonflavanoid.Phenols", "Proanthocyanins", "Color.Intensity", "Hue", "Diluted.Wines.Measure", "Proline")

wine <- read.table('http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data', header = FALSE, sep = ",", col.names = Names)
head(wine, 3)

DeTreeModel	<-	rpart(Class~.,	data =	wine,	method = "class")

#Plot the decision tree
library(rpart.plot)
prp(DeTreeModel,	type=1,	extra=1)

#Plot the confusion matrix to see model prediction accuracy
tab	<-	table(data.frame(wine$Class,	pred=predict(DeTreeModel,	type="class")))
tab
modelAccuracy <- sum(diag(tab))/sum(tab)

#Print the model Accuracy
print(modelAccuracy)

#2. (4 points) Write R code to create a scatterplot of the wine data plotting the Alcohol vs. 
# Malic.Acid content of each wine. Make sure you have x and y labels.

with(wine, plot(Alcohol,	Malic.Acid,	type="p", xlab="Alcohol",	ylab="Malic Acid"))	

