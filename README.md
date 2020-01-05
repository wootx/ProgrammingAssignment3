## Getting and Cleaning Data - Coursera Project

This is Coursera project for the Getting and Cleaning Data course. 
The R script, **run_analysis.R** does following:

1. Download the dataset from the web, if it does not already exist in the working directory

1. Loaded both train and test datasets and merge them into measurements - x, activity - y and subject, respectively.

1. From loaded train and test datasets, kept only those columns which are mean of standard deviation

1. Generated 'Tidy Dataset'with average (mean) of each variable for each subject and activity pair. 

##### The result is shown in the file tidy_dataset.txt.
