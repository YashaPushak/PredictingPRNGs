function [X,y,Xtest,Ytest] = rotatingPRNG(n,d,t,k,noise)
%n - number of inputs
%d - Number of preceeding values used for predictions
%t - Number of test values
%k - Number of classes

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
[X,y] = reformat(numsTrain,n,d,k);
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
[Xtest,Ytest] = reformat(numsTest,t,d,k);
end