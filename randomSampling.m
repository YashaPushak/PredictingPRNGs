function [ model ] = randomSampling( X, y)

[~,k] = size(y);
[n,d] = size(X);
p(1) = (sum(X(1,:) == 1) + sum(X(2:n,d)))/(n+d);
for i = 2:k
    p(i) = p(i-1) + (sum(X(1,:) == k) + sum(X(2:n,d)))/(n+d);
end
model.p = p;
model.k = k;
model.predict = @(model, Xtest) predict(model, Xtest);
end

function yhat = predict(model, Xtest)
t = size(Xtest, 1);
yhat = zeros(t, model.k);
for i=1:t,
    rng('shuffle');
    sample = rand;
    for j = 1:model.k
        if(sample <= p(j))
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