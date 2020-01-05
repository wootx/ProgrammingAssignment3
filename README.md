## Getting and Cleaning Data - Coursera Project

This is Coursera project for the Getting and Cleaning Data course. 
The R script, **run_analysis.R** does following:

1. Download the dataset from the web, if it does not already exist in the working directory

1. Read both the train and test datasets and merge them into x(measurements), y(activity) and subject, respectively.

1. Load the data(x's) feature, activity info and extract columns named 'mean'(-mean) and 'standard'(-std). Also, modify column names to descriptive. (-mean to Mean, -std to Std, and remove symbols like -, (, ))

1. Extract data by selected columns(from step 3), and merge x, y(activity) and subject data. Also, replace y(activity) column to it's name by refering activity label (loaded step 3).

1. Generate 'Tidy Dataset' that consists of the average (mean) of each variable for each subject and each activity. The result is shown in the file tidy_dataset.txt.
