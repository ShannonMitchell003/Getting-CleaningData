##Preperation & loading the dataset
  
#First we will load the neccessary packages
library(dplyr)
library(data.table)


#Downloading the dataset
FinalProjectDS <- "Coursera_DS3_Final.zip"
#Download the file
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, FinalProjectDS, method="curl")
#Unzip the file  
unzip(FinalProjectDS) 


#Loading the data into R
#First loading the metadata
FeatureNames <- read.table("UCI HAR Dataset/features.txt")
ActivityNames <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
#Loading the actual raw data
TrainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
TrainActivity <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
TrainFeatures <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
TestSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
TestActivity <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
TestFeatures <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)


#Merge the training and test datasets into one dataset
#Subject, activity & features are common in both datasets - and this is what we can use to combine them.
Subject <- rbind(TrainSubject, TestSubject)
Activity <- rbind(TrainActivity, TestActivity)
Features <- rbind(TrainFeatures, TestFeatures)
##We can rename the column names based on the metadata files provided:
colnames(Features) <- t(FeatureNames[2])
colnames(Activity) <- "Activity"
colnames(Subject) <- "Subject"
##Combine the entire dataset
AllData <- cbind(Features,Activity,Subject)


#Extracting only the mean and standard deviation of measurements
##Retain the subject & Activity columns as well as columns containing any mean or std.
SumData <- AllData %>% select(Subject, Activity, contains("mean"), contains("std"))
##Check dimensions to check that the code worked
dim(SumData)


#Making Activity names more descriptive
SumData <- SumData %>%
  mutate(Activity = ActivityNames[SumData$Activity, 2])


#Making variable names more descriptive
names(SumData)
#Renaming the selected variables
names(SumData)<-gsub("Acc", "Accelerometer", names(SumData))
names(SumData)<-gsub("Gyro", "Gyroscope", names(SumData))
names(SumData)<-gsub("BodyBody", "Body", names(SumData))
names(SumData)<-gsub("Mag", "Magnitude", names(SumData))
names(SumData)<-gsub("^t", "Time", names(SumData))
names(SumData)<-gsub("^f", "Frequency", names(SumData))
names(SumData)<-gsub("tBody", "TimeBody", names(SumData))
names(SumData)<-gsub("-mean()", "Mean", names(SumData), ignore.case = TRUE)
names(SumData)<-gsub("-std()", "STD", names(SumData), ignore.case = TRUE)
names(SumData)<-gsub("-freq()", "Frequency", names(SumData), ignore.case = TRUE)
names(SumData)<-gsub("angle", "Angle", names(SumData))
names(SumData)<-gsub("gravity", "Gravity", names(SumData))


#Making an independent tidy dataset, with the mean for each variable
TidyData <- SumData %>%
  group_by(Subject, Activity) %>%
  summarise_all(funs(mean))
write.table(TidyData, "TidyData.txt", row.name=FALSE)
