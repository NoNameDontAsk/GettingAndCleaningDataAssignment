#Download and unzip the dataset:
filename <- "Getting And Cleaning Data Assignment Dataset.zip"

if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename)
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

#Create a dataset called "features_dataset" using "features.txt"
features_dataset <- read.table("UCI HAR Dataset/features.txt")

#Remove the first column in "features_dataset"
features_dataset <- features_dataset[,2]

#Create a dataset called "test_dataset" using "X_test.txt"
test_dataset <- read.table("UCI HAR Dataset/test/X_test.txt")

#Label the columns in "test_dataset" using "features_dataset"
names(test_dataset) <- features_dataset

#Create a dataset called "test_activity_dataset" using "y_test.txt"
test_activity_dataset <- read.table("UCI HAR Dataset/test/y_test.txt")
names(test_activity_dataset) <- "ActivityInfo"

#Create a dataset called "test_subject_dataset" using "subject_test.txt"
test_subject_dataset <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(test_subject_dataset) <- "SubjectID"

#Append subject and activity information to "test_dataset"
test_dataset <- cbind(test_subject_dataset,test_activity_dataset,test_dataset)

#Create a dataset called "train_dataset" using "X_train.txt"
train_dataset <- read.table("UCI HAR Dataset/train/X_train.txt")

#Label the columns in "train_dataset" using "features_dataset"
names(train_dataset) <- features_dataset

#Create a dataset called "train_activity_dataset" using "y_train.txt"
train_activity_dataset <- read.table("UCI HAR Dataset/train/y_train.txt")
names(train_activity_dataset) <- "ActivityInfo"

#Create a dataset called "train_subject_dataset" using "subject_train.txt"
train_subject_dataset <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(train_subject_dataset) <- "SubjectID"

#Append subject and activity information to "train_dataset"
train_dataset <- cbind(train_subject_dataset,train_activity_dataset,train_dataset)

#1. Merges the training and the test sets to create one data set
combined_dataset <- rbind(test_dataset,train_dataset)

#2. Extracts only the measurements on the mean and standard deviation for each measurement
combined_dataset_2 <- combined_dataset[,c(1,2,grep("-mean\\()|-std\\()", names(combined_dataset)))]

#3. Uses descriptive activity names to name the activities in the data set
library(dplyr)
combined_dataset_2$DescriptiveActivityInfo <- factor(combined_dataset_2$ActivityInfo, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

# 4. Appropriately labels the data set with descriptive variable names. 
names(combined_dataset_2) <- gsub("^t", "TimeDomain", names(combined_dataset_2))
names(combined_dataset_2) <- gsub("^f", "FrequencyDomain", names(combined_dataset_2))
names(combined_dataset_2) <- gsub("Acc", "Accelerometer", names(combined_dataset_2))
names(combined_dataset_2) <- gsub("Gyro", "Gyroscope", names(combined_dataset_2))
names(combined_dataset_2) <- gsub("Mag", "Magnitude", names(combined_dataset_2))
names(combined_dataset_2) <- gsub("BodyBody", "Body", names(combined_dataset_2))

# 5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
melted <- melt(combined_dataset_2, id.vars = c('SubjectID', 'DescriptiveActivityInfo', 'ActivityInfo'))
tidydataset <- dcast(melted, SubjectID+DescriptiveActivityInfo~variable, mean)