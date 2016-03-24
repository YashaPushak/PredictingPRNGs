function [X,y,Xtest,Ytest] = matlabTwisterPRNG(n,d,t,k)
%n - number of inputs
%d - Number of preceeding values used for predictions
%t - Number of test values
%k - Number of classes

%Fix the seed - Note that the Mersenne Twister's performance depends on the
%random number seed. A better quality seed may improve the performance of
%the PRNG
% rng(0,'twister');
% rng('twister');

numsTrain = randi(2,1,n+d);
[X,y] = reformat(numsTrain,n,d,k);
numsTest = randi(2,1,t+d);
[Xtest,Ytest] = reformat(numsTest,t,d,k);
end