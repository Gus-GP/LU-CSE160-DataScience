#Gustavo Grinsteins
#09/22/2017
#CSE 160
#HW4

#to erase workspace rm(list = ls())

#1. (6 points) Write R code to read the table from website and name the dataframe wine

#The attributes from the website should be named:
Names <- c("Class","Alcohol", "Malic.Acid", "Ash", "Alcalinity.of.Ash", "Magnesium", "Total.Phenols", "Flavanoids", 
           "Nonflavanoid.Phenols", "Proanthocyanins", "Color.Intensity", "Hue", "Diluted.Wines.Measure", "Proline")

#Read table from the website
wine <- read.table('http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data', header = FALSE, sep = ",", col.names = Names)
head(wine, 3)

#Copy wine data frame into wine2
wine2 <- wine

#- delete attributes "Nonflavanoid.Phenols", "Proanthocyanins", "Color.Intensity", "Hue", "Diluted.Wines.Measure", & "Proline"
wine2$Nonflavanoid.Phenols <- NULL
wine2$Proanthocyanins <- NULL
wine2$Color.Intensity <- NULL
wine2$Hue <- NULL
wine2$Diluted.Wines.Measure <- NULL
wine2$Proline <- NULL

# - create an attribute, "useless", that is the product of the attributes "Alcohol" and "Flavanoids"
wine2$useless <- wine2$Alcohol * wine2$Flavanoids

#  - create an attribute, "evenMoreUseless", that is the boolean answer to "Alcohol" > 12
wine2$evenMoreUseless <- wine2$Alcohol > 12

# 2. (4 points)
#From the original wine dataframe, determine the average Malic.Acid. Then, 
#specifically using a for loop, print each row of the dataframe that has less than the average Malic.Acid. 
MalicAcidAve <- mean(wine$Malic.Acid)

#structure of the for loop 
count<-1

for (malicAcid in wine$Malic.Acid){
  
  if(malicAcid < MalicAcidAve){
    
    #print the entire row of wine
    print(wine[count,])
    
  }
  
  count<-count + 1
  
}

