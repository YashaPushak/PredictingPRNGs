clear




model = regularizedLogisticRegression(X,y,1);
yhat = model.predict(model,Xtest);
err = sum(yhat ~= ytest)/t;

fprintf('Error for Logistic Regression: %.2f \n', err);



