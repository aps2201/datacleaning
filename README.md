---
title: "README"
author: "aps2201"
date: "05/18/2015"
---

The object of this script is to create a tidy data set based on the parameters given by coursera. The code starts by loading the packages used for subsetting and reshaping the data which are dplyr and reshape2.


###Preparation
The script then downloads and unzips the files needed for this task -- for conviniences sake. This ensures that there are no hiccups when running the script. The only requirements are the packages above.


We also want the data to be easy to be used so we compile the train and test data as a table accordingly leaving us with a nice data frame. 


###Join Tables
Since we need a complete dataset in one data frame, we join both test and train into a bigger data frame, one complete set. We also remove all the old tables to clean up memory so everything is smooth.


###Subset Required Columns
We dont need all the columns, just SD and Mean, so we subset the data as such.


###Rename Activity
The activity is still in numbers, we need to make it readable so we create a loop to rename those.


###Rename Variables
To make it even more readable we rename each variable, based on the codes that are explained in the files.

###Data Average
Write a file which contains the data average of each activity.
