if(!dir.exists("Data")){dir.create("Data")}

#Downloading data
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,"./Data/Dataset.zip")
unzip("./Data/Dataset.zip", exdir = "./Data")

#Reading test and train files
x_train <- read.table("./Data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./Data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./Data/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./Data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./Data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./Data/UCI HAR Dataset/test/subject_test.txt")

#Reading features and activity labels
features <- read.table('./Data/UCI HAR Dataset/features.txt')
activity_labels = read.table('./Data/UCI HAR Dataset/activity_labels.txt')

#Assigning column names
colnames(x_train) <- features[,2]
colnames(y_train) <-"Activity_Id"
colnames(subject_train) <- "Subject_Id"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "Activity_Id"
colnames(subject_test) <- "Subject_Id"

colnames(activity_labels) <- c('Activity_Id','Activity_Type')

#Merging data:

train_merged <- cbind(y_train, subject_train, x_train)
test_merged <- cbind(y_test, subject_test, x_test)
train_and_test <- rbind(train_merged, test_merged)

#Mean and Standard Deviation Subset
column_names <- colnames(train_and_test)
column_subset <- (grepl("Activity_Id" , column_names) | 
                     grepl("Subject_Id" , column_names) | 
                     grepl("mean.." , column_names) | 
                     grepl("std.." , column_names))
mean_and_std_subset <- train_and_test[ ,column_subset == TRUE]

#Activity Lables
mean_and_std_subset <- merge(mean_and_std_subset, activity_labels,
                              by='Activity_Id',
                              all.x=TRUE)

#Tidying data set

tidy_subset <- aggregate(.~Subject_Id + Activity_Id, mean_and_std_subset, mean)
tidy_subset <- tidy_subset[order(tidy_subset$Subject_Id, tidy_subset$Activity_Id),]

#Making a second tidy data set
write.table(tidy_subset, "tidy_subset.txt", row.name=FALSE)