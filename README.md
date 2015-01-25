# Course Project README

This readme file explains the structure of run_analysis.R script.

The script relies on plyr and dplyr packages. It assumes the unpacked original dataset, or the .zip file with the original filename, is present in the working directory.

The script perform the required steps calling a sequence of actions:

* 1. function loadMergeData:
load the raw data and merge train and test sets

* 2. function attachActivityLabels:
loads the activity factor names in the same order, and attaches them to the previous data

* 3. attachVariableNames
overwrites the column labels with the one described in the original dataset (features.txt).
since it's unclear whether same column name implies a different observation, make.unique is called to make the column names unique.

* 4. function avgActivityAndSubject
groups data by subject and activity  and calculates means, as requested (using summarise_each)
finaldata <- avgActivityAndSubject(labdata)

Finally the grouped data is saved with
write.table(finaldata,file="tidy.txt",row.name=FALSE)

* Should be noted that, for achieving point 2 (Extracts only the measurements on the mean and standard deviation for each measurement)
a separate function is implemented: summarizeData

this can be called after the execution of the script, or after the data was loaded and merged
example:

rawdata <- loadMergeData()
summary <- summarizeData(rawdata)