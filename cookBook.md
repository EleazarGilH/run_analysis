Cookbook
========================================================

First the script read the data from the training and test sets for all tables: data, subjects, activities and futures

For question 1, it merge the training and test sets for data, subjects and activities

For question 2, I used the grep funtion to select the features containing the words mean and std. Then create data2 with only those columns

For question 3, I merge the activity numbers and names using the merge function

For question 4, I combine the subject, features and activity names in a data set called data3

For question 5, I use the fuction aggregate over the subjects and activity columns and generate the tidydataset


