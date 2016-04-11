function [X,y,Xtest,Ytest] = matlabTwisterPRNG(n,d,t,k, featureType)
%n - number of inputs
%d - Number of preceeding values used for predictions
%t - Number of test values
%k - Number of classes

%Fix the seed - Note that the Mersenne Twister's performance depends on the
%random number seed. A better quality seed may improve the performance of
%the PRNG
% rng(0,'twister');
% rng('twister');
numsTrain = randi(k,1,n+d);
numsTest = randi(k,1,t+d);
if ( featureType == 's')
    
    [X,y] = reformat(numsTrain,n,d,k);
    [Xtest,Ytest] = reformat(numsTest,t,d,k);
else
if ( featureType == 'c')
    [X,y] = reformatCounting(numsTrain,n,d,k);
    [Xtest,Ytest] = reformatCounting(numsTest,t,d,k); 
end
end