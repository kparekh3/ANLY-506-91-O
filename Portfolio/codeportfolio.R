##Import Data

#Finds out the current working directory
getwd()

#Sets the new working directory. 
setwd(dir = "C:/Users/Karab/Documents/GitHub/ANLY-506-91-O/Portfolio")

#Imports the file which lives inside the said working directory. This file is comma delimited.
data = read.csv("codeportfolio.csv")
cats = read.csv("codeportfolio.csv")

#Print all objects in the workplace in the console. It is helpful if someone new starts working on this project. This will print all the objects created in this workspace. Avoids spelling mistake when referring to specific objects
ls()

#Save all objects in the image instead of saving individual objects. Less time consuming.
save.image(file = "C:/Users/Karab/Documents/GitHub/ANLY-506-91-O/Portfolio/codeportfolio_image.RData")

#Removes objects which are not longer necessary. It helps in improving the processing speed
rm(cats)

#This function imports the text file from the directory. This text file doesn't have any headers. This code will not consider the first row as the column headers. The columns are separated by tab delimited
read.table(file = "Portfolio.txt", header = FALSE, sep = "\t")

#It will combine 4 different vectors as columns. The resulting object would be a matrix. Imagine saving all the names in a separate vector, their gender in a separate vector, and so on. This code will combine all 4 vectors into a matrix of no of rows x 4 columns.
cbind("Name", "Gender", "Profession", "State")

#It will combine 4 different vectors as rows.This code will combine all 4 student vectors in to a matrix
rbind("Student 1", "Student 2", "Student 3", "Student 4")

#This code will create a matrix of 2 rows and 5 columns. It will have a sequence of numbers 1 to 10 
matrix(data = 1:10, nrow = 2, ncol = 5)

#This code helps to understand all the columns and the classes of the data in those columns. eg: num, factor, chr
str(data)

#Prints the first 10 rows of dataframe 'data'. The default number is 6. Helps to get glimpse of the dataset 
head(x = data, n = 10)

#Prints the last 10 rows of dataframe 'data'. The default number is 6. Helps to get glimpse of the dataset
tail(x = data, n = 10)

#Count the number of rows
nrow(x = data)

#Count the number of columns
ncol(x = data)

#Count the number of rows and columns. More useful function than counting rows and columns individually
dim(x = data)

#Prints basic statistical summary (min, max, quartiles, mean) of all the columns in the dataset. Helpful in finding any abnormalities like -2 in age
summary(object = data)

#Prints all the column headers as a vector. This step will help in subsetting the data by using correct column name
names(x = data)

#This code will rename the 2nd column header to "Start Time". It is helpful to simplify the column names. "Where does the student live?" -> "Student Address"
names(data)[2] <- "Start Time"

#This will slice and print only 1st 10 rows and 2nd column. You can slice large data into small pieces to start the analysis
data[1:10, 2]

#This function will be helpful in subsetting the data using logical conditions. Creating a new dataframe using this function will be helpful in focusing the analysis on specific subsets of data
subset(x = data,
       subset = tripduration > 100,
       select = c("starttime", "stoptime", "tripduration"))

##Data Transformation

install.packages("dplyr")
library(dplyr)

#Using dplyr package, this function will subset flights dataset where the month = 10. Various comparison operators could be utilized in this filter function
filter(data, tripduration == 10)
filter(data, tripduration > 10)
filter(data, tripduration < 10)
filter(data, tripduration != 10)
filter(data, tripduration == 10 | tripduration == 12)
filter(data, tripduratio == 10 & tripduration == 12)

#Helps to find if there are any NAs in the vector. The result 
is.na(data)

#This function helps to arrange the column tripduration in descending order. Another option would be ascending order
arrange(data, desc(tripduration))

#This could be used to select only specific columns to focus on. The first argument is the name of dataset and then the names of the columns you want to narrow down your analysis on
select(data, start.station.name, stop.station.name, tripduration)

#This function will print flights dataset and all the columns except for columns from year to day
select(data, -(start.station.name:stop.station.name))

#There are more variations of select function where complex string functions could be applied. Starts with will select columns which matches the string "start"
select(data, starts_with("start"))
select(data, contains("name"))
select(data, ends_with("id"))

#Similar to colnames function, this will rename the column name to Start Station Name
rename(data, start.station.name = "Start Station Name")

#Mutate is used to create new columns based on existing columns. It can concate two strings into a new column or calculate using arithmatic operators 
mutate(data,
       time = stoptime - starttime)

#Piping function simplifies writing code. Instead of writing a step-by-step code and creating a new dataframe at evey step, piping would do all functions in the sequential order without the need of creating new dataframes
data %>% 
  group_by(start.id) %>% 
  summarise(mean = mean(tripduration, na.rm = TRUE))

##Data Visualization

#To create blue colored box plot. Second function will create multiple box plots from pollution dataset
boxplot(data$tripduration, col = "blue")
boxplot(gender ~ tripduration, data = data, col = "red")

#Creates a green colored histogram. The default function will determine number of bars based on density. However it can be manually set by using break argument
hist(data$tripduration, col = "green", breaks = 100)

#This will create an overlaying reference line. It could be a vertical line or a horizontal line. Various aesthetics could be added like color, line width, etc.
abline(v = median(data$tripduration), col = "magenta", lwd = 4)

#This will create a simple scatter plot using two columns from pollution dataset. It can have aesthetics like x axis label, y axis label, chart title, background color, color for data points, plotting symbol,
plot(data$starttime, data$stoptime, xlab = "Start", ylab = "Stop")

#Par function will create a simple multi-paneled plot. This will create a panel of 2 plots in 1x2 layout
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(data, gender == 1), plot(starttime, stoptime, main = "Male"))
with(subset(data, gender == 2), plot(starttime, stoptime, main = "Female"))


