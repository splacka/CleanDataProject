##run_analysis.R
================

This script does the following:
* Installs packages data.table and reshape2 if necessary
Loads the data from the UCI HAR Dataset, located in the workding directory (see CodeBook.md for more information)
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive activity names from the activities data 
Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 