##assign zipfile variable, obtain the zipfile, and unzip downloaded data
zipf <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipf, "./UCI-HAR-dataset.zip", method="auto")
unzip("./UCI-HAR-dataset.zip")

# 1. Merges the training and the test sets to create one data set.
##assign features, assign test.x, assign train.x, and bind to Xdata
features <- read.table("./UCI HAR Dataset/features.txt")
test.x <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
train.x <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
Xdata <- rbind(test.x, train.x)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##filter features with mean and SD, add to M_SD_stats
features <- features[grep("(mean|std)\\(", features[,2]),]
M_SD_stats <- Xdata[,features[,1]]

# 3. Uses descriptive activity names to name the activities in the data set
##assign test.y,assign train.y, bind to y, read column names, and name dataset
test.y <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c('activity'))
train.y <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))
yBind <- rbind(test.y, train.y)
Cnames <- read.table("./UCI HAR Dataset/activity_labels.txt")
for (i in 1:nrow(Cnames)) 
    {
    DSnames <- as.numeric(Cnames[i, 1])
    name <- as.character(Cnames[i, 2])
    yBind[yBind$activity == DSnames, ] <- name
    }

# 4. Appropriately labels the data set with descriptive activity names. 
##assign xNames and bind to M_SD_statsNames
xNames<- cbind(yBind, Xdata)
M_SD_statsNames <- cbind(yBind, M_SD_stats)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##assign testSubject, trainSubject, row bind to subject, calc average, and output results
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))
subject <- rbind(testSubject, trainSubject)
averages <- aggregate(Xdata, by = list(activity = yBind[,1], subject = subject[,1]), mean)
if (file.exists("./results.csv"))
    {
    file.remove("./results.csv")
    }

write.csv(averages, file="./results.txt", row.names=FALSE)
