proyecto = function(){
  library(dplyr)
  library(reshape2)
 
  urlFile<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  destino<-"datacoursera.zip"
  if(!file.exists("datacoursera.zip"))
  {
    download.file(urlFile,destfile =destino )
  }
  if(!dir.exists("UCI HAR Dataset"))
  {
    unzip(destino)
  }
  #Read
  act<-read.table("./UCI HAR Dataset/activity_labels.txt",col.names=c("id","actividad"))
  feature<-read.table("./UCI HAR Dataset/features.txt",col.names=c("id","name"))
  trainX<-read.table("./UCI HAR Dataset/train/X_train.txt",col.name=feature$name)
  trainY<-read.table("./UCI HAR Dataset/train/y_train.txt",col.name="activity")
  testX<-read.table("./UCI HAR Dataset/test/X_test.txt",col.name=feature$name)
  testY<-read.table("./UCI HAR Dataset/test/y_test.txt",col.name="activity")
  subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt",col.name="subject")
  subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt",col.name="subject")
  print("Lectura")
  
  #merge test and train data
  X<-bind_rows(trainX,testX)
  Y<-bind_rows(trainY,testY)
  Subject<-bind_rows(subject_train,subject_test)
  print("Mezcla")
  # select only mean and std data
  filtrado<-X %>% select(contains("mean"), contains("std"))
  
  #Rename columns to descriptive  names
  names(filtrado)<-sub(".mean", "Mean", names(filtrado))
  names(filtrado)<-sub(".std", "std", names(filtrado))
  names(filtrado)<-sub("mean", "Mean", names(filtrado))
  names(filtrado)<-sub("std", "Std", names(filtrado))
  names(filtrado)<-gsub("Acc", "Accelerometer", names(filtrado))
  names(filtrado)<-gsub("Gyro", "Gyroscope", names(filtrado))
  names(filtrado)<-gsub("BodyBody", "Body", names(filtrado))
  names(filtrado)<-gsub("Mag", "Magnitude", names(filtrado))
  names(filtrado)<-gsub("^t", "Time", names(filtrado))
  names(filtrado)<-gsub("^f", "Frequency", names(filtrado))
  names(filtrado)<-gsub("tBody", "TimeBody", names(filtrado))
  names(filtrado)<-gsub("-mean()", "Mean", names(filtrado), ignore.case = TRUE)
  names(filtrado)<-gsub("-std()", "STD", names(filtrado), ignore.case = TRUE)
  names(filtrado)<-gsub("-freq()", "Frequency", names(filtrado), ignore.case = TRUE)
  names(filtrado)<-gsub("angle", "Angle", names(filtrado))
  names(filtrado)<-gsub("gravity", "Gravity", names(filtrado))
  print("Renombre")
  
  #merge activity, data and subject
  filtrado<-bind_cols(filtrado,Y,Subject)
  filtrado$activity<-act[filtrado$activity,2]
  
  #Reshape data by activity and subject
  meltData<-melt(filtrado, id=c("subject","activity"))
  
  #independent tidy data set with the average of each variable for each activity and each subject
  tidyData<-dcast(meltData, subject + activity ~ variable, mean)
  write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)
}