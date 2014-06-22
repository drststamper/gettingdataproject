run_analysis <- function(){
#<A>  
  #create the filepaths for the files containing the variable names and activity names
  featuresfile <- paste(getwd(), "UCI HAR Dataset", "features.txt", sep="/")
  activitiesfile <- paste(getwd(), "UCI HAR Dataset", "activity_labels.txt", sep="/")
  
  #create the filepaths for the test & train data
  subjecttrainfile <- paste(getwd(), "UCI HAR Dataset", "train", "subject_train.txt", sep="/")
  xtrainfile <- paste(getwd(), "UCI HAR Dataset", "train", "X_train.txt", sep="/")
  ytrainfile <- paste(getwd(), "UCI HAR Dataset", "train", "y_train.txt", sep="/")
  subjecttestfile <- paste(getwd(), "UCI HAR Dataset", "test", "subject_test.txt", sep="/")
  xtestfile <- paste(getwd(), "UCI HAR Dataset", "test", "X_test.txt", sep="/")
  ytestfile <- paste(getwd(), "UCI HAR Dataset", "test", "y_test.txt", sep="/")
  
  #load all data using filepaths to the files
  features <- read.table(featuresfile)
  featurenames <- as.character(features[,2]) #put the feature names (column2) in a vector
  activities <- read.table(activitiesfile)
  descriptive_activities <- as.character(activities[,2])#put the activity descriptions (column2) in a vector
  subjecttraindata <- read.table(subjecttrainfile)
  xtraindata <- read.table(xtrainfile)
  ytraindata <- read.table(ytrainfile)
  subjecttestdata <- read.table(subjecttestfile)
  xtestdata <- read.table(xtestfile)
  ytestdata <- read.table(ytestfile)
#</A>

#<B>
  #change the columnnames of the xtrain and xtest dataframes to the featurenames
  names(xtraindata) <- featurenames
  names(xtestdata) <- featurenames
  
  #change the activitylabels, which are numbers, to their corresponding descriptive activity names
  ##this loop takes care of the ytrain file activity names changes
  for(i in 1:6){
    ind <- ytraindata$V1 %in% i #make a vector with indices of all rows in ytraindata having the value i
    ytraindata[ind,1] <- descriptive_activities[i] #change value to descriptive activity name
  }
  
  ##this loop takes care of the ytest file activity names changes
  for(i in 1:6){
    ind <- ytestdata$V1 %in% i #make a vector with indices of all rows in ytestdata having the value i
    ytestdata[ind,1] <- descriptive_activities[i]#change value to descriptive activity name
  }
  
  #change the name of the column in the ytrain-, ytest-, subjecttrain- and subjecttestdata
  names(ytraindata) <- "Activity" 
  names(ytestdata) <- "Activity" 
  names(subjecttraindata) <- "SubjectID" 
  names(subjecttestdata) <- "SubjectID"
#</B>

#<C>
  #combine the separate train and test files to create a complete_train, complete_test and complete dataset
  train_data_with_activities <- cbind(ytraindata, xtraindata)
  complete_train_data <- cbind(subjecttraindata, train_data_with_activities)
  test_data_with_activities <- cbind(ytestdata, xtestdata)
  complete_test_data <- cbind(subjecttestdata, test_data_with_activities)
  complete_dataset <- rbind(complete_train_data, complete_test_data)
  
  #change the names of the columns that will be used to create the desired dataset (which only 
  #has means and standard deviations in it)
  dataset_names <- names(complete_dataset)
  intermediate_correct_names <- sub("-mean\\(\\)", "Mean", dataset_names)
  correct_names <- sub("-std\\(\\)", "StdDeviation", intermediate_correct_names)
  names(complete_dataset) <- correct_names
#</C>

#<D>
  #now make the selection of columns to put into the desired dataset names(complete_dataset)  
  indices <- grep("SubjectID|Activity|Mean-|Mean$|StdDeviation-|StdDeviation", names(complete_dataset), value=FALSE)
  desired_dataset <- as.data.frame(complete_dataset[,indices])
  
  #create the tidy dataset from the raw desired_dataset by grouping by SubjectID + Activity and
  #apply dcast, using the mean function, to calculate the means for all the measures per SubjectID
  # - Activity combination
  require("reshape")
  require("reshape2")
  molten_dataset <- melt(desired_dataset, id=c("SubjectID", "Activity"))
  tidy_dataset <- dcast(molten_dataset, SubjectID + Activity ~ variable, mean)
#</D>

#<E>
  #finally, write the dataset to a .txt file
  write.table(tidy_dataset, file="tidy_dataset.txt", row.names=FALSE)
  tidy_dataset
#</E>

}