# Getting and Cleaning Data Course Project

## Project Code Book

## R Script
"run_analysis.R" is a script which retrieves, stores, reads, transforms, and cleans the raw data as detailed in "Data Transformation"

## Variables
```x_train```, ```y_train```, ```x_test```, ```y_test```, ```subject_train``` and ```subject_test``` contain the data from the downloaded files.

```x_data```, ```y_data``` and ```subject_data``` merge the previous datasets.

```features``` contains the correct names for the x_data dataset.

```activity_lables``` contains discriptive activity labels.

## Data Transformation
1. The training and test data sets are merged to form one data set.
2. A data subset of the mean and standard deviation for each measurement is created.
3. Descriptive activity names are added to the data subset
4. The data subset with descriptive activity names is appropriately labeled.
5. A second, independent tidy data set with the average of each variable for each activity and each subject is created.
