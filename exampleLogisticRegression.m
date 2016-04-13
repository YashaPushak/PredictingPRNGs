clear

n = 1000;
v = 1000;
t = 1000;
d = 12;
k = 5;
featureType = 's';
labelSize = k;
seed= 0;
PRNGtype = 'yasha';

[X,y,Xval, Yval, Xtest,ytest] = PRNGs(PRNGtype, n, v, t, d, k, featureType, labelSize, seed);


model = regularizedLogisticRegression(X,y,2);
yhat = model.predict(model,Xtest);
err = 1-sum(all(yhat' == ytest'))/t;

fprintf('Error for Logistic Regression: %.10f \n', err);



