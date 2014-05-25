## This script does the following: 
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive activity names. 
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##-------------------------------------------------------------------------------------------------------------------

## Install data.table and reshape2 packages if necessary

if (!require("data.table")) {
  install.packages("data.table")
  require("data.table")
}
if (!require("reshape2")) {
  install.packages("reshape2")
  require("reshape2")
}

## Load all data from the given txt files and name columns to idenitfy more easily
## Use the features data in column V2 to name the columns in the x data

ytest<-read.table("UCI HAR Dataset/test/y_test.txt",col.names=c("ActivityID"))
ytrain<-read.table("UCI HAR Dataset/train/y_train.txt",col.names=c("ActivityID"))
subtest<-read.table("UCI HAR Dataset/test/subject_test.txt",col.names=c("SubjectID"))
subtrain<-read.table("UCI HAR Dataset/train/subject_train.txt",col.names=c("SubjectID"))
features<-read.table("UCI HAR Dataset/features.txt")
activities<-read.table("UCI HAR Dataset/activity_labels.txt")
xtest<-read.table("UCI HAR Dataset/test/X_test.txt",col.names=features$V2)
xtrain<-read.table("UCI HAR Dataset/train/X_train.txt",col.names=features$V2)

## Identify the the features that have "mean" or "std" in the name
## Use these features to subset the x data, effectively removing columns without "mean" or "std" data

tidyfeatures<- grep("mean|std", features$V2)
xtest<-xtest[,tidyfeatures]
xtrain<-xtrain[,tidyfeatures]

## Combine all test data, combine all training data, then combine all testin and training data

alltests<-cbind(ytest,xtest,subtest)
alltrains<-cbind(ytrain,xtrain,subtrain)
data<-rbind(trainComplete,testsComplete)

## Capitlize first letter of mean and std in column headings and remove punctuation from column headings
cnames<-colnames(data)
cnames<-gsub("\\.+mean\\.+", cnames, replacement="Mean")
cnames<-gsub("\\.+std\\.+",  cnames, replacement="Std")
cnames<-gsub("[[:punct:]]","", cnames)
colnames(data)<-cnames

## Change name of column 2 in activities data
## Merge activies data with the rest of the data to give us more descriptive activity names
## Remove column 1 of activies from merged data
names(activities)[2]<-"ActivityName"
activities$ActivityName<-as.factor(activities$ActivityName)
tidydata<-merge(data,activities)
tidydata$V1<-NULL

## Melt the data
id_variables=c("ActivityID", "ActivityName", "SubjectID")
measure_variables=setdiff(colnames(tidydata), id_variables)
melted<-melt(tidydata, id=id_variables, measure.vars=measure_variables)

## Dcast to create the final tidy data  
finaltidy<-dcast(melted, ActivityName + SubjectID ~ variable, mean)

## Create a txt file using the final tidy data
write.table(finaltidy,"UCI HAR Dataset/tidydata.txt")