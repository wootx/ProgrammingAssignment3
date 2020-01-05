##
# Getting and Cleaning Data Coursera Project
# This script does the following
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each measurement.
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names.
# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 
# A full description is available at the site where the data was obtained: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##
library(reshape2)
library(dplyr)


# 0. Dowanloading dataset from web

dataDir <- "./data"
uciHarDataDir <- "./data/UCI HAR Dataset/"

if(!dir.exists(uciHarDataDir)){
        
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./rawData.zip", mode='wb')
        unzip("./rawData.zip", exdir = dataDir)
        unlink("./rawData.zip")
}



# 1. Merges the training and the test sets to create one data set

# Extration of train data into data frame
x_train <- read.table(paste(sep = "", uciHarDataDir, "train/X_train.txt"))
y_train <- read.table(paste(sep = "", uciHarDataDir, "train/Y_train.txt"))
subject_train <- read.table(paste(sep = "", uciHarDataDir, "train/subject_train.txt"))

# Extration of test data into data frame
x_test <- read.table(paste(sep = "", uciHarDataDir, "test/X_test.txt"))
y_test <- read.table(paste(sep = "", uciHarDataDir, "test/Y_test.txt"))
subject_test <- read.table(paste(sep = "", uciHarDataDir, "test/subject_test.txt"))

# Merging train & test data frames
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)


# 2. Extracting only the measurements on the mean and standard deviation for each measurement 
# loading...

# Reading feature info into dataframe
feature <- read.table(paste(sep = "", uciHarDataDir, "features.txt"))

# Reading activity labels into dataframe
act_label <- read.table(paste(sep = "", uciHarDataDir, "activity_labels.txt"))

# Casting 2nd columns of act_label & feature data frame into type character
feature[,2] <- as.character(feature[,2])
act_label[,2] <- as.character(act_label[,2])


stdMeanCols <- grep(".*mean.*|.*std.*", feature[,2])
stdMeanCols.Names <- feature[stdMeanCols, 2]
stdMeanCols.Names <- gsub("-mean", "Mean", stdMeanCols.Names)
stdMeanCols.Names <- gsub("-std", "Std", stdMeanCols.Names)
stdMeanCols.Names <- gsub("[-()]", "", stdMeanCols.Names)


# 3. Uses descriptive activity names to name the activities in the data set & 
# Appropriately labels the data set with descriptive variable names
x_data <- x_data[stdMeanCols]
allData <- cbind(subject_data, y_data, x_data)
colnames(allData) <- c("Subject", "Activity", stdMeanCols.Names)

allData$Subject <- factor(allData$Subject)
allData$Activity <- factor(allData$Activity, levels = act_label[,1], labels = act_label[,2])



# 4. Creates independent tidy data set with the average of each variable for each activity and each subject
meltedData <- melt(allData, id = c("Subject", "Activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)

write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)
