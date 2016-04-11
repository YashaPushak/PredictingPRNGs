function [X,y,Xtest,Ytest] = rotatingPRNG(n,d,t,k,noise, featureType)
%n - number of inputs
%d - Number of preceeding values used for predictions
%t - Number of test values
%k - Number of classes
%featureType -  determines how features for each example are calculated:
%            - 's': features are the 'd' preceding numbers
%            - 'c': features are the counts of each of the k classes in the 'd'
%            preceding numbers
%labelSize - the number of labels for each training example:
%            - 1: label = class number
%            - k: label is of size k with each entry representing one of the
%            k classes. The corresponding class is marked with 1, rest are -1

if nargin < 6,
    featureType = 's';
end
rng('shuffle');
% rng(0,'twister');

numsTrain = ones(1,n+d);
for j = 1:k
    for i = j:k:(n+d)
        numsTrain(i) = j;
    end
end
for i = 1:(n+d)
    if(rand < noise)
        numsTrain(i) = randi(k);
    end
end
[X,y] = reformat(numsTrain,n,d,k, featureType);
numsTest = ones(1,t+d);
for j = 1:k
    for i = j:k:(t+d)
        numsTest(i) = j;
    end
end
for i = 1:(t+d)
    if(rand < noise)
        numsTest(i) = randi(k);
    end
end
[Xtest,Ytest] = reformat(numsTest,t,d,k, featureType);
end