# GettingNCleaningData
I have provided sufficient comments inside the run_analysis.R but for the sake of completeness I will describe here what the script does

1. The script assumes that working directory is set to "UCI HAR Dataset" 
2. Loads the **plyr** and **dplyr** packages
3. Similar steps are needed to assemble text files of train and test data into a data frame
 1. A function **aggregateData** is defined
 2. **aggregateData** takes 3 strings as arguments, and returns the assembled dataframe
 3. path to file - text file containing numeric values for 561 features **e.g. "./train/X_train.txt"**
 4. path to activity file;  which activity was performed **e.g. "./train/y_train.txt"**
 5. path to subject file; who (subject) performed the activity **e.g. "./train/subject_train.txt"**
4. The function **aggregateData** is called twice to create **trainData** and **testData** dataframes
5. rbind is used to merge the two dataframes trainData and testData into mergedData
6. **grep()** is used to identify the column of interest i.e. column containing mean and standard deviation measurements
7. Unwanted variables of mergedData have been removed by sub setting
8. **activity** and **subject** variables have been converted to factors
9. **gsub()** has been repeatedly used to remove dash and paranthesis from variable names. **Since most variable names contain more than one word, first letter of each word is capital for maintaining readability**
10. **group_by()** has been used to group merged data by subject and activity
11. **summarise_each()** has been used to calculate average of each measurement
12. **write.table()** writes the summarised data to file **tidyData.txt**
