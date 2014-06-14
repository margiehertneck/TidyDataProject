run_analysis <- function() {
    
    print("Assumes unzipped files are in '/UCI HAR Dataset' and working 
          directory is correct in script")
    print("This will take some time -- progress will stop and start")
    
    # load libraries
    library(reshape2)  # for melt/dcast
    library(utils) # for progress bar
    
    # create progress bar & progress bar function
    total = 40
    pb <- txtProgressBar(min = 0, max = total, style = 3)
    bar<-function(x,y){      #starts/updates the progress bar    
        for(i in x:y){
            Sys.sleep(0.1)
            setTxtProgressBar(pb, i)
        } #endfor
    }#end bar function
    
    bar(1,3) # start the progress bar
    
    # Identify path to txt files
    path <- "C:/Users/margie/Desktop/Coursera_Data_Scientist/UCI HAR Dataset/"
    
    # read txt files into data frames (with periodic progress update)
    Xtrain <- read.table(paste(path,"train/X_train.txt",sep=""),header=F,sep="")
    bar(4,6)
    Ytrain <- read.table(paste(path,"train/y_train.txt",sep=""),header=F,sep="")
    bar(7,9)
    subjtrain <- read.table(paste(path,"train/subject_train.txt",sep=""),header=F,sep="")
    bar(10,12)
    Xtest <- read.table(paste(path,"test/X_test.txt",sep=""),header=F,sep="")
    bar(13,15)
    Ytest <- read.table(paste(path,"test/y_test.txt",sep=""),header=F,sep="")
    bar(16,18)
    subjtest <- read.table(paste(path,"test/subject_test.txt",sep=""),header=F,sep="")
    bar(19,21)
    features <- read.table(paste(path,"features.txt",sep=""),header=F,sep="")
    bar(22,24)
    actlabels <- read.table(paste(path,"activity_labels.txt",sep=""),header=F,sep="") # MANUALLY ENTERED
    bar(25,27)
    
    # create vector from features dataframe to clean and use as column headings
    names<- as.vector(features[,2], mode = "character")
    
    # substitute/remove troublesome variable characters
    names<-gsub("-", ".", names, fixed = TRUE) 
    names<-gsub("(", "", names, fixed = TRUE) 
    names<-gsub(")", "", names, fixed = TRUE) 
    names<-gsub(",", ".", names, fixed = TRUE) 
    
    bar(28,29)
    
    # label Xtrain variables
    colnames(Xtrain,do.NULL=TRUE,prefix="col")
    colnames(Xtrain)<- names
    
    # label Xtest variables
    colnames(Xtest,do.NULL=TRUE,prefix="col")
    colnames(Xtest)<- names
    
    # add "Y" activity codes to "X" train/test datasets 
    Xtrain$activity<-Ytrain[,1]
    Xtest$activity<-Ytest[,1]
    
    bar(30,31)
    
    # add "Y" subject codes to "X" train/test datasets 
    Xtrain$subject<-subjtrain[,1]
    Xtest$subject<-subjtest[,1]
    
    bar(32,33)
    
    # rbind Xtest and Xtrain datasets into one dataset
    pretidy <- rbind(Xtrain,Xtest)
    
    bar(34,35)
    
    # substitute activity labels for codes using actlabels & ensure factors
    pretidy$activity = actlabels[pretidy$activity,2]
    pretidy$activity<-factor(pretidy$activity)
    
    # remove original datasets from memory - no longer needed
    rm(Xtest,Xtrain,Ytest,Ytrain,subjtrain,subjtest,features,actlabels)
    
    bar(36,37)
    
    # identify mean and std labels; create vector of labels 
    #   to use in subsetting pretidy into tidy dataset
    if(length(i <- grep("mean", names)))
        namesmean<-names[i]
    if(length(i <- grep("std", names)))
        namesstd<-names[i]
    names2 <- c("activity","subject",namesmean,namesstd)
    
    #extract only necessary columns into tidy dataframe
    tidy <- pretidy[,names2]
    
    bar(38,39)
    
    # remove unnecessary dataset and values from memory - no longer needed
    rm(pretidy,i,names,names2,namesmean,namesstd)
    
    # get variable means based on each activity and subject
    # breakout observations by subject*activity
    tidymelt <- melt(tidy,id=c("subject","activity"),measure.vars=colnames(tidy)[3:81])
    
    # get the means for each variable based on subject*activity
    tidymean <- dcast(tidymelt,subject + activity ~ variable,mean)
    
    #remove unnecessary datasets to free up memory
    rm(tidy,tidymelt)
    
    # export tidymean dataset to txt file 
    write.table(tidymean,paste(path,"tidymean.txt"),sep = ",")
    
    bar(40,40) # finish progress bar update and close progress bar
    close(pb)
    
    print("tidymean.txt has been added to '/UCI HAR Dataset'")
    
} #endfunction

