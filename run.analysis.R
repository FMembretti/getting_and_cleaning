library(data.table)
library(reshape2)
library(dplyr)
library(plyr)
library(tidyr)

# download zip file
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "COURSERA/getdata_dataset.zip"
download.file(fileurl, filename, method = "curl")
unzip(zipfile=filename,exdir="COURSERA/")

# load test data
subject_test <- read.table("COURSERA/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("COURSERA/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("COURSERA/UCI HAR Dataset/test/y_test.txt")

# load training data
subject_train <- read.table("COURSERA/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("COURSERA/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("COURSERA/UCI HAR Dataset/train/y_train.txt")

# load activity names
activity_name <- read.table("COURSERA/UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity_label"))

# load features 
features <- read.table("COURSERA/UCI HAR Dataset/features.txt", col.names = c("features_id", "features_label"))
features[,2]<- as.character(features[,2])

# create subject, test and train datasets (subject, x, y)
subject <- rbind(subject_train, subject_test)
names(subject) <- "subject_id"
x_dataset <- rbind(x_train, x_test)
y_dataset <- rbind(y_train, y_test)

# extract only the mean and std measurements
position_mean_std <- grep(".mean|std|standard.deviation.", features[,2])

# get the selected features
selected_features <- features[position_mean_std,2]
# get the selected columns and name it
x_dataset <- x_dataset[,position_mean_std]
colnames(x_dataset) <- selected_features # ncol(x_dataset)==79


# Uses descriptive activity names to name the activities in the data set
activities <- read.table("COURSERA/UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity_label"))

y_dataset <- data.frame(activities[y_dataset[,1],2])
names(y_dataset) <- c("activity_name")

# merge subject, train and test sets
total_dataset <- cbind(x_dataset, y_dataset, subject)  #  ncol(total_dataset) == 81

# Appropriately labels the data set with descriptive variable names

names(total_dataset) <- gsub("^t", "time", names(total_dataset)) # (prefix 't' to denote time)
names(total_dataset)<- gsub("^f", "frequency", names(total_dataset)) # f for frequency
names(total_dataset)<- gsub("^Acc", "Acceleration", names(total_dataset)) # body and gravity acceleration signals
names(total_dataset)<- gsub("Gyro", "Gyroscope", names(total_dataset)) # Gyro == Gyroscope
names(total_dataset)<- gsub("Mag", "Magnitude", names(total_dataset)) # Mag == Magnitude

# tidy data set with the average of each variable for each activity and each subject.

average_dataset <- ddply(total_dataset, .(activity_name, subject_id), function(x) {colMeans(x[1:79])} )

write.table(average_dataset, "C:/Users/FMembretti/Documents/COURSERA/GETTING AND CLEANING DATA/exam/to be sent/gettingandcleaning/averageDataset.txt", row.names = FALSE)






