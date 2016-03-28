function [X,y,Xtest,Ytest] = alternatingPRNG(n,d,t,k,noise)
%n - number of inputs
%d - Number of preceeding values used for predictions
%t - Number of test values
%k - Number of classes

rng('shuffle');

numsTrain = ones(1,n+d);
%alternating numbers 1 and 2
for i = 1:2:(n+d)
	numsTrain(i) = 2;
end
%adding noise
for i = 1:(n+d)
    if(rand < noise)
        numsTrain(i) = randi(k);
    end
end
[X,y] = reformat(numsTrain,n,d,k);
numsTest = ones(1,t+d);
for i = 1:2:(t+d)
	numsTest(i) = 2;
end
for i = 1:(t+d)
    if(rand < noise)
        numsTtest(i) = randi(k);
    end
end
[Xtest,Ytest] = reformat(numsTest,t,d,k);
end