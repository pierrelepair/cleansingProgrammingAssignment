## Explanations on the behaviour of the run_analysis R script
The script is expecting to find a "FUCI.zip" file in its working directory.
After extraction of the zip file the script will copy usefull data files in the working directory. Those files are:
*"UCI HAR Dataset/train/X_train.txt"
*"UCI HAR Dataset/train/Y_train.txt"
*"UCI HAR Dataset/train/subject_train.txt"
*"UCI HAR Dataset/test/X_test.txt"
*"UCI HAR Dataset/test/Y_test.txt"
*"UCI HAR Dataset/test/subject_test.txt"
*"UCI HAR Dataset/features.txt"
*"UCI HAR Dataset/activity_labels.txt"
Then the features and activity files are read.
Using the features datasets as colnmaes, the training dataset is read.
The script then read the subject data corresponding to training set.
Same goes for the activities of training set.
Finally, using cbind, the subjects, activities and training dataset are merged.
Same process goes for the test data: read the dataset using features dataset for column names, read the subjects and activities data and merge data, subjects and activities.
Sample and test data are then merged using rbind.
On the resulting merged data, only subjects and activities columns are kept, along with all measures who's name refers to std or mean.
Dataset is then merged with the activities data (on activity ID) in order to get the activities labels.
Finally, the column names are normalized:
*all names set to lower case
*all dots in names are removed
and the final dataset is created by aggregate (with mean) by subject and activity.