function [X,y,Xtest,Ytest] = kimPRNG(n,d,t,k,featureType, labelSize)
%n - number of inputs
%d - Number of preceeding values used for predictions
%t - Number of test values
%k - Number of classes NOTE: Can only take values 2, 3, or 5 for this PRNG

%set up default
if nargin < 5
    featureType = 's';
    labelSize = k;
elseif nargin < 6
    labelSize = k;
end

[numsTrain, numsTest] = loadPRNG('kim',n,d,t,k);


[X,y] = reformat(numsTrain,n,d,k, featureType, labelSize);
[Xtest,Ytest] = reformat(numsTest,t,d,k, featureType, labelSize);

end

