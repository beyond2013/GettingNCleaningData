# GettingNCleaningData
I have provided sufficient comments inside the run_analysis.R but for the sake of completeness I will describe here what the script does

1. The script assumes that working directory is set to "UCI HAR Dataset" 
2. Loads the **plyr** and **dplyr** packages
3. Similar steps are needed to assemble text files of train and test data into a data frame
 .. 1. A function **aggregateData** is defined
 .. 2. **aggregateData** takes 3 strings as arguments
 .. 3. path to file - text file containing numeric values for 561 features "./train/X_train.txt"
