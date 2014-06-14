# Getting and Cleaning Data: Course Project

## Background

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone 
Up are racing to develop the most advanced algorithms to attract new users. The data linked to the course website represent 
data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site 
where the data was obtained: 

	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities 
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) 
on the waist. Using its embedded accelerometer and gyroscope, researchers captured 3-axial linear acceleration and 3-axial angular velocity 
at a constant rate of 50Hz. The experiments were video-recorded to label the data manually.  The obtained dataset was randomly partitioned 
into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows 
of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, 
was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency 
components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables 
from the time and frequency domain. 

The course project includes cleaning the resulting data from the study, calculating the average for the mean and standard deviation variables
provided in the original raw data, and producing a tidy dataset of the results.

## Deliverables

- a ReadMe.md file that describes the project (document you are reading)
- a Code Book describing the variables, the data and any work done to provide a tidy dataset
- an R function called run_analysis.R used to create the tidy dataset (see description below)
- a tidy dataset called tidymean.txt resulting from the script

## Creating the tidymean dataset

The raw data for the course project can be found at: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The raw dataset includes the following files in a txt format; these files were used to create 
the tidymean dataset described under the "Deliverables" section below:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Prior to running the run_analysis.R script, the raw files above should be unzipped into a folder in your working directory titled "UCI HAR Dataset"
(including the subfolders "train" and "test" as described in the files above).  The packages "reshape2" and "utils" should also be installed.

The run_analysis.R function performs the following actions:

- loads the applicable packages
- initiates a progress bar to monitor the script's status
- identifies the appropriate file path and reads the text files into dataframes
- creates and adjusts variable names to avoid problematic characters
- combines and labels the dataframes, including subject and activity variables
- labels the factors under the activity variable appropriately
- pulls only those variables identified by the project scope into a dataframe
- removes unnecessary dataframes and values to free up memory
- reshapes and calculates the average of the numeric variables based on subject + activity
- exports the resulting tidymean dataset into the original unzipped folder as a comma-delimited "tidymean.txt" file

## Attributions (raw dataset)

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones 
using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012.

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use 
or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.




