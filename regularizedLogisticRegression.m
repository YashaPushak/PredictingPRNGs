function [model] = regularizedLogisticRegression(X,y,lambda)
%TODO: Convert this to multiclass logistic regression

% Add bias variable
[n,d] = size(X);
X = [ones(n,1) X];
[~,k] = size(y);

% Initial values of regression parameters
w = zeros(d+1,k);

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
nll = sum(sum(log(1+exp(-yXw)))) + (lambda/2)*norm(w,'fro')^2;
%nll = sum(log(1+exp(-yXw))) + (lambda/2)*(w'*w);

% Gradient
g = -X'*(y./(1+exp(yXw))) + lambda*w;
end