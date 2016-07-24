# Code Book for AccelerationData.csv and MeanAccelerationData.csv.

The raw data was obtained from the following source:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and the following link to a detailed description of the raw data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This raw data contained two separate datasets, the /train and the /test datasets.  

Step1:  We combined the train and test data into a single format, since both raw datasets had the same basic format.

Step2:  From this merged dataset, we extracted the mean acceleration in all 3 cartesian coordinates (X,Y,Z) and the associated standard deviation 
in all 3 cartesian coordinates (X,Y,Z).

Step3:  We then produced a clean dataset from the raw data that included the subject number, the string for the activity level, and all 6 numerical
measurements outlined in Step 2.  This sub-selection of the rawdata was saved as AccelerationData.csv

Step4:  Creating the MeanAccelerationData.csv.  For each subject, we isolated the data for each of the six activities: (WALKING, WALKING_UPSTAIRS,
WALKING_DOWNSTAIRS, STANDING, SITTING, and LAYING).  This gave us all o the accelereation data for a single subject for a single activity.  This
sub-selectino of data was then averaged to produce at Totalmeanacceleration for that subject and that activity, as well as a mean
standard deviation for that subject doing that activity.  This averaged data was then writtin out to MeanAccelerationData.csv.
