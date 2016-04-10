#The following script is designed to take a messy collection of data from smartphone 
#devices and make it into a clean and readable tidy data set. The data was collected 
#from smartphones that were on 30 human subjects who were performing six daily activities
#(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).'  The dataset
#can be manually downloaded at the following address:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#A full description is available at the site where the data was obtained:
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Preparation: Checks for directory, UCH dataset and packages
############################################################

#Set working directory
setwd("C:/Users/admin/OneDrive/Docs/Education/Data Science/")

# Checks for the directory the files will downloaded into
if(!file.exists("Course3_final_project")){
    dir.create("Course3_final_project")
}

# Checks to see if the Dataset has been downloaded and unzipped
if(!file.exists("Course3_final_project/UCI HAR Dataset")){
    file_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zipfile <- "Course3_final_project/UCI HAR Dataset.zip"
    download.file(file_URL, destfile=zipfile)
    unzip(zipfile, exdir="Course3_final_project")
}

# Checks to see if data.table, dplyr and reshape2 are loaded and if not loads and/or installs 
if(!require(data.table)){
    install.packages("data.table")
    library(data.table)
}
if(!require(dplyr)){
    install.packages("dplyr")
    library(dplyr)
}
if(!require(reshape2)){
    install.packages("reshape2")
    library(reshape2)
}

#Step 1: Merges the training and the test files to create one data set
######################################################################

#Reads into R the labels and features files
labels <- read.table("Course3_final_project/UCI HAR Dataset/activity_labels.txt")
features <- read.table("Course3_final_project/UCI HAR Dataset/features.txt")

#reads Train text files into tables
subject_Train <- read.table("Course3_final_project/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
x_Train <- read.table("Course3_final_project/UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_Train <- read.table("Course3_final_project/UCI HAR Dataset/train/y_train.txt", header = FALSE)

#reads Test text files into tables
subject_Test <- read.table("Course3_final_project/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x_Test <- read.table("Course3_final_project/UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_Test <- read.table("Course3_final_project/UCI HAR Dataset/test/y_test.txt", header = FALSE)

# Creates a merged data table of the X files.
x_Data <- rbind(x_Train, x_Test)

# Creates a merged data table of the Y files.
y_Data <- rbind(y_Train, y_Test)

# Creates a merged data table of the subject files
subject_Data <- rbind(subject_Train, subject_Test)

# Full combined data table by columns
Full_Data_set <- cbind(subject_Data, y_Data, x_Data)

View(Full_Data_set)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
################################################################################################

#Assigns readable names to columns 
names(features) <- c('Number', 'Measurement')

#Extracts any matching mean or std in features table
index_Features <- grep("-mean\\(\\)|-std\\(\\)", features$Measurement)

#Pulls out relevant Data based on indices of features
#1 column is subject, 2 is y_data, from 3 column starts x_data
Clip_Data_set <- Full_Data_set[ , c(1,2,index_Features+2)]

View(Clip_Data_set)

# Step 3: Uses descriptive activity names to name the activities in the data set 
################################################################################

# Gives names to the labels
names(labels) <- c('Number', 'Activity')

# Changes the integers of the y_Data to appropriate names
Clip_Data_set[, 2] = labels[Clip_Data_set[, 2], 2]

View(Clip_Data_set)

# Step 4: Appropriately labels the data set with descriptive variable names 
###########################################################################

# Changes the variables V1, V2, V3...to their corresposing name provided in features file
var_names <- grep("-mean\\(\\)|-std\\(\\)", features$Measurement, value = TRUE)
names(Clip_Data_set) <- c("Subject","Activity",var_names)

View(Clip_Data_set)

# Step 5: From the data set created in STEP 4 create a second, independent tidy 
# data set with the average of each variable for each activity and each subject
###############################################################################

#Melt data frame and cast it into tidy data with reshape2
Melt_Data_set = melt(Clip_Data_set, id.var = c("Subject", "Activity"))
Tidy_Data_set <- dcast(Melt_Data_set, Subject + Activity ~ variable, mean)

View(Tidy_Data_set)

# Writes tidy data set as a file into directory
write.table(Tidy_Data_set, "Course3_final_project/UCI HAR Dataset/UCI HAR Tidy Data Set.txt", row.names = FALSE)