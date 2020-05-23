library(dplyr)
# Part 1 of the script will download the data, and then extract it into
# a temporary folder `./data/`
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (! dir.exists("./data")) dir.create("./data")

download.file(fileUrl, destfile = "./data/raw_dataset.zip", method="curl")
unzip(zipfile = "./data/raw_dataset.zip" , exdir = "./data")

# We read the features.txt file to get the appopriate variable names
features <- read.table("./data/UCI HAR Dataset/features.txt")
features <- gsub("\\.|\\(|\\)", "", features[, 2])
# Then read the measurements file for the training set, the labels file and the subject file
# And then we combine them into one data unit.
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = features)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = c("label_id"))
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
train <- cbind(subject_train, x_train, y_train)

# We repeat the same steps for the test measurements.
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = features)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = c("label_id"))
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
test <- cbind(subject_test, x_test, y_test)

# We then merge the training and test sets into one data.
data <- rbind(train, test)

# We extract measurements on the mean and std for each observation. 
# Alongside with the subject and label_id variables. 
data <- tbl_df(data)
data <- data %>% select(matches("subject|label_id|[Mm]ean|[Ss]td"))

# We make sure to use descriptive names for the activity in the data set.
labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("label_id", "activity"))
data <- merge(data, labels, by = c("label_id"))
# Cleanup the redundant variable label_id (replaced by activity).
data <- data[, -1]

# Goup by subject and activity then compute the average for each variable
# for each activity and each subject.
tidy_data <- data %>% 
  group_by(subject, activity) %>%
  summarise_all(mean)
write.table(tidy_data, file = "./data/tidy_data.txt")