clear

n = 1000;
d = 50;
t = 500;
k = 2;

[X,y,Xtest,ytest] = alternatingPRNG(n,d,t,k,0.1);

model = regularizedLogisticRegression(X,y,10);
yhat = model.predict(model,Xtest);
err = sum(yhat ~= ytest)/t;

fprintf('Error for Logistic Regression: %.10f \n', err);



