getwd();
setwd("C:/Users/sverma/Desktop/rproject/week4/week4");
getwd();
library(dplyr);
#Ingesting and forming feature list

feature_df<-read.delim("features.txt",header=FALSE,sep="");
names(feature_df)<-c("ID","featurename");

#Ingesting labels 
activity_lab_df<-read.delim("activity_labels.txt",header=FALSE,sep="");
names(activity_lab_df)<-c("ID","ActivityName");


#Ingesting and merging X  Test  data observations

X_df_test<-read.delim("X_test.txt",header=FALSE,sep="");
names(X_df_test)<-c(feature_df$featurename);


#Ingesting and merging X Y train data  observations

X_df_train<-read.delim("X_train.txt",header=FALSE,sep="");
names(X_df_train)<-c(feature_df$featurename);


#Combining test and train data 
test_train_df<-bind_rows(X_df_test,X_df_train);
#Getting mean from data set
test_train_df_mean<-lapply(test_train_df,mean);
test_train_df_mean;
#Getting sd from data set 
test_train_df_sd<-lapply(test_train_df,sd);
test_train_df_sd;

#Ingesting activity names for Test data sets 
Y_df_test<-read.delim("Y_test.txt",header=FALSE,sep="");
names(Y_df_test)<-c("Activity");
test_df_FINAL<-bind_cols(X_df_test,Y_df_test);

#Ingesting activity names for Train data sets 
Y_df_train<-read.delim("Y_train.txt",header=FALSE,sep="");
names(Y_df_train)<-c("Activity");
train_df_FINAL<-bind_cols(X_df_train,Y_df_train);

#Tidy data with activty names 
test_train_with_activity_df<-bind_rows(test_df_FINAL,train_df_FINAL)%>%inner_join(y=activity_lab_df,by=c("Activity"="ID"));

# Output of Mean for each group 
output_bygroup<-test_train_with_activity_df%>%group_by(Activity,ActivityName)%>%summarise_at(c(1:561),mean);
write.table(output_bygroup,file="outputweeek4.txt",row.name=FALSE);