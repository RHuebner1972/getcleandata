## How to transform the data set into a tidy data set.

There are 5 parts:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How ```run_analysis.R``` implements the above steps:

* Require ```plyr``` library.
* Load both test and train data using read.table.
* Load the features and activity labels.
* Extract the mean and standard deviation column names and data.
* Process the data using ddply function, which gets the means for columns 1 through 66. There are two parts processing test and train data respectively.
* Merge data set.
