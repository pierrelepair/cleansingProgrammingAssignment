run_analysis <- function(archive) {
#Pre-requisite is that the FUCI arcchive is present in wd
if (!file.exists(archive)) {
        stop("FUCI archive not found!")
}
unzip(archive)
file.copy("UCI HAR Dataset/train/X_train.txt", ".")
file.copy("UCI HAR Dataset/train/Y_train.txt", ".")
file.copy("UCI HAR Dataset/train/subject_train.txt", ".")
file.copy("UCI HAR Dataset/test/X_test.txt", ".")
file.copy("UCI HAR Dataset/test/Y_test.txt", ".")
file.copy("UCI HAR Dataset/test/subject_test.txt", ".")
file.copy("UCI HAR Dataset/features.txt", ".")
file.copy("UCI HAR Dataset/activity_labels.txt", ".")


#read features names vector
f <- read.delim("features.txt", header = FALSE, sep = "")

#read activities labels
l <- read.delim("activity_labels.txt", header = FALSE, sep = "", col.names = c("Activity.ID", "Activity.label"))

#read training set data using features vector as column names
x <- read.delim("X_train.txt", header = FALSE, sep = "", col.names = f[,2])

#read training set subjects and define column name
s_trn <- read.delim("subject_train.txt", header = FALSE)
colnames(s_trn) <- c("Subject.ID")

#read training set activities and define column name
a_trn <- read.delim("Y_train.txt", header = FALSE)
colnames(a_trn) <- c("Activity.ID")

#merge training measures, subjects and activities
x <- cbind(s_trn, a_trn, x)

#read test set data using features vector as column names
y <- read.delim("X_test.txt", header = FALSE, sep = "", col.names = f[,2])

#read test set subjects and define column name
s_tst <- read.delim("subject_test.txt", header = FALSE)
colnames(s_tst) <- c("Subject.ID")

#read test set activities and define column name
a_tst <- read.delim("Y_test.txt", header = FALSE)
colnames(a_tst) <- c("Activity.ID")

#merge test measures, subjects and activities
y <- cbind(s_tst, a_tst, y)

#merge test and training sets
sam_data <- rbind(x, y)

#keep subject and activity IDs, and std and mean variables
sampl_sam_data <- sam_data[c("Subject.ID", "Activity.ID", colnames(sam_data)[grep("\\.std\\.|\\.mean\\.", colnames(sam_data))])]
z <- merge(x = sampl_sam_data, y = l, by = "Activity.ID")
#normalize variable names by removing dots and set case to lower
names(z) <- gsub(".", "", tolower(names(z)), fixed = TRUE)
#aggregate using mean along subject and activity
x <- aggregate(z[, 3:68], list(z$subjectid, z$activitylabel), mean)
names(x)[1:2] <- c("subject", "activity")
x
}
my_data <- run_analysis("FUCI.zip")