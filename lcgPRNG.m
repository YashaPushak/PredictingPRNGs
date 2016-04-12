function [X,y,Xtest,Ytest] = lcgPRNG(n,d,t,k,featureType, labelSize)
%A basic linear congruential generator
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

%Parameters of the linear congruiential generator
a = 22695477;
c = 1;
m = 2^32;

%Set a random seed
rng('shuffle');

nums = size(max(n+d,t+d),1);
numsTrain = zeros(n+d,1);
numsTest = zeros(t+d,1);

nums(1) = randi(2^31-1);
numsTrain(1) = mod(nums(1),k)+1;

%make the training set
nums = zeros(n+d,1);
for i = 2:(n+d)
    nums(i) = mod(a*nums(i-1) + c,m);
    numsTrain(i) = mod(nums(i),k)+1;
end
%Make the test set
nums(1) = nums(n+d);
numsTest(1) = mod(nums(1),k)+1;
for i = 2:(t+d)
   nums(i) = mod(a*nums(i-1) + c,m);
   numsTest(i) = mod(nums(i),k)+1;
end

[X,y] = reformat(numsTrain,n,d,k, featureType, labelSize);
[Xtest,Ytest] = reformat(numsTest,t,d,k, featureType, labelSize);

end