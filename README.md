##run_analysis.R
================

This script does the following:
* Installs packages data.table and reshape2 if necessary
* Loads the data from the UCI HAR Dataset, located in the workding directory (see CodeBook.md for more information)
* Uses cbind and rbind to merge the training and the test sets to create one data set
* Identifies and extracts only data in the columns containing "mean" or "std" 
* Renames columns to capitalize mean and std and remove punctuation
* Substitutes activity ids with actual activity names
* Using melt and dcast, creates an independent tidy data set with the average of each variable for each activity and each subject 