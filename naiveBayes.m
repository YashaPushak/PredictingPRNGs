function [ model ] = naiveBayes(X,y)

k = max(y);
[n,d] = size(X);

%Count how many times each number comes up in the sequence.
numk = zeros(k,1);
for i = 1:k
    numk(i) = sum(sum(X(1,:)==i)) + sum(y(:) == i);
end
%Count how long the sequence is in the training set
totalNum = sum(numk);

%Find the probability of each label
py = zeros(k,1);
for i = 1:k
    py(i) = numk(i)/totalNum;
end

%Count how many times k was your d-th ancestor when you were a k.
counts = zeros(k,d,k);

for i = 1:n
    for j = 1:d
        counts(X(i,j),j,y(i)) = counts(X(i,j),j,y(i)) + 1;
    end
end
%Find the probability of observing feature x in position d given label y
pxdy = zeros(k,d,k);

for i = 1:k
    for j = 1:d
        for l = 1:k
            pxdy(i,j,l) = counts(i,j,l)/sum(counts(:,j,i));
        end
    end
end

model.k = k;
model.pxdy = pxdy;
model.py = py;
model.predict = @(model, Xtest) predict(model, Xtest);
end

function yhat = predict(model, Xtest)

k = model.k;
py = model.py;
pxdy = model.pxdy;

[t,d] = size(Xtest);
yhat = zeros(t,1);

for i = 1:t
    pmax = 0;
    ymax = 0;
    for j = 1:k
        %Find the probability of being label j
        pj = py(j);
        for l=1:d
            pj = pj*pxdy(Xtest(i,l),l,j);%^(2-(l-1)/d);
        end
        if(pj > pmax)
            pmax = pj;
            ymax = j;
        end
    end
    yhat(i) = ymax;
end

end