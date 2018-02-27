#Peer-Reviewed Assignment
library(stringr)
library(plyr)
library(dplyr)

options(stringsAsFactors = FALSE)

#Function to use the second element in a list of atomic vectors.
secondElement<-function(x){x[2]}

#Function to handle spaces. Convert the chr vector to a list
#Both the activity labels and the attribute names are chr vectors that have a number in front 
#of the descriptive name. 
cond_variName<-function(x){
  y<-sapply(x, strsplit, " +")
  z<-unlist(sapply(y, secondElement))
  return(z)
}

#Function to:
#Get rid of extra spaces and 0 length character vectors in test attribute data
#Unlist to a character vector and then split on at least one " "
#Create data frame from transposing cbinded list
#Give attribute data frame names of attributeNames

attributeDataTodf<-function(x){
  
  listtrimattributeData<-strsplit(unlist(str_trim(x)), " +")
  
  la<-lapply(listtrimattributeData, as.numeric)
  
  dfattributeData<-as.data.frame(t(sapply(la, cbind)))
  
  return(dfattributeData)
}  

#Function to add subject and activity variables to attribute data frame
addVariables<-function(x, y, z){
  x<-mutate(x, subjectId=y)
  x<-mutate(x, activityId=z)
}

substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

## 1. MERGE THE TRAINING AND THE TEST DATA SETS INTO ONE DATA SET

# Read in Test files

#Read in text files in common with test and train datasets: activity id, attribute id
activityNames<-readLines("./UCI HAR Dataset/activity_labels.txt")
attributeNames<-readLines("./UCI HAR Dataset/features.txt")

#Read in text files in test dataset: subject id, attribute id
subjectTestId<-readLines("./UCI HAR Dataset/test/subject_test.txt")
activityTestId<-readLines("./UCI HAR Dataset/test/y_test.txt")
attributeTestData<-readLines("./UCI HAR Dataset/test/X_test.txt")

#Read in text files in train dataset: subject id, attribute id
subjectTrainId<-readLines("./UCI HAR Dataset/train/subject_train.txt")
activityTrainId<-readLines("./UCI HAR Dataset/train/y_train.txt")
attributeTrainData<-readLines("./UCI HAR Dataset/train/X_train.txt")

# Create data frame of Test attribute data
df_test<-attributeDataTodf(attributeTestData)

# Create data frame of Train attribute data
df_train<-attributeDataTodf(attributeTrainData)

# Apply names to the Test and Train attribute data frames
names(df_test)<-attributeNames
names(df_train)<-attributeNames

# Add Test data set subject and activity variables to the test attribute data frame
df_test<-addVariables(df_test, subjectTestId, activityTestId)

# Add Train data set subject and activity variables to the train attribute data frame
df_train<-addVariables(df_train, subjectTrainId, activityTrainId)

# Combine both Test and Train data frames
df_total<-rbind(df_test, df_train)

## 2. EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
col_means_stds<-grep("mean|std|activityId|subjectId", names(df_total))
df_total_mean_std<-df_total[,col_means_stds]

## 3. USE DESCRIPTIVE ACTIVITY NAMES TO NAME ACTIVITIES IN THE DATA SET
activityDescNames<-cond_variName(activityNames)
df_total_mean_std$activityId<-sapply(df_total_mean_std$activityId, x<-function(y){activityDescNames[as.numeric(y)]})

## 4. APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES

# Condition the names of the attribute data frame
attributedfnames<-cond_variName(attributeNames[grep("mean|std|activityId|subjectId", attributeNames)])
names(df_total_mean_std)<-c(attributedfnames, "subjectId", "activityId")

## 5. FROM THE DATA SET IN STEP 4, CREATE A SECOND< INDEPENDENT TIDY DATA SET WITH THE 
## AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT

tidy_df<-df_total_mean_std

result<-aggregate(tidy_df[,1:79], by=list(Subject=as.numeric(tidy_df$subjectId), Activity=tidy_df$activityId), mean)

write.table(result, "tidy_result.txt", row.name = FALSE)
