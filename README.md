# Coursera-Data-Cleaning-Programming-Assignment
Final programming assignment for the Coursera JHU Cleaning data course

This directory contains three files:

(1) run_analysis.R, which is the R-script that will produce the tidy datasets.

(2) AccelerationData.csv contains the unabridged data from the Mobile devices.  In this file are 8 total variables:
   Each row contains accelerometer data taken from the Samsung smartphone during different activities.  There were 30 unique subjects (persons) participating in this experiement, and 6 categories of activity:  WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, STANDING, LAYING, and SITTING.  Each row represnents a single measurement in time for each of the following eight parameters
     (i) subject:  the number identifying the person (subject) from which the data was taken
    (ii) activity:  the string describing which of 6 activities being measured.
   (iii) meanaccelX:  The mean of the x-direction acceleration measured by the accelerometer.
    (iv) meanaccelY:  Same as (iii) but for y-direction.
     (v) meanaccelZ:   Same as (iii) and (iv) but for z-direction.
    (vi) stddevX:     The standard deviation of the X-direction acceleration during this time interval.
   (vii) stddevY:     The standard deviation of the Y-direction acceleration during this time interval.  
  (viii) stddevZ:    The standard deviatoin of the Z-direction acceleration during this time interval.
  
  (3) MeanAccelerationData.csv is an abriged version of (2) above.  For each subject and activity level, a unique mean value for the accelerations and standard deviations are formulated.  These are summarized as follows.
     (i) subject:    the number identifying the person (subject) from which the data was taken
    (ii) activity:   the string describing which of 6 activities being measured.
   (iii) TotalmeanaccelX:  This represents the mean of all time-intervals for the subject in (i) for the activity in (ii).  Thus this is a "mean of means" for this subject and this activity.
    (iv) TotalmeanaccelY:  Same as (iii) but for y-direction.
     (v) TotalmeanaccelZ:   Same as (iii) and (iv) but for z-direction.
    (vi) MeanstddevX:     This is the mean of the standard deviations of the acceleration for the subject in (i) and the activity in (ii).  This is a mean of standard deviations.  
   (vii) MeanstddevY:    same as (vi) but for y-direction. 
  (viii) MeanstddevZ:    same as (vi) but for z-direction.
