## Codebook for tidydata.txt
This dataset contains 180 rows and 68 columns. Each row has averaged variables for each subject and each activity.

## Focus
A selection of features was made by looking at those containing the following strings:
mean(): Mean value
std(): Standard deviation
The data were grouped by subject id and activity, then averaged over them.

There are 30 distinct subjects in the datasets denoted by subject_id 1 to 30. 
There are 6 different types of activities:
* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

## Variable list
The tidy data contains 6 rows (averaged based on activity) and 68 columns (66 variables and activity labels):

* "subject_id"
* "activity"
* "tBodyAcc-mean()-X"
* "tBodyAcc-mean()-Y"
* "tBodyAcc-mean()-Z"
* "tBodyAcc-std()-X"
* "tBodyAcc-std()-Y"
* "tBodyAcc-std()-Z"
* "tGravityAcc-mean()-X"
* "tGravityAcc-mean()-Y"
* "tGravityAcc-mean()-Z"
* "tGravityAcc-std()-X"
* "tGravityAcc-std()-Y"
* "tGravityAcc-std()-Z"
* "tBodyAccJerk-mean()-X"
* "tBodyAccJerk-mean()-Y"
* "tBodyAccJerk-mean()-Z"
* "tBodyAccJerk-std()-X"
* "tBodyAccJerk-std()-Y"
* "tBodyAccJerk-std()-Z"
* "tBodyGyro-mean()-X"
* "tBodyGyro-mean()-Y"
* "tBodyGyro-mean()-Z"
* "tBodyGyro-std()-X"
* "tBodyGyro-std()-Y"
* "tBodyGyro-std()-Z"
* "tBodyGyroJerk-mean()-X"
* "tBodyGyroJerk-mean()-Y"
* "tBodyGyroJerk-mean()-Z"
* "tBodyGyroJerk-std()-X"
* "tBodyGyroJerk-std()-Y"
* "tBodyGyroJerk-std()-Z"
* "tBodyAccMag-mean()"
* "tBodyAccMag-std()"
* "tGravityAccMag-mean()"
* "tGravityAccMag-std()"
* "tBodyAccJerkMag-mean()"
* "tBodyAccJerkMag-std()"
* "tBodyGyroMag-mean()"
* "tBodyGyroMag-std()"
* "tBodyGyroJerkMag-mean()"
* "tBodyGyroJerkMag-std()"
* "fBodyAcc-mean()-X"
* "fBodyAcc-mean()-Y"
* "fBodyAcc-mean()-Z"
* "fBodyAcc-std()-X"
* "fBodyAcc-std()-Y"
* "fBodyAcc-std()-Z"
* "fBodyAccJerk-mean()-X"
* "fBodyAccJerk-mean()-Y"
* "fBodyAccJerk-mean()-Z"
* "fBodyAccJerk-std()-X"
* "fBodyAccJerk-std()-Y"
* "fBodyAccJerk-std()-Z"
* "fBodyGyro-mean()-X"
* "fBodyGyro-mean()-Y"
* "fBodyGyro-mean()-Z"
* "fBodyGyro-std()-X"
* "fBodyGyro-std()-Y"
* "fBodyGyro-std()-Z"
* "fBodyAccMag-mean()"
* "fBodyAccMag-std()"
* "fBodyBodyAccJerkMag-mean()"
* "fBodyBodyAccJerkMag-std()"
* "fBodyBodyGyroMag-mean()"
* "fBodyBodyGyroMag-std()"
* "fBodyBodyGyroJerkMag-mean()"
* "fBodyBodyGyroJerkMag-std()"

## Variable types
subject_id: integer
activity: factor
all other: numeric
