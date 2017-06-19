##### date:2017-6-17##
##### theme: Logisitic regression and LDA





train_set = read.table('geno_train.txt',header = T, sep = ',')
train_set$population = as.numeric(train_set$population)  # 1:Afr-American, 2:Caucasian
train_set$population[train_set$population==2]=0 # 1:Afr-American, 0:Caucasian

test_set = read.table('geno_test.txt',header = T, sep = ',')
test_set$population = as.numeric(test_set$population)  # 1:Afr-American, 2:Caucasian
test_set$population[test_set$population==2]=0 # 1:Afr-American, 0:Caucasian

x_train = train_set[,-16]
y_train = train_set[,16]
x_test = test_set[,-16]
y_test = as.numeric(test_set[,16])


#  logistic regression's error calculate 
error = function(yhat,y){
  result = sum(abs((yhat-y)))
  return(result)
}

# lda's error calculate
error2 = function(yhat,y){
  result = sum(a!=b)
  return(result)
}

##############  logistic regression  #################
fit_logit = glm(population~., data = train_set,family=binomial(link=logit))
summary(fit_logit);

yhat = predict(fit_logit, x_test)
yhat = exp(yhat)/(1+exp(yhat))
test_set$predicted = 1*(yhat>0.5)
mis_cla = error(test_set$predicted,test_set$population)
cat('the misclassfication using logistic regression is:',mis_cla,'\n')

##############    LDA    #################
library(MASS)
fit_lda = lda(population~., data = train_set)
lda_yhat = predict(fit_lda,x_test)$class

test_set$predicted2 = lda_yhat
mis_cla2 = error2(test_set$predicted2,as.factor(test_set$population))
cat('the misclassfication using lda is:',mis_cla2,'\n')


fit_qda = qda(population~., data = train_set)
qda_yhat = predict(fit_qda,x_test)$class

test_set$predicted3 = qda_yhat
mis_cla3 = error2(test_set$predicted3,as.factor(test_set$population))
cat('the misclassfication using qda is:',mis_cla3,'\n')






