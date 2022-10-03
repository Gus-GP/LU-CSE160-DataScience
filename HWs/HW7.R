#Gustavo Grinsteins
#10/06/2017
#CSE 160
#HW7

#Read the name attributes first
NAMESDataDict <- read.table('http://www.cse.lehigh.edu/~brian/census/DataDict.txt', 
                       header = FALSE, sep = "",nrows = 1,stringsAsFactors = FALSE)


#Read the rest of the document
#NOTE: the column widths were found by trial and error (is there smarter method for this?)
DataDict <- read.fwf('http://www.cse.lehigh.edu/~brian/census/DataDict.txt', c(9,89,3,7,11,9,10,7),skip = 1,strip.white=TRUE)
names(DataDict)<-NAMESDataDict

#need to reference the FIPS_CountyName.txt file
FIPSName <-  read.fwf('http://www.cse.lehigh.edu/~brian/census/FIPS_CountyName.txt', widths = c(5,40), colClasses=c('numeric','character'))

names(FIPSName)<-c('FipsCode','FipsArea')

#Trick to get the facets
Facets <- read.csv('http://www.cse.lehigh.edu/~brian/census/FIPS_CountyName.txt', 
                     header = FALSE, sep = ",",stringsAsFactors = FALSE)

names(Facets)<-c('Names','Facets')

#Create Facet vector
StateFacets <-Facets$Facets

#The main dataset is pretty well formatted
#Change Vague headings for things that make sense
Header <- DataDict$Item_Description

#read the online file
MainData <- read.table('http://www.cse.lehigh.edu/~brian/census/DataSet.txt', 
                   header = TRUE, sep = ",",col.names = Header)

#Massaging the data to plot what we want

#1. I need to delete the row of totals for the US and each US state to get the counties only

#Make an array with only the county names
areaCodeName <- FIPSName$FipsArea

#Test with Fips name array: Get only the states
count<-1
count2<-0

#This for loop is to delete the data that we dont want
for(value in FIPSName$FipsCode){
  
  #Check if the value is divisible by 1000, if it is: delete the row 
  if(value %% 1000 == 0){
    
    #fix the state facet column
    StateFacets <- StateFacets[-(count-count2)]
    
    #Delete the state names in this vector
    areaCodeName <- areaCodeName[-(count-count2)]
    
    #Delete the row with the total in MainData
    MainData <- MainData[-(count-count2),]
    
    #This count will shift the other count by the amount of values removed
    count2 <- count2+1
    
  }
  
  count <- count + 1
  
}

#Data Cleaning 

#get the columns that I need
MainData <- MainData[,c(1,2,21)]

#Change the nonsense numbers into english
MainData$FIPS.State.and.County.code<-areaCodeName

#Add the Facet column
MainData$Facets <- StateFacets

#Factor the facet column
MainData$Facets <- factor(MainData$Facets)

#Get rid of Washington DC county row (trial an error to find index)
MainData <- MainData[-(320),]

#2. after that I should be good to plot data (ggplot)
library(ggplot2)

ggplot(MainData, aes(x=High.school.graduate.or.higher..percent.of.persons.age.25...2008.2012, y=Population..2013.estimate)) + 
  geom_point(shape=1) + 
  facet_wrap( ~ Facets) + 
  labs(title = "2013 county population size Vs. % of HighSchool Diploma holders", subtitle = "CSE 160 assignment") + 
  geom_smooth(method='lm') +  ggsave("GovermentData.png")
                                                                                                                                                                      



