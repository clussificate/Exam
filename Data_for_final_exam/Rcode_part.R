#setwd("/Users/Xinwei/Desktop/SEU-Data Analytics/Take-home Exam")

library(leaps)
library(MASS)
library(lars)
library(glmnet)

#-----------Problem 3
Data1<-read.table("LAozone.txt", sep=',', header=TRUE)
dim(Data1)
N = dim(Data1)[1];

sam_seq = sample(1:N)

idx_train = sam_seq[1:(2/3*N)];
idx_test = sam_seq[(2/3*N+1): N];

Data1_train = Data1[idx_train, ];
Data1_test = Data1[idx_test, ];
#---------------------------------


#------------Problem 4
Data2_train<-read.table("geno_train.txt", sep=',', header=TRUE)   
Data2_test<-read.table("geno_test.txt", sep=',', header=TRUE)

dim(Data2_train)    # 350  16
dim(Data2_test)    # 169  16
xTrain<- as.matrix( Data2_train[,-16] )
yTrain<- as.factor( as.numeric( Data2_train[, 16] ) )
xTest<- as.matrix( Data2_test[,-16] )
yTest<- as.factor( as.numeric(  Data2_test[, 16] ) )


#lda()
#predict.lda()