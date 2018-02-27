## CODEBOOK

The UCI HAR dataset breaks down accelerometer and gyroscopic measurements on 30 subject performing 6 different activities.
(Please see the features_info.txt for more information about all the measurements taken and their description.)

There are also two datasets that need to be combined: Test and Train datasets.

Of the many different summary statistics on the data (in both data sets) the peer-reviewed project only requires the mean and std
summary statistics.

The stringr, plyr and dplyr packages were loaded.

The data sets were brought into R via readLines. 

Functions were created to 
  1. Grab the second element in a list of atomic vectors
  2. Apply the second element function and produce a vector instead of a list
  3. Turn the attribute data matrix of characters into a data frame of numeric class.
  4. To add multiple variables to a data frame at one time.
  
All code in R script is commented with the step that required by the peer review assignment.

From the UCI HAR 'features_info.txt' document:

-tBodyAcc-XYZ
-tGravityAcc-XYZ
-tBodyAccJerk-XYZ
-tBodyGyro-XYZ
-tBodyGyroJerk-XYZ
-tBodyAccMag
-tGravityAccMag
-tBodyAccJerkMag
-tBodyGyroMag
-tBodyGyroJerkMag
-fBodyAcc-XYZ
-fBodyAccJerk-XYZ
-fBodyGyro-XYZ
-fBodyAccMag
-fBodyAccJerkMag
-fBodyGyroMag
-fBodyGyroJerkMag