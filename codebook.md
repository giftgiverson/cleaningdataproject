# Codebook

# Analysis
There are two folders, one for testing and one for training. Each folder
contains:
* X_data file which holds measurements
* Y_data file which holds the correspinding activity ID
* subject file which holds the correspinding
In the root directory there are label files for measurements and activities.

All the above files are formatted as rows of data without headear and in a
table format, which preciselt matches the format read.table requires.

After reading the files into data-frames, it is possible to create a single
data-frame which contains all the measurements from both subfolders, with
matching activities and subjects.

The resulting data-frame can then be summarizes to show the mean for each
varialbe containing the measurement's means and standard-deviations.

The end result is a tidy data-frame containing the above means for
the cartesian product of Activities and Subjects.

# Tidy varialbes' descriptions:
activity: Activity name [WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,
	SITTING, STANDING, LAYING]
subject_id: ID of the test-subject [1:30]
mean and standard-deviation summary of mean by activity and subject:
	['-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.]
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
	The mean summary is indicated by the .mean.. postfix, while the
	standard-deviation summary is indicated by the .std... suffix.