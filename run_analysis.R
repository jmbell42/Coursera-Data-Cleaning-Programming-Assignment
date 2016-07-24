## This Code will ingest two larger datasets (train and test) and create
## a clean dataset from the average and standard deviations of the measurements
## in those datafiles.

## Load in key packages
library(dplyr)

#Step1: Get the descriptive activity labels

activityframe <- read.csv("./UCIHARDataset/activity_labels.txt",header=FALSE,nrows =6)
activitylist <- as.character(activityframe$V1)   ## Grab the string of activity names
splitNames <- strsplit(activitylist, " ")        ## Split the strings up to isolate the activity labels
labelelement <- function(x){x[2]}                ## Grab the 2nd element--> has the activity labels
numberelement <- function(x){x[1]}               ## Grab the 1st element -> has activity number
activitylabels <- sapply(splitNames,labelelement)## Apply this to all of the list elements
activitynumber <- sapply(splitNames,numberelement)
## activitylabels is now a string array with our activities.

## Step 2:  Next, we read in the data in the /train Directory
SubjectTrain <- read.table("./UCIHARDataset/train/subject_train.txt")  ## Identifies which subject provided the data
Xtrain <- read.table("./UCIHARDataset/train/X_train.txt")              ## Data Table with 7352 rows and 561 columns
Ytrain <- read.table("./UCIHARDataset/train/y_train.txt")              ## Data Table identifying the Type of activity

## Step 3:  Next, we read in the data in the /test Directory
SubjectTest <- read.table("./UCIHARDataset/test/subject_test.txt")  ## Identifies which subject provided the data
XTest <- read.table("./UCIHARDataset/test/X_test.txt")              ## Data Table with rows and columns
YTest <- read.table("./UCIHARDataset/test/y_test.txt")              ## Data Table identifying the Type of activity

## Step4:  Next, Join the Test and Train data into a single, Merged Data.
##         Use the rbind function to simply join these two tables.
SubjectMerged <- rbind(SubjectTrain,SubjectTest)
SubjectVector <- as.numeric(SubjectMerged[,1])  # Pull these out as numeric values
XMerged <- rbind(Xtrain,XTest)                    # Join both X-tables together
YMerged <- rbind(Ytrain,YTest)                    # Similarly, join both Y-tables together
YVector <- as.numeric(YMerged[,1])                # Pull out the Activity Data in a 1-D Vector
ActivityVector <- activitylabels[YVector]         # Grab Description of Activity Values

## Step5:  Next, we extract only the relevant data from X-Table:  Mean (X,Y,Z) 
##                                        and Standard Deviation(X,Y,Z)
## These Variables are stored in the first 6 columns of our data
AccelerationData <- cbind(ActivityVector, XMerged[,1:6])  # Mean X-direction Acceleration

## Also we should add another column with the Subject.
AccelerationData <- cbind(SubjectVector,AccelerationData)

# These are our varible names for the data.frame Acceleration Data.
datanames = c("subject", "activity", "meanaccelX","meanaccelY", "meanaccelZ", "stddevX", "stddevY", "stddevZ")
colnames(AccelerationData) <- datanames

write.csv(AccelerationData, file = "AccelerationData.csv", col.names = TRUE)

## Step 6:  Create a tidy Dataset for each subject for each activity:
## Format will be Subject #  1-6 Activities with Mean and StdDev (12 columns)
uniquesubjects <- sort(as.numeric(unique(AccelerationData$subject)))  # Get unique subjects
numberofsubjects <- length(uniquesubjects)   # Count the number of subjects

###### CREATE A SECOND TIDY DATASET:
### Must have mean of each acceleration and Stdev for each subject for each activity.
### Organize this by column1:  subject, column2 activity, columns3 - 8 the means of each measurment
# First iterate over our subjects

meandatanames = c("subject", "activity", "TotalmeanaccelX","TotalmeanaccelY", "TotalmeanaccelZ", "MeanstddevX", "MeanstddevY", "MeanstddevZ")

# Initialize our combined data.frame
MeanData <- data.frame(1,"WALKING",0.0,0.0,0.0,0.0,0.0,0)
colnames(MeanData) <- meandatanames

for (isub in seq(uniquesubjects)){
     subjdata <- filter(AccelerationData, subject == isub)  # Pull out each subjects data
     
     for (iact in seq(activitylabels)){
       subactdata <- filter(subjdata, activity == activitylabels[iact])  # Pull out each activity 

        ## Now pull out the means of each measurement for each subject and each activity
        submeanx <- mean(subactdata$meanaccelX)
        submeany <- mean(subactdata$meanaccelY)
        submeanz <- mean(subactdata$meanaccelZ)
       #
        submeanstddevx <- mean(subactdata$stddevX)
        submeanstddevy <- mean(subactdata$stddevY)
        submeanstddevz <- mean(subactdata$stddevZ)
        subject = isub
        activity = activitylabels[iact]
        TotalmeanaccelX = submeanx
        TotalmeanaccelY = submeany
        TotalmeanaccelZ = submeanz
        MeanstddevX = submeanstddevx
        MeanstddevY = submeanstddevy
        MeanstddevZ = submeanstddevz
        
        subframe = data.frame(subject,activity,TotalmeanaccelX,TotalmeanaccelY,TotalmeanaccelZ,MeanstddevX, MeanstddevY, MeanstddevZ)
        if(isub == 1 && iact == 1){
          MeanData <- subframe   # The first iteration is special (start the data frame)
          
         }else{
          MeanData <- rbind(MeanData,subframe)  # For all other iterations, build up a new data frame
        }
     }
}

write.csv(MeanData, file = "MeanAccelerationData.csv", col.names = TRUE)