# Getting and Cleaning Data - Course

-------------------------------------------------------------------------

##Preparation

1. **Download** the file and extracted if is require under de folder `UCI HAR Data set`

-------------------------------------------------------------------------

## Assing variables

1. `trainX`<- `./train/X_train.txt`: 7352x561 contains recorded features train data

2. `trainY`<- `./train/Y_train.txt`: 7352x1 contains train data recorded labeled by activity 

3. `testX`<- `./test/X_test.txt`: 2947x561 contains recorded features test data

4. `testY`<- `./train/Y_train.txt`: 2947x1 contains test data recorded labeled by activity 

5. `Subject_test`<- `./test/subject_test.txt`: 2947x1 contains recorded features test data

6. `Subject_train`<- `./train/subject_train.txt`: 7352x1 contains recorded features test data

7. `act` <- `activity_labels.txt`: 6x2 contains id and names of the activity 


-------------------------------------------------------------------------

## Merges the training and the test sets to create one data set

1.`X` (10299x561) is created by merging `trainX` and `testX`

2.`Y` (10299x1) is created by merging `trainY` and `testY`

3.`Subject`(10299x1) is created by merging `Subject_train` and `Subject_test`


-------------------------------------------------------------------------


##Extracts only the measurements on the mean and standard deviation for each measurement.


1.`filtrado` (10299x86) is created by subsetting `X`, selecting only columns the measurements on the mean and standard deviation (std) for each measurement


-------------------------------------------------------------------------

##Appropriately labels the data set with descriptive variable names.



- All `.mean`and `mean` in column's name replaced by `Mean`

- All `.std` and `std` in column's name replaced by `Std`

- All `Acc` in column's name replaced by `Accelerometer`

- All `Gyro` in column's name replaced by `Gyroscope`

- All `BodyBody` in column's name replaced by `Body`

- All `Mag` in column's name replaced by `Magnitude`

- All start with character `f` in column's name replaced by `Frequency`

- All start with character `t` in column's name replaced by `Time`


-------------------------------------------------------------------------

##Merge activity, data and subject



1.`filtrado` (10299x562) is created by merging `filtrado` ,`Y`, `Subject`


-------------------------------------------------------------------------

##Uses descriptive activity names to name the activities in the data set

1.Entire numbers in `activity` column of the `filtrado` replaced with corresponding activity taken from second column of the `act` variable

-------------------------------------------------------------------------

##Creates a independent tidy data set with the average of each variable for each activity and each subject

Created `meltData`  reshaped  `filtrado` by activity and subject

summarized to obtain the mean for each variable of the data and assing to `tidyData` using `meltData`
