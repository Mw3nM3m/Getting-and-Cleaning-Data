==================================================================
Getting and Cleaning Data class project 
Version 1.0
==================================================================
Boris Chatelain
==================================================================

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis.

The data set on which we had to work is based on the following experiment :

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."

The 30 volunteers measurements and activities were broken in different files.  Mainly, 'test' and 'train' files.  In test were 9 volunteers measures and activities and in train, 21.

Here is the description of what data was found in each files :
=========================================

- 'features.txt': List of all features that were measured.
	The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
	These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

		tBodyAcc-XYZ
		tGravityAcc-XYZ
		tBodyAccJerk-XYZ
		tBodyGyro-XYZ
		tBodyGyroJerk-XYZ
		tBodyAccMag
		tGravityAccMag
		tBodyAccJerkMag
		tBodyGyroMag
		tBodyGyroJerkMag
		fBodyAcc-XYZ
		fBodyAccJerk-XYZ
		fBodyGyro-XYZ
		fBodyAccMag
		fBodyAccJerkMag
		fBodyGyroMag
		fBodyGyroJerkMag
	
	On those measurement of X, Y and Z axis, we only kept a set of variables that were estimated from the above signals : the mean and standard deviation.
		
- 'activity_labels.txt': The class labels with their activity name (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

- 'y_train.txt': Training labels.
	Contains the labels of the activity in 'activity_labels.txt' that were performed by each subject from the 'train' group.
	Each row identifies the activity that was performed.
	
- 'y_test.txt': Test labels.
	Contains the labels of the activity in 'activity_labels.txt' that were performed by each subject from the 'test' group.
	Each row identifies the activity that was performed.

- 'subject_train.txt': Train subject ID
	Contains the ID of each subject in group 'train' that performed every activity for every measurement. There is a 1-to-1 relationship between this file and 'y_train.txt'
	Each row identifies the subject who performed the activity for each window sample.

- 'subject_test.txt': Test subject ID
	Contains the ID of each subject in group 'test' that performed every activity for every measurement. There is a 1-to-1 relationship between this file and 'y_test.txt'
	Each row identifies the subject who performed the activity for each window sample.
	
- 'X_train.txt': Training set.
	Contains all measurements for every subject doing every activity from the 'train' group.

- 'X_test.txt': Test set.
	Contains all measurements for every subject doing every activity from the 'test' group.

	
The goal of this project is the following :
======================================
You should create one R script called run_analysis.R that does the following: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.	

Steps accomplished to achieve the goal of this project :
======================================

A. First, files containing information on the test subjects group were used
	
	1. Reading measurements test data set from X_test.txt, reading the observations.

    2. Reading features to get descriptive variables names describing the action of what the variable is recording
	   to later clip them on the observation.

    3. Putting the features into a vector to have the variable names to then clip them on to the observations.

	4. Giving a name to each columns (observations) in vector of step 3.

	5. Using vector to put names on each observations of the test data set. Adding column names to each observations in same
	   data structure.

	6. Subsetting the observations by name keeping only the features having "mean" or "std" as part of the name.
	   Here a 'grep' was produced to only keep the wanted observations.
	   One pass was done for the mean, another for the standard deviation.

	7. Clipping mean and std observations together.

	8. Reading the test activities done by subjects

	9. Reading the activity list name done in experiment

	10. Naming the activities done by subjects according to the activity labels

	11. Clipping the named activities with the test data set (observations) putting the activity name in front 
		of every observation.

	12. Reading the test subjects ID

	13. Clipping the subject ID with the named activities.  

	14. Adding the subjectID and activity column names in front of the rest of data frame (testActivities) 
		to have the full test data frame. Example :

		$ subjectID                      : int  2 2 2 2 2 2 2 2 2 2 ...
		$ activity                       : chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
		$ tBodyAcc-mean()-X              : num  0.257 0.286 0.275 0.27 0.275 ...
		$ tBodyAcc-mean()-Y              : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
		$ tBodyAcc-mean()-Z              : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
		$ tGravityAcc-mean()-X           : num  0.936 0.927 0.93 0.929 0.927 ...
		$ tGravityAcc-mean()-Y           : num  -0.283 -0.289 -0.288 -0.293 -0.303 ...
		$ ...

     
B. Second, files containing information on the train subjects group were used.

	Repeat steps 1 to 14 for train files instead of test files.


C. Third, merging test data frame and train data frame into only one. Sort by subject ID (1 to 30)

D. Forth, creating a second, independent tidy data set with the average of each variable for each activity and each subject.


