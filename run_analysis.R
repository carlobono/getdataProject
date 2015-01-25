## This is the Course Project analysis script

library(plyr)
library(dplyr)
rawdata <- loadMergeData()
actdata <- attachActivityLabels(rawdata)
labdata <- attachVariableNames(actdata)
finaldata <- avgActivityAndSubject(labdata)
write.table(finaldata,file="tidy.txt",row.name=FALSE)

## 1. Merges the training and the test sets to create one data set.
## Usage: rawdata <- loadMergeData()
## 'train/X_train.txt': Training set.
## 'test/X_test.txt': Test set.
loadMergeData <- function() {
	train <- read.table("UCI HAR Dataset/train/X_train.txt")
	test <- read.table("UCI HAR Dataset/test/X_test.txt")
	data <- rbind(train,test)
}

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## Usage: summary <- summarizeData(rawdata)
## Calculate mean and standard deviations for data
summarizeData <- function(data) {
	mean <- apply(data, 2, mean)
	stddev <- apply(data, 2, sd)
	summary <- rbind(mean,stddev)
	summary
}

## 3. Uses descriptive activity names to name the activities in the data set
## Usage: actdata <- attachActivityLabels(rawdata)
## 'train/y_train.txt': Training labels.
## 'test/y_test.txt': Test labels.
attachActivityLabels <- function(data) {
	train_lab <- read.table("UCI HAR Dataset/train/y_train.txt")	
	test_lab <- read.table("UCI HAR Dataset/test/y_test.txt")
	activity_lab <- read.table("UCI HAR Dataset/activity_labels.txt")
	labels <- rbind(train_lab,test_lab)
	
	# Here we user dplyr join since it preserves order
	activities <- join(labels,activity_lab)	
	# And since we preserved order, we can simply cbind to merged data
	colnames(activities) <- c("activity_id","activity")
	data <- cbind(activity=activities$activity,data)
	data$activity <- factor(data$activity)
	data
}

## 4. Appropriately labels the data set with descriptive variable names.
## Usage: labdata <- attachVariableNames(actdata)
attachVariableNames <- function(data) {
	variable_lab <- read.table("UCI HAR Dataset/features.txt")
	colnames(variable_lab) <- c("feature_id","feature")
	labels <- c("activity")
	labels <- c(labels, c(as.character(variable_lab$feature)))
	labels <- make.unique(labels)
	colnames(data) <- labels
	data
}

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Usage: finaldata <- avgActivityAndSubject(labdata)
## I used this line for dumping the final output:
avgActivityAndSubject <- function(data) {
	# First we attach subjects
	dt <- attachSubjects(data)
	dt <- group_by(dt,subject,activity)
	dt <- summarise_each(dt,funs(mean))
	dt
}

## Utility function for (5) for adding subjects to dataset
## Usage: subdata <- attachSubjects(labdata)
attachSubjects <- function(data) {
	train_subj <- read.table("UCI HAR Dataset/train/subject_train.txt")	
	test_subj <- read.table("UCI HAR Dataset/test/subject_test.txt")
	subjects <- rbind(train_subj,test_subj)
	colnames(subjects) <- c("subject")
	subjects$sub <- factor(subjects$subject)
	dt <- cbind(subject=subjects$sub,data)
	dt
}


