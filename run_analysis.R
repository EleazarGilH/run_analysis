##### Getting and cleaning data - project
## read data
setwd("/Users/egil/Documents/DataAnalysisCoursera/UCI HAR Dataset")
features <- read.table("features.txt") ## 561 rows (features)
train <- read.table("train/X_train.txt") #7352 obs x 561 variables (features)
test <- read.table("test/X_test.txt") #2947 obs x 561 variables (features)
subject_train <- read.table("train/subject_train.txt") #7352 obs
subject_test <- read.table("test/subject_test.txt") #2947 obs
activity_train <- read.table("train/y_train.txt") #7352 obs, activities: 1..6
activity_test <- read.table("test/y_test.txt") #2947 obs, activities: 1..6
activity_names <- read.table("activity_labels.txt") # 6 activities

## 1. merging training and test sets
data1 <- rbind(train,test) #10299 obs x 561 variables (features)
subjects <- rbind(subject_train,subject_test) #10299 obs
names(subjects) <- c("subject")
activity <- rbind(activity_train, activity_test) #10299 obs

## 2. Extract only the columns corresponding to the mean and std features
### the column indexes are in the features data frame
selected_features <- grep("std|mean",features[,2]) ## 79 columns
names_features <- as.factor(as.character(features[selected_features,2]))
data2<- data1[,selected_features] #10299 obs 79 variables (features mean/std)
names(data2)<- names_features

## 3. Uses descriptive activity names to name the activities in the data set
activity2 <- merge(activity, activity_names, by.x = "V1", by.y = "V1", all.x= T)
names(activity2) <- c("id","activity")
## 4. Appropriately labels the data set with descriptive activity names. 
### add activity column and subject column to the dataset
data3 <- cbind(subjects,data2,activity2$activity)
names(data3)[81]<- "activity"
#data3$subject<- as.factor(as.character(data3$subject))
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
aggdata3<- aggregate (data3, by=list(data3$subject,data3$activity), FUN = mean,na.rm=T)
### selecting the appropiate columns
tidy_data <- aggdata3[,c(1,2,4:82)]
names(tidy_data)[1]<-"subject"
names(tidy_data)[2]<-"activity"
tidy_data <- tidy_data[order(tidy_data$subject),]
write.table(tidy_data, file = "./tidydata.txt")
