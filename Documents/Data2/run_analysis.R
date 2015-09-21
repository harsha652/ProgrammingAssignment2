library(plyr)
# Merge the training and test sets to create one data set
###############################################################################

x_test_data <- read.table("C:/Users/155846/Desktop/Desktop/UCI HAR Dataset/test/X_test.txt") # Read X_test file
y_test_data <- read.table("C:/Users/155846/Desktop/Desktop/UCI HAR Dataset/test/y_test.txt") # Read y_test file
subject_test_data <- read.table("C:/Users/155846/Desktop/Desktop/UCI HAR Dataset/test/subject_test.txt")

x_train_data <- read.table("C:/Users/155846/Desktop/Desktop/UCI HAR Dataset/train/X_train.txt")  #Read X_train file
y_train_data <- read.table("C:/Users/155846/Desktop/Desktop/UCI HAR Dataset/train/y_train.txt")  #Read y_train file
subject_train_data <- read.table("C:/Users/155846/Desktop/Desktop/UCI HAR Dataset/train/subject_train.txt")

x_data <- rbind(x_test_data, x_train_data)  #Row merge x_test_data and x_train_data
y_data <- rbind(y_test_data, y_train_data)  #Row merge y_test_data and y_train_data
subject_data <- rbind(subject_test_data, subject_train_data) #Row merge subject_test_data and subject_train_data

# Extract only the measurements on the mean and standard deviation for each measurement
###########################################################################################

features <- read.table("C:/Users/155846/Desktop/Desktop/UCI HAR Dataset/features.txt")  #Read Features file

features_mean_SD <- grep("-(mean|std)\\(\\)", features[, 2])  # Extract columns related to  mean and std

x_data <- x_data[,features_mean_SD]   # Extract only mean and std columns

names(x_data) <- features[features_mean_SD,2]   #Update Column names


# Use descriptive activity names to name the activities in the data set
###############################################################################

activities <- read.table("C:/Users/155846/Desktop/Desktop/UCI HAR Dataset/activity_labels.txt")  #Read activity labels file

y_data[, 1] <- activities[y_data[, 1], 2]     #Update values with activity names

names(y_data) <- "activity"           #Update Column name as activity


# Appropriately label the data set with descriptive variable names
###############################################################################

names(subject_data) <- "subject"     # Update the column name as subject

all_data <- cbind(x_data, y_data, subject_data)    #CBind all the data sets

# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))  #Exclude activity and subject columns

write.table(averages_data, "averages_data.txt", row.name=FALSE)

	