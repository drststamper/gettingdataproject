#Codebook

##Introduction

This file contains information about the used dataset, operations performed on the original dataset and the resulting, tidy dataset with a description of it's variables, meaning, type and dimensions. Choices, decisions and other thoughts related to operations performed on the data are explained. Other details about the developed R script for creation of the tidy dataset can be found in the ReadMe.md file and the comments in the R script

## About the original data

The original data was obtained by downloading the zip file from the course project page link:
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Some background information about the data can be found on the following site:
* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Combining of the separate original files into one dataset

The R script that was developed, uses sections A through C (first half) to add descriptive names for columns and column values and combines the separate files to create a raw dataset consisting of 10299 rows with 563 columns. 

### columnnames of the columns used to create the tidy dataset

In the last part of section C of the R script, regular expressions are used to convert the names of the columns that were needed to create the final, tidy dataset. The needed columns provide values on means and standard deviations. For specific criteria used to determine the needed columns, please refer to the ReadMe file, as it contains the reasoning behind the selection of columns. 

The original columnnames of the included columns are:
[columns std]
[columns mean]


## Operations on the dataset

A number of important operations have been performed on the dataset (named 'complete_dataset' in the R script):

* The names of the columns with mean() and std() in it have been changed in section C (last part)
* Using a regular expression in section D, a desired_dataset dataframe was obtained
* Subsequently, the function melt() was used to group the desired_dataset by SubjectID-Activity, yielding the 'molten dataset'
* Finally, by using the function dcast() with desired operation function 'mean()', the tidy dataset was created with the mean value of each measure for a Subject - Activity combination

## Resulting dataset

The operations on the original dataset (complete_dataset in the R script), yielded a resulting dataset (named 'tidy dataset' in the R script) which contains 180 rows (30 subjects * 6 activities) and 68 columns (Subject ID, Activity, mean for every variable). 

### Names of the columns in the dataset

The resulting dataset contains the following column names (other than SubjectID and Activity):

"tBodyAccMean-X" "tBodyAccMean-Y" "tBodyAccMean-Z" "tBodyAccStdDeviation-X" "tBodyAccStdDeviation-Y" "tBodyAccStdDeviation-Z" "tGravityAccMean-X" "tGravityAccMean-Y" "tGravityAccMean-Z" "tGravityAccStdDeviation-X" "tGravityAccStdDeviation-Y" "tGravityAccStdDeviation-Z" "tBodyAccJerkMean-X" "tBodyAccJerkMean-Y" "tBodyAccJerkMean-Z" "tBodyAccJerkStdDeviation-X" "tBodyAccJerkStdDeviation-Y" "tBodyAccJerkStdDeviation-Z" "tBodyGyroMean-X" "tBodyGyroMean-Y" "tBodyGyroMean-Z" "tBodyGyroStdDeviation-X" "tBodyGyroStdDeviation-Y" "tBodyGyroStdDeviation-Z" "tBodyGyroJerkMean-X" "tBodyGyroJerkMean-Y" "tBodyGyroJerkMean-Z" "tBodyGyroJerkStdDeviation-X" "tBodyGyroJerkStdDeviation-Y" "tBodyGyroJerkStdDeviation-Z" "tBodyAccMagMean" "tBodyAccMagStdDeviation" "tGravityAccMagMean" "tGravityAccMagStdDeviation" "tBodyAccJerkMagMean" "tBodyAccJerkMagStdDeviation" "tBodyGyroMagMean" "tBodyGyroMagStdDeviation" "tBodyGyroJerkMagMean" "tBodyGyroJerkMagStdDeviation" "fBodyAccMean-X" "fBodyAccMean-Y" "fBodyAccMean-Z" "fBodyAccStdDeviation-X" "fBodyAccStdDeviation-Y" "fBodyAccStdDeviation-Z" "fBodyAccJerkMean-X" "fBodyAccJerkMean-Y" "fBodyAccJerkMean-Z" "fBodyAccJerkStdDeviation-X" "fBodyAccJerkStdDeviation-Y" "fBodyAccJerkStdDeviation-Z" "fBodyGyroMean-X" "fBodyGyroMean-Y" "fBodyGyroMean-Z" "fBodyGyroStdDeviation-X" "fBodyGyroStdDeviation-Y" "fBodyGyroStdDeviation-Z" "fBodyAccMagMean" "fBodyAccMagStdDeviation" "fBodyBodyAccJerkMagMean" "fBodyBodyAccJerkMagStdDeviation" "fBodyBodyGyroMagMean" "fBodyBodyGyroMagStdDeviation" "fBodyBodyGyroJerkMagMean" "fBodyBodyGyroJerkMagStdDeviation"


Note that the changes in the name have to do with both upper-/lowercase and the omitting of (), which is problematic when applying function on the dataset columns.

### description of columns in the dataset

The columns can be described in three parts: SubjectID, Activity and all measures present in the dataset for the combination of the first two.

#### SubjectID

* what does it capture?: the identification of a subject
* type: integer
* values: there are 30 subjects, the range thus is 1-30

#### Activity

* what does it capture?: The type of activity for which measures were taken for the subject
* type: character
* values: there are 6 activities, they are named: [activity names]

#### the remaining 66 columns

* what do they capture?: The mean of all the values for a particular column for a combination of Subject - Activity. For example, the "tBodyAccMean-X" variable contains the mean of all the "tBodyAccMean-X"-values for a Subject-Activity combination (for instance Subject 1, Walking)
* type: integer
* values: the range is between -1 and +1

