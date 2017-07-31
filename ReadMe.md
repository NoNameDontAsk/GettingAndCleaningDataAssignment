# Getting and Cleaning Data Course Project
## Repository Structure
> - ReadMe.md - contains some basic information about this repo
> - Codebook.md - contains the descriptions for the variables in "tidydataset"
> - run_analysis.R - contains the codes used to transform the original given dataset to "tidydataset"
> - tidydataset.txt - contains the output dataset from run_analysis.R

## Transformations on the Original Dataset (using run_analysis.R)
	1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names.
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.