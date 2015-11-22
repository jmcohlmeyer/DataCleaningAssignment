# Introduction
The script cleaningdata-assignment.R performs the 5 steps described in the course project's definition.
* A file was download from a file (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) then it was assigned variable and unzipped downloaded data.

* Then, the data are merged using the rbind() function.  
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt.
* As activity data is addressed with values, the activity names and IDs were obtained from activity_labels.txt and they are substituted in the dataset.
* Finally, we generate a new dataset with all the average measures for each subject and activity type. The output file is called results.txt, and uploaded to this repository.

# Variables
* train.x, train.y, test.x, test.y, trainSubject and testSubject contain the data from the downloaded files.
* xData, yBind and Cnames merge the previous datasets to further analysis.
* features contains the correct names for the xData dataset, which are applied to the column names stored in M_SD_stats, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the activities variable.
* xNames merges xData, yBind and M_SD_stats in a big dataset.
* Finally, averages contains the relevant averages which will be later stored in a .txt file (results.txt). 