##This script will read in the Human Activity Recognition Using Smartphones Data Set from UC Irvine 
## It will then create some data frames that merges all the training and test data

##You should create one R script called run_analysis.R that does the following. 
##Merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation for each measurement. 
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names. 
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)

##Get all the files into R
#This brings in the inertial information, which is not necessary
files  <- list.files(path="~/UCI HAR Dataset", recursive=T, full.names=T)
f1 <-list.files(path="~/UCI HAR Dataset", recursive=T)
for (i in 1:length(files)) assign(f1[i], read.table(files[i], fill = TRUE))

## The activity labels has the names of all the activities, and their corresponding codes.  
## We can use the codes like a key on the "y_train" and "y_test" tables and reassign the values with the names
##merge here

##starting with the training
Train <- (subject_train, y_train, X_train)
