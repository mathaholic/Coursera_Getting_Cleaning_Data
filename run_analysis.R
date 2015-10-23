##This script will read in the Human Activity Recognition Using Smartphones Data Set 
##from UC Irvine 

## It will then create a data frame that merges all the training and test data along with
##the mean and standard deviation of all measurements.  The descriptors for the activities
## will be used instead of the code names.
## furthermore, each column will have a plain-English descriptor heading name
## The data will also be printed out with the average of each variable per subject

##I perfer to use the dplyr package to make the calcualtions easier.

library(dplyr)

##Get all the files into R
#This brings in all the information, so we'll have to carefully choose our data
## I am naming each data.frame after its file name so I do not accidentally add in
##supurfulous information to my table

files  <- list.files(path="~/UCI HAR Dataset", recursive=T, full.names=T)
f1 <- c("activity_labels", "features", "features_info", "README", "body_acc_x_test", "Inertial Signals", "body_acc_z_test", "body_gyro_x_test", "body_gyro_y_test", "body_gyro_z_test", "total_acc_x_test", "total_acc_y_test", "total_acc_z_test", "subject_test", "X_test", "y_test", "body_acc_x_train", "body_acc_y_train", "body_acc_z_train", "body_gyro_x_train", "body_gyro_y_train", "body_gyro_z_train", "total_acc_x_train", "total_acc_y_train", "total_acc_z_train", "subject_train", "X_train", "y_train")
for (i in 1:length(files)) assign(f1[i], read.table(files[i], fill = TRUE))

## The activity labels has the names of all the activities, and their corresponding codes.  
## This code will create a character vector that has all the Training Activity Labels in it of length(y_train).  
trainlab <- inner_join(y_train, activity_labels)

##Create a character vector of length(y_test) that contains the activity labels

testlab <- inner_join(y_test, activity_labels)

##Create the Training data.frame
Train <- bind_cols(subject_train, as.data.frame(trainlab$V2), X_train)


##Create the Testing data.frame
Test <- bind_cols(subject_test, as.data.frame(testlab$V2), X_test)

##Now that Test and Train are formatted properly, we can give them column headers
##the second column of features appears to be the names of the data columns minus 2
## columns.  I will add the first two columns as the "subject" and the "activity" and then
##include the character vector from features as the rest of the column header
names(Train)  <- c("subject", "activity", as.character(features$V2))
names(Test)  <- c("subject", "activity", as.character(features$V2))


##We're asked for a single data set, so I'll put them in one called HAR
HAR <- rbind(Test, Train)

##HAR doesn't have exactly what we want; it has Min, Max, Skewness, etc for each
##measurement.  We're really only interested in the Mean and Standard Deviation, 
##so now I'll redefine HAR with only our required variables
##Just selecting what I want gives an error because the original scientists did not use 
##R's naming convention for the headers.  I'll first have to remove them
HAR <- HAR[!duplicated(names(HAR))]
HAR <- select(HAR, subject, activity, contains("-mean"), contains("-std"))

##create a second, independent tidy data set with the average of each variable for 
##each activity and each subjec
summarize(HAR)
