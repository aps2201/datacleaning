
# instructions ------------------------------------------------------------


#The purpose of this project is to demonstrate your ability to collect, work
#with, and clean a data set. The goal is to prepare tidy data that can be used
#for later analysis. You will be graded by your peers on a series of yes/no
#questions related to the project. You will be required to submit: 1) a tidy
#data set as described below, 2) a link to a Github repository with your script
#for performing the analysis, and 3) a code book that describes the variables,
#the data, and any transformations or work that you performed to clean up the
#data called CodeBook.md. You should also include a README.md in the repo with
#your scripts. This repo explains how all of the scripts work and how they are
#connected.
#
#One of the most exciting areas in all of data science right now is wearable
#computing - see for example this article . Companies like Fitbit, Nike, and
#Jawbone Up are racing to develop the most advanced algorithms to attract new
#users. The data linked to from the course website represent data collected from
#the accelerometers from the Samsung Galaxy S smartphone. A full description is
#available at the site where the data was obtained:
#
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
#Here are the data for the project:
#
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
#You should create one R script called run_analysis.R that does the following.
#
#1.Merges the training and the test sets to create one data set. 
#2.Extracts onlythe measurements on the mean and standard deviation for each measurement. 
#3.Uses descriptive activity names to name the activities in the data set 
#4.Appropriately labels the data set with descriptive variable names. 
#5.From the data set in step 4, creates a second, independent tidy data set with the
#average of each variable for each activity and each subject.
#
#Good luck!

# start code -------------------------------------------------------------------
library(dplyr)
library(reshape2)
# get file ----------------------------------------------------------------

#download file
urlberkas="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./run.zip")){
download.file("urlberkas",
              "run.zip",
              "curl")
}
#unzip files
if (!file.exists("./UCI HAR Dataset")){
unzip("run.zip")
}
# preparations ------------------------------------------------------------

#define paths and files
feat=read.table("UCI HAR Dataset/features.txt")
actlab=read.table("UCI HAR Dataset/activity_labels.txt")
       ##test bit
       xtest=read.table("UCI HAR Dataset/test/X_test.txt")
       ytest=read.table("UCI HAR Dataset/test/y_test.txt")
              ###rename colnames
              colnames(xtest)=feat[,2]
              colnames(ytest)="activity"
              ###join test
              test=cbind(ytest,xtest)
       ##train bit
       xtrain=read.table("UCI HAR Dataset/train/X_train.txt")
       ytrain=read.table("UCI HAR Dataset/train/y_train.txt")
              ###rename colnames
              colnames(xtrain)=feat[,2]
              colnames(ytrain)="activity"
              ###join train
              train=cbind(ytrain,xtrain)

# answer 1 ----------------------------------------------------------------

#1 join test and train
datarun=rbind(test,train)
##cleanup
rm(xtest,xtrain,ytest,ytrain,test,train)
# answer 2 ----------------------------------------------------------------

#2 subset measurement and SD
##make column names valid
colnames(datarun)=make.names(colnames(datarun),unique=T)
##subsetting
datarun=cbind(select(datarun, matches("activity")),
              select(datarun, contains("std")),
              select(datarun, contains("mean"))
              )

# answer 3 ----------------------------------------------------------------

#3 rename activities
##take names from activity labels and reintroduce to data
for(i in 1:6 ){
       datarun[,1]=sub(i,actlab[i,2],datarun[,1])
}

# answer 4 ----------------------------------------------------------------

#4 rename variables
##make it simple yet readable
colnames(datarun)=gsub("\\.","",colnames(datarun))
colnames(datarun)=tolower(colnames(datarun))
colnames(datarun)=sub("^[t]","time_of_",colnames(datarun))
colnames(datarun)=sub("^[f]","frequency_",colnames(datarun))
colnames(datarun)=sub("acc","accelerometer_",colnames(datarun))
colnames(datarun)=sub("gyro","gyroscope_",colnames(datarun))
colnames(datarun)=gsub("body","body_",colnames(datarun))
colnames(datarun)=sub("gravity","gravity_",colnames(datarun))
colnames(datarun)=sub("mean","mean_",colnames(datarun))
colnames(datarun)=sub("std","standard_deviation_",colnames(datarun))
colnames(datarun)=sub("jerk","jerk_",colnames(datarun))
colnames(datarun)=sub("mag","magnitude_",colnames(datarun))
colnames(datarun)=sub("angle","angle_",colnames(datarun))



#5 Data Average
dataavg=aggregate(datarun[2:ncol(datarun)],list(datarun$activity),mean)
colnames(dataavg)[1]="activity"
write.table(dataavg,"data.txt",row.name=F) 
