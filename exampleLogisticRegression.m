clear

n = 1000;
d = 50;
t = 500;
k = 3;

[X,y,Xtest,ytest] = matlabTwisterPRNG(n,d,t,k);

model = logisticRegression(X,y);
yhat = model.predict(model,Xtest);
err = sum(sum(yhat ~= ytest))/(t*k);

fprintf('Error for Logistic Regression: %.10f \n', err);



