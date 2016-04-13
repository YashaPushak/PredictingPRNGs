function [nums] = matlabTwisterPRNG(n,k)
%n - number of inputs
%k - Number of classes

%Fix the seed - Note that the Mersenne Twister's performance depends on the
%random number seed. A better quality seed may improve the performance of
%the PRNG

% rng(0,'twister');

rng('twister');

nums= randi(k,1,n);


end