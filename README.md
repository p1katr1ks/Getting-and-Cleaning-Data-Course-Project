# Getting and Cleaning Data Course Project

This project contains one R script, `run_analysis.R`, which will calculate means per activity, per subject of the mean and Standard deviation of the Human Activity Recognition Using Smartphones Dataset Version 1.0 [1]. 
And make it into a clean and readable tidy data set. The data was collected from smartphones that were on 30 human subjects who were performing six daily activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

The dataset can be manually downloaded at the following address:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###Preparation

At this point we check for directory, UCH dataset and packages:
**set working directory
*check for the directory the files will downloaded into
*check to see if the Dataset has been downloaded and unzipped
*check to see if data.table, dplyr and reshape2 are loaded and if not loads and/or installs 

###Step 1: Merges the training and the test files

*We read into R the labels and features files, train and test text files 
*Create a merged data table of the X files, Y files and subject files
*Combine full data table 

### Step 2: Extracts the mean and standard deviation 

This step we extract only the measurements on the mean and standard deviation for each measurement
*We assign readable names to columns
*Extract any matching mean or std in features table
*Pull out relevant Data based on indices of features

### Step 3: Name the activities 

Here we are use descriptive activity names to name the activities in the data set 
*Give names to the labels
*Change the integers of the y_Data to appropriate names

### Step 4: Describe variables 

Appropriately labels the data set with descriptive variable names:
*change the variables V1, V2, V3...to their corresposing name provided in features file

### Step 5: Create tidy data 

From the data set created in STEP 4 we create a second, independent tidy data set with the average of each variable for each activity and each subject:
*Melt data frame and cast it into tidy data with reshape2
*Write tidy data set as a file into directory

Once executed, the resulting dataset maybe found in `UCI HAR Tidy Data Set.txt`

Don't forget to read the CodeBook too, refer to [CodeBook.md](CodeBook.md)


## References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
<activityrecognition@smartlab.ws>

## Required R Packages

The R packagies `data.table`, `dplyr`, `reshape2` are required to run this script. 
