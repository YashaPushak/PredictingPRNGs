function [model] = regularizedLogisticRegression(X,y,lambda)

% Add bias variable
[n,d] = size(X);
X = [ones(n,1) X];

% Initial values of regression parameters
w = zeros(d+1,1);

% Solve logistic regression problem
w = gradDesc(@logisticGrad,w,400,X,y,lambda);

model.w = w;
model.predict = @predict;
end

function [yhat] = predict(model,Xhat)
[t,d] = size(Xhat);
Xhat = [ones(t,1) Xhat];
w = model.w;
yhat = sign(Xhat*w);
end

function [nll,g] = logisticGrad(w,X,y,lambda)
yXw = y.*(X*w);

% Function value
nll = sum(log(1+exp(-yXw))) + (lambda/2)*(w'*w);

% Gradient
g = -X'*(y./(1+exp(yXw))) + lambda*w;
end