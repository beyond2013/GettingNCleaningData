setwd("./")

library(plyr)
library(dplyr)

#pathtofile; text file containing data for 561 features "./train/X_train.txt"
#pathtoactivityfile;  which activity was performed "./train/y_train.txt"
#pathtosubjectfile; who (subject) performed the activity  "./train/subject_train.txt"
# This function takes 3 string arguments, each argument is the path to a text file.
# and returns a dataframe

aggregateData <- function(pathtofile, pathtoactivityfile, pathtosubjectfile){
  rows <- length(readLines(pathtofile))
  dataset <- read.table(pathtofile, sep = "" ,
                        header = FALSE ,
                        nrows = rows, na.strings = "",
                        stringsAsFactors= FALSE)
  
  features <- read.table("./features.txt", header = FALSE, stringsAsFactors = FALSE)
  
  datalabels <- features[,2]
  
  colnames(dataset) = datalabels
  
  subject <- read.table(pathtosubjectfile, sep="",
                        header = F, nrows = rows, stringsAsFactors = FALSE)
  
  dataset$subject <- subject$V1
  
  activity <- read.table(pathtoactivityfile, sep="",
                         header = F, nrows = rows, stringsAsFactors = FALSE)
  
  dataset$activity <- activity$V1
  
  return(dataset)
}


trainData <- aggregateData(pathtofile = "./train/X_train.txt",
                           pathtoactivityfile = "./train/y_train.txt",
                           pathtosubjectfile ="./train/subject_train.txt" )
testData <- aggregateData(pathtofile = "./test/X_test.txt",
                          pathtoactivityfile = "./test/y_test.txt",
                          pathtosubjectfile = "./test/subject_test.txt")

mergedData <- rbind(testData, trainData)
# part 1 done

# Collect column indicies containing "mean", "std", "subject" and "activity" using grep 
Columns <- c(grep("mean", names(mergedData)), 
                     grep("std", names(mergedData)), 
                     grep("subject", names(mergedData)),
                     grep("activity", names(mergedData)))

# Subset the mergedData to include only the mean and std columns and other columns of interest
mergedData <- mergedData[, Columns]
# part 2 done

# To use descriptive activity names factor the activity column
mergedData$activity <- factor(mergedData$activity)
# Provide levels to the factored variable as mentioned in activity_ labels.txt file
levels(mergedData) <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

#  convert subject variable to factor for later use
mergedData$subject <- factor(mergedData$subject)

# part 3 done


# Remove dash and paranthesis
names(mergedData) <- gsub("-", "", names(mergedData))
names(mergedData) <- gsub("\\()", "", names(mergedData))

# Replace initial t with time
names(mergedData) <- gsub("^t", "time", names(mergedData))

# Replace initial f with frequency
names(mergedData) <- gsub("^f", "frequency", names(mergedData))

# Replace mean with Mean
names(mergedData) <- gsub("mean", "Mean", names(mergedData))

# Replace std with StandardDeviation
names(mergedData) <- gsub("std", "StandardDeviation", names(mergedData))

# Replace BodyBody with Body
names(mergedData) <- gsub("BodyBody", "Body", names(mergedData))

# Replace Acc with Acceleration
names(mergedData) <- gsub("Acc", "Acceleration", names(mergedData))

# Replace Gyro with Gyroscope
names(mergedData) <- gsub("Gyro", "Gyroscope", names(mergedData))

# Replace Mag with Magnitude
names(mergedData) <- gsub("Mag", "Magnitude", names(mergedData))


# part 4 done

bySubjectActivity <- group_by(mergedData, subject, activity)
dataSumarry <- summarise_each(bySubjectActivity, funs(mean))
write.table(dataSummary, file="./tidyData.txt", row.names = FALSE)
# part 5 done