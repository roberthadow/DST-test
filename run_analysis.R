## run_analysis.R

# comments are found in the codebook

suppressPackageStartupMessages(library(plyr))
suppressPackageStartupMessages(library(dplyr))
options(width = 120)

targetDir <- dictDir <- "./codebook"
if(!file.exists(targetDir)) dir.create(targetDir)
fileUrl <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI HAR Dataset.names"
zipFile = paste(targetDir, "herus.html", sep = "/")

targetDir <- dataDir <- "./data"
if(!file.exists(targetDir)) dir.create(targetDir)
fileUrl <-
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile = paste(dataDir, "UCIHAR.zip", sep = "/")
download.file(fileUrl, zipFile, mode="wb")
dateDownloaded = date()

unzip(zipFile, exdir = targetDir, junkpaths = TRUE)

targetDir <- dictDir <- "./codebook"
dictFiles <- c("README.txt", "features_info.txt")
from <- sapply(dataDir, paste, dictFiles, sep ="/")
to   <- sapply(targetDir, paste, dictFiles, sep ="/")
success <- file.rename(from, to)

csvFiles <- list.files(dataDir, pattern = "*.txt", recursive = TRUE,
                       full.names = TRUE)


# read_data
#
csvFiles <- list.files(dataDir, pattern = "*.txt", recursive = TRUE,
                       full.names = TRUE)
newObjects <- gsub(".txt", "", csvFiles)
newObjects <- gsub("./data/", "", newObjects)

for (i in 1:length(csvFiles)) {
        assign(newObjects[i], inherits = TRUE,
               read.csv(csvFiles[i],
                        header = FALSE,
                        stringsAsFactors = FALSE,
                        na.strings = "NA",
                        sep = ""))
}

dataPoints = 0
for (i in 1:length(newObjects)) {
        dataPoints = dataPoints + (nrow(get(newObjects[i])) * ncol(get(newObjects[i])))
}



## Tidy Data



# organize and apply column names to the test data set
features[, 2]  <- gsub("\\()","", features[, 2])
features[, 2]  <- gsub("\\()","", features[, 2])

colnames(X_test)  <- features[, 2]
colnames(X_train) <- features[, 2]

# organize subject data, append it to the observations
colnames(subject_test)  <- "subject"
colnames(subject_train) <- "subject"
X_test  <- cbind(subject_test,  X_test)
X_train <- cbind(subject_train, X_train)

# organize exercise data, append it to the observations
colnames(activity_labels) <- c("activity_code", "activity")
colnames(y_test)  <- "activity_code"
colnames(y_train) <- "activity_code"
X_test  <- cbind(y_test,  X_test)
X_train <- cbind(y_train, X_train)

# now redact the data
selectedColumns <- features[ grep("mean|std", features$V2) , ]
X_test  <- X_test[,  selectedColumns$V1]
X_train <- X_train[, selectedColumns$V1]

# combine the test and train datasets
ucihar <- rbind(X_test, X_train)

# write csv file for activity explanation
write.table(activity_labels, file = "activities.csv", sep = ",",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")

dataPoints = nrow(ucihar) * (ncol(ucihar) - 2)

# Create Codebook


uciharTable <- rep("ucihar", ncol(ucihar))
uciharAttribute <- colnames(ucihar)
uciharDescription <- colnames(ucihar)
uciharDescription[substr(uciharDescription,1,1) == "f"] <- "frequency domain data"
uciharDescription[substr(uciharDescription,1,1) == "t"] <- "time domain summary data"
ucihar.dict <- data.frame(uciharTable, uciharAttribute, uciharDescription)

uciharTable <- "subject"
uciharAttribute <- "subject between 18 and 48"
uciharDescription <- "Subjects by number only"
temp <- data.frame(uciharTable, uciharAttribute, uciharDescription)
ucihar.dict = rbind(ucihar.dict, temp)

uciharTable <- "activity_labels"
uciharAttribute <- "activity_code"
uciharDescription <- as.character(activity_labels[,1])
temp <- data.frame(uciharTable, uciharAttribute, uciharDescription)
ucihar.dict = rbind(ucihar.dict, temp)

uciharTable <- "activity_labels"
uciharAttribute <- "activity"
uciharDescription <- activity_labels[,2]
temp <- data.frame(uciharTable, uciharAttribute, uciharDescription)
ucihar.dict = rbind(ucihar.dict, temp)

colnames(ucihar.dict) <- c("Table", "Attribute", "Description")


#  Print Codebook

print(ucihar.dict, include.rownames = FALSE, max.levels = null, width = 1200)

ucihar %>% group_by(activity_code, subject) %>% summarise_each(funs(mean)) -> ucihar_summary

# write csv file for summary dataset
write.table(ucihar_summary, file = "UCIHAR_summary.txt", sep = ",",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")

