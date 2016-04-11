function [model] = logisticRegression(X,y)
%TODO: convert this to multiclass logistic regression

% Add bias variable
[n,d] = size(X);
X = [ones(n,1) X];
[~,k] = size(y);

% Initial values of regression parameters
w = zeros(d+1,k);

% % Check that derivative code is correct
% derivativeCheck(@logisticGrad,w,X,y);

% Solve logistic regression problem
w = gradDesc(@logisticGrad,w,100,X,y);

model.w = w;
model.predict = @predict;

end

function [yhat] = predict(model,Xhat)
[t,d] = size(Xhat);
Xhat = [ones(t,1) Xhat];
w = model.w;
yhat = sign(Xhat*w);
end

function [nll,g] = logisticGrad(w,X,y)
yXw = y.*(X*w);

% Function value
nll = sum(log(1+exp(-yXw)));

% Gradient
g = -X'*(y./(1+exp(yXw)));
end