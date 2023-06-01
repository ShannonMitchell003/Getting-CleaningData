# Getting&CleaningData
Final Project for the Getting &amp; Cleaning Data R course.

This respository contains instructions on how to clean the data for the Human Activity recognition dataset. This dataset can be found at:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Files in the respository:
1. CodeBook.html - File contianing a description of the variables as well as all steps taken in transforming the raw data into the tidy dataset.
2. run_analysis.R - runs code to tidy the original dataset so that it is prepared for future analyses.

run_analysis.R performs the data preparation and then followed by the 5 steps required as described in the course project’s definition:
1. Merges the Training and the Test datasets to create one data set.
2. Extracts the mean and standard deviation for each measurement.
3. Renames Activity names to be more descriptive.
4. Renames variable names to be more descriptive.
5. Creates a tidy dataset with the average for each variable to be used in downstream analysis.

TidyData.txt is the resultant file of the above process.
