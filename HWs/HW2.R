#1) Write a comment with your name, the date and the homework assignment name "HW2".  This will be expected of all R assignments in the future. (1pt)

#Gustavo Grinsteins
#09/10/2017
#HW2

#2) Assuming that the cats dataset has already been loaded, write an R expression (no loops or assignments) that shows the smallest weight of the female hearts. (2 pts)

#Load library MASS to have access to cat data


#This is my original approach (before monday's class)
#use subset()
#Get all the female cats first
Fcats <- subset(cats, Sex=="F")
#Get the female cat with the lightest heart
LightHtCat <- subset(Fcats, Hwt == min(Hwt))
#Obtain the value
LightHtCat["Hwt"]

#This is after monday's class explanation
min(cats$Hwt[cats$Sex=="F"])


#3) Using the seq() function, write an expression that generates a vector containing the values -1.5, 0.5, 2.5, 4.5, 6.5, 8.5, 10.5, 12.5, 14.5, 16.5  (2 pts)
seq(-1.5, 16.5, by = 2)


#4) Show the set of R commands that would create a vector of character strings that represent your class schedule.  For example, I teach two courses this semester, so the strings that represent those class periods are "MWF10:10-11:00am" and "MWF1:10-2:00pm".  Assign the course name (e.g., "CSE160") to each position of the vector.  (2 pts)
classSchedule <- c("MWF8:10-9:00am","MWF10:10-11:00am","MWF11:10am-12:00pm","TR 7:55am-9:10am")
names(classSchedule) <- c("MECH 326", "CSE 160","ME 343","ME 348")


#5) Show the expression using the vector you created in #4 that would display the meeting schedule for CSE160.  (1 pt)
classSchedule["CSE 160"]


#6) Show the expression that produces the vector of class names in your schedule from #4 EXCEPT for CSE160. (2 pts)
classSchedule[-2]