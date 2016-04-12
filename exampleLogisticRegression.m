clear

n = 1000;
d = 9;
t = 7000;
k = 2;

[X,y,Xtest,ytest] = joelPRNG(n,d,t,k,'s');

model = regularizedLogisticRegression(X,y,2);
yhat = model.predict(model,Xtest);
err = 1-sum(all(yhat' == ytest'))/t;

fprintf('Error for Logistic Regression: %.10f \n', err);



