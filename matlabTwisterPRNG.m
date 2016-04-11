function [X,y,Xtest,Ytest] = matlabTwisterPRNG(n,d,t,k, featureType, labelSize)
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

%Fix the seed - Note that the Mersenne Twister's performance depends on the
%random number seed. A better quality seed may improve the performance of
%the PRNG
% rng(0,'twister');
% rng('twister');

%set up default 
if nargin < 5,
    featureType = 's';
    labelSize =k;
end

numsTrain = randi(k,1,n+d);
[X,y] = reformat(numsTrain,n,d,k, featureType, labelSize);
numsTest = randi(k,1,t+d);
[Xtest,Ytest] = reformat(numsTest,t,d,k, featureType, labelSize);

end