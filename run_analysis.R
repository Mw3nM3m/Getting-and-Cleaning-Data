library(dplyr)

#========================================================================================================#
#                                       Test Part
#========================================================================================================#

# Reading test set data from X_test.txt
testDataSet<- read.table("./UCI/test/X_test.txt")

# Reading features to get descriptive variables names describing the action the variable is recording
feat <- read.table("./UCI/features.txt")

# Putting the features into a vector to have the variables names to then clip on to the data set
observations <- c(as.character(feat[,2]))

# Give a name to each features (observations) in vector
names(observations) <- c(observations)

# Put names on each observations of the data set, the variable names
colnames(testDataSet) <- observations

# Subsetting the observations by name having only the "mean" or "std" as part of it
testMeanActivities <- subset(testDataSet, select = c(grep("mean", colnames(testDataSet))))
testStdActivities <- subset(testDataSet, select = c(grep("std", colnames(testDataSet))))

# Clipping mean and std observations together
testFullActivities <- cbind(testMeanActivities, testStdActivities)



# Reading the test activities done by subjects
testActivities<- read.table("./UCI/test/y_test.txt")

# Reading the activity names done in experiment
labels<- read.table("./UCI/activity_labels.txt")

# Renaming activities according to the activity labels
testNamedActivities <- data.frame(testActivities)
colnames(testNamedActivities) <- "activity"
for(i in 1:nrow(testNamedActivities)) {
    testNamedActivities$activity[i] <- as.character(labels[testActivities[i,],2])
}


# Clipping the named activities with the test data set observations putting the activities in front
testNamedActivities <- cbind(testNamedActivities, testFullActivities)

# Reading the test subjects
testSubjects<- read.table("./UCI/test/subject_test.txt")
colnames(testSubjects) <- "subjectID"

# Clipping the subjects with rest of the data frame
testActivities <- cbind(testSubjects, testNamedActivities)

# Adding the subjectID and activity column names in front of the rest of data frame (testActivities) 
# to have the full test data frame. Example :
#
#$ subjectID                      : int  2 2 2 2 2 2 2 2 2 2 ...
#$ activity                       : chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
#$ tBodyAcc-mean()-X              : num  0.257 0.286 0.275 0.27 0.275 ...
#$ tBodyAcc-mean()-Y              : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
#$ tBodyAcc-mean()-Z              : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
#$ tGravityAcc-mean()-X           : num  0.936 0.927 0.93 0.929 0.927 ...
#$ tGravityAcc-mean()-Y           : num  -0.283 -0.289 -0.288 -0.293 -0.303 ...
#$ ...
columnsNames <- c(names(testActivities)[1], names(testActivities)[2])
columnsNames <- c(columnsNames, observations)
     
#========================================================================================================#
#                                       Train Part
#========================================================================================================#

# Reading train set data from X_train.txt
trainDataSet <- read.table("./UCI/train/X_train.txt")

# Put names on each observations of the data set, the variable names
colnames(trainDataSet) <- observations

# Subsetting the observations by name having only the "mean" or "std" as part of it
trainMeanActivities <- subset(trainDataSet, select = c(grep("mean", colnames(trainDataSet))))
ttraintdActivities <- subset(trainDataSet, select = c(grep("std", colnames(trainDataSet))))

# Clipping mean and std observations together
trainFullActivities <- cbind(trainMeanActivities, ttraintdActivities)

# Reading the train activities done by subjects
trainActivities<- read.table("./UCI/train/y_train.txt")

# Reading the train subjects
trainSubjects<- read.table("./UCI/train/subject_train.txt")
colnames(trainSubjects) <- "subjectID"


# Naming activities according to the activity labels
trainNamedActivities <- data.frame(trainActivities)
colnames(trainNamedActivities) <- "activity"
for(i in 1:nrow(trainNamedActivities)) {
    trainNamedActivities$activity[i] <- as.character(labels[trainActivities[i,],2])
}

# Clipping the activities with the train data set
# putting the activities in front
trainNamedActivities <- cbind(trainNamedActivities, trainFullActivities)

# Clipping the subjects with rest of the data frame
trainActivities <- cbind(trainSubjects, trainNamedActivities)


#========================================================================================================#
#                                       Merging Part
#========================================================================================================#

mergedActivities <- rbind(testActivities, trainActivities)
mergedActivities <- arrange(mergedActivities, subjectID)

#========================================================================================================#
#                                       Average Part
#========================================================================================================#
meanActivities <- aggregate(mergedActivities[, 3:ncol(mergedActivities)], list(mergedActivities$activity, mergedActivities$subjectID), mean)

#meanActivities <- arrange(meanActivities, Group.2)

