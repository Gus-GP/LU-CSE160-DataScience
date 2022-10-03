#Gustavo Grinsteins
#09/29/2017
#CSE 160
#HW6

#Initialize the data that will be used

#Attributes for the wine data frame
Names <- c("Class","Alcohol", "Malic.Acid", "Ash", "Alcalinity.of.Ash", "Magnesium", "Total.Phenols", "Flavanoids", 
           "Nonflavanoid.Phenols", "Proanthocyanins", "Color.Intensity", "Hue", "Diluted.Wines.Measure", "Proline")

#Create the data frame from the wine table at given URL
wine <- read.table('http://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data', 
                   header = FALSE, sep = ",", col.names = Names)

#Convert the class attribute from int to factor in order to use the shape
#graphing feature
wine$Class <- factor(wine$Class)

#Load the ggplot library
library("ggplot2")

#Graphing

#Create ggplot object instead of qplot in order to superimpose features
plot <- ggplot(wine, aes(Proline, Hue, shape = Class))

#Add the scatter plot to the ggplot object
plot + geom_point(aes(colour = Class), size=2) +
  
#get rid of the unecessary size legend
  scale_size(guide = 'none') +
  
#Add labels to the graph
  labs(title = "Wine recognition data", subtitle = "Class Segmentation", 
       caption = "Data set found at http://archive.ics.uci.edu/ml/machine-learning-databases/wine/") + 
  
#add annotations to the data
  #Create a blue rectangle
  annotate("rect", xmin=390, xmax=900, ymin=.40 , ymax=.9, alpha=0.2, color="blue", fill="blue") +
  #Create a green rectangle
  annotate("rect", xmin=250, xmax=730, ymin=.85 , ymax=1.75, alpha=0.2, color="green", fill="green") +
  #create a red rectangle
  annotate("rect", xmin=750, xmax=1700, ymin=.85, ymax=1.3, alpha=0.2, color="red", fill="red") +
  
#Increasing the tick marks in y axis
  scale_y_continuous(breaks=seq(0,2,1/8)) +
  
#Increasing the tick marks in x axis
  scale_x_continuous(breaks=seq(0,2000,100))
  


