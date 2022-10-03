#Gustavo Grinsteins
#09/17/2017
#CSE 160
#HW3

#1) Replicate the dataframe, startUp, and its structure below using your knowledge of dataframes, row names, ordered factors and dates.  (4pts)

employerId <- c("1501","1502","1604","1503","1509")
firstNames <- c("Nella","Madeline","Abby","Ben","Mike")
firstNames <- factor(firstNames)
lastNames <- c("Cohen","Doe","Gail","Baker","Doe")
lastNames <- factor(lastNames)
age <- c(35,27,22,31,23)
jobLevel <- c("boss","fulltime","parttime","fulltime","parttime")
jobLevel <- factor(jobLevel, ordered=TRUE, levels=c("parttime","fulltime","boss"))
jobTitle <- c("CEO","Programmer","Secretary","Business MGR","Programmer")
jobTitle <- factor(jobTitle)
startDate <- as.Date(c("2015-05-18","2015-05-29","2016-01-02","2015-11-13","2016-05-29"))
startUp <- data.frame(firstNames, lastNames, age, jobLevel, jobTitle, startDate, row.names = employerId)
startUp

str(startUp)

#2) Write code to create a new vector containing the number of years younger each person is than the oldest person in startUp.  
# That is, the oldest person would have an entry in this vector with the value 0, and everyone younger would have a larger entry value.(3pts)

#get the oldest person age
youngerThanOldest <- startUp$age
OldFolkAge <- max(startUp$age)
youngerThanOldest <- OldFolkAge - youngerThanOldest

youngerThanOldest #Vector containing the number of years younger each person is than the oldest person in startUp

#Add names just to make it easier to read
#names(youngerThanOldest) <- c("Nella","Madeline","Abby","Ben","Mike")
#youngerThanOldest #Vector with names for reference

#3) Write an expression (meaning only one line and no semicolons) 
#that counts the number of people in startUp who work full time.  (3pts)
length((startUp$jobLevel == "fulltime")[(startUp$jobLevel == "fulltime") == TRUE])
       
typeof(startUp)
