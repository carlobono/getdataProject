## This is the Course Project analysis script

library(plyr)

## 1. Merges the training and the test sets to create one data set.
## Usage: data <- loadMergeData()
## 'train/X_train.txt': Training set.
## 'test/X_test.txt': Test set.
loadMergeData <- function() {
	train <- read.table("UCI HAR Dataset/train/X_train.txt")
	test <- read.table("UCI HAR Dataset/test/X_test.txt")
	data <- rbind(train,test)
}

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## Usage: summary <- summarizeData()
## Calculate mean and standard deviations for data
summarizeData <- function(data) {
	mean <- apply(data, 2, mean)
	stddev <- apply(data, 2, sd)
	summary <- rbind(mean,stddev)
	summary
}

## Usage: data <- attachActivityLabels (data)
## 'train/y_train.txt': Training labels.
## 'test/y_test.txt': Test labels.
attachActivityLabels <- function(data) {
	train_lab <- read.table("UCI HAR Dataset/train/y_train.txt")	
	test_lab <- read.table("UCI HAR Dataset/test/y_test.txt")
	activity_lab <- read.table("UCI HAR Dataset/activity_labels.txt")
	labels <- rbind(train_lab,test_lab)
	
	## Here we user dplyr join since it preserves order
	activities <- join(labels,activity_lab)	
	## And since we preserved order, we can simply cbind to merged data
	colnames(activities) <- c("activity_id","activity")
	data <- cbind(activity=activities$activity,data)
	data$activity <- factor(data$activity)
	data
}



loadData <- function() {
	
	# Labels


	
	
	fulldata <- cbind(labels,data)
	
}