README

BACKGROUND
This R script analyzes the HAR (Human Activity Recognition) Dataset. The analysis provides a breakdown of key variables summary statistics. The summary statistics are broken down by subject and activity ID.

FILE LIST
run_analysis.R
A script that reads in datasets from the test and train sources. The script then combines them into one dataset.
The subjects and activities are added variables to the dataset. The dataset is filtered for only the mean and std summary statistics.
The script finally produces a tidy dataset that provides the mean of the summary statistics by the sibject ID and the activity.

CodeBook.md
Document describing the libraries and functions created for use by the run_analysis.R script. Also lists the variables in the final summary analysis.

tidy_result.txt
This is the final output of the run_analysis.R script.
