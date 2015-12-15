library(plyr)
# Merge the training and test sets to create one data set
#
xtrain <- read.table("train/X_train.txt")
ytrain <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

xtest <- read.table("test/X_test.txt")
ytest <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# create 'x' data set
x_data <- rbind(xtrain, xtest)

# create 'y' data set
y_data <- rbind(ytrain, ytest)

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)

# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################

features <- read.table("features.txt")
# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
x_data <- x_data[, mean_and_std_features]

# correct the column names
names(x_data) <- features[mean_and_std_features, 2]

# Step 3
# Use descriptive activity names to name the activities in the data set
###############################################################################

activities <- read.table("activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

# Step 4
# Appropriately label the data set with descriptive variable names
###############################################################################

# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)

# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

# 66 <- 68 columns but last two (activity & subject)
avg_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(avg_data, "avg_data.txt", row.name=FALSE)
