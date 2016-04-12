function [ model ] = logisticBayes(X,y)

modelBayes = naiveBayes(X,y);
Z = modelBayes.predict(modelBayes,X);

model.modelLogistic = regularizedLogisticRegression(Z,y,0);
model.modelBayes = modelBayes;
model.predict = @(model, Xtest) predict(model, Xtest);

end

function [ yhat ] = predict(model,Xtest)
Z = model.modelBayes.predict(model.modelBayes,Xtest);
yhat = model.modelLogistic.predict(model.modelLogistic,Z);
end

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
model.predict = @(model, Xtest) predictBayes(model, Xtest);
end

function z = predictBayes(model, Xtest)

k = model.k;
py = model.py;
pxdy = model.pxdy;

[t,d] = size(Xtest);
z = zeros(t,k);

for i = 1:t
    for j = 1:k
        %Find the probability of being label j
        pj = py(j);
        for l=1:d
            pj = pj*pxdy(Xtest(i,l),l,j);
        end
        z(i,j) = pj;
    end
end

end