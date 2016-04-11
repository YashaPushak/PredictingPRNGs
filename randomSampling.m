function [ model ] = randomSampling( X, y)

[~,k] = size(y);
[n,d] = size(X);
%Find the cumulative distribution function.
p(1) = (sum(X(1,:) == 1) + sum(X(2:n,d) == 1))/(n+d);
for i = 2:k-1
    p(i) = p(i-1) + (sum(X(1,:) == i) + sum(X(2:n,d) == i))/(n+d-1);
end
p(k) = 1;

model.p = p;
model.k = k;
model.predict = @(model, Xtest) predict(model, Xtest);
end

function yhat = predict(model, Xtest)
t = size(Xtest, 1);
yhat = zeros(t, model.k);
rng('shuffle');
%Randomly sample t points
sample = rand(t,1);
for i=1:t
    %Use the CDF in p to convert from the uniform sample to the sample
    %distribution that we learned.
    for j = 1:model.k
        if(sample(i) <= model.p(j))
            class = j;
            break;
        end
    end
    for j = 1:model.k
        if(j == class)
            yhat(i,j) = 1;
        else
            yhat(i,j) = -1;
        end
    end
end
end