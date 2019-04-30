library(dplyr)

# Read train data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", dec = ".")
y_train <- read.csv("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "", dec = ".")

# Read test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", dec = ".")
y_test <- read.csv("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "", dec = ".")

## Step 1. Merge the training and test sets
x_total <- rbind(X_train, X_test)
y_total <- rbind(y_train, y_test)
sub_total <- rbind(subj_train, subj_test)


## Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# First, let's read the txt files with info on features and labels

# read data description
features <- read.table("./UCI HAR Dataset/features.txt")

# read activity labels
act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Create a list with feature number for those with mean and stdev for each measurement
feat_list <- features[grep("Mean()|mean()|std()", features[, 2]),]
x_total <- x_total[,feat_list[,1]]


## Step 3. Uses descriptive activity names to name the activities in the data set
colnames(y_total) <- "activity"
y_total$activity <- factor(y_total$activity, labels = act_labels[,2])


## Step 4. Appropriately labels the data set with descriptive variable names.
colnames(x_total) <- feat_list[,2]


## Step 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
colnames(sub_total) <- "subject_id"
final <- cbind(sub_total, y_total, x_total)

final_mean <- final %>%
                        group_by(subject_id, activity) %>% 
                        summarize_each(funs(mean))

write.table(final_mean, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)
