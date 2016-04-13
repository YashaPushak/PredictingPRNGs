function [X,y,Xval, Yval, Xtest,Ytest] = PRNGs(PRNGtype, n, v, t, d, featureType, labelSize, seed)
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

numsSize = n+v+t+3*d;

%for data extracted from txt files.
if( PRNGtype== 'yasha' || PRNGtype == 'kim' || PRNGtype=='random.org')
    nums = loadPRNG(PRNGtype, k);
elseif(PRNGtype == 'lcg') %for data generated by functions
        nums = lcgPRNG(numsSize, k, seed);
elseif(PRNGtype == 'twister')
    nums = matlabTwisterPRNG(numsSize,k);
elseif(PRNGtype == 'rotating')
    nums = rotatingPRNG(numsSize,k, 0.1);
        
    
end

[numsTrain, numsVal,numsTest] = splitNums(nums,n,v,t,d, numsSize);

[X,y] = reformat(numsTrain,n,d,k, featureType, labelSize);
[Xval,Yval] = reformat(numsVal,v,d,k, featureType, labelSize);
[Xtest,Ytest] = reformat(numsTest,t,d,k, featureType, labelSize);

end

function [numsTrain,numsVal, numsTest] = splitNums(nums,n,v,t,d, numsSize)

%If we have more numbers than we need, then we truncate the numbers
if(length(nums) >= numsSize)
    temp = nums(1:numsSize);
    clearvars nums;
    nums = temp;
    
    numsTrain = nums(1:n+d);
    numsVal = nums(n+d+1:n+v+2*d+1);
    numsTest = nums(n+v+2*d +2:end);
    
elseif(length(nums) < numsSize)
    error('Not enough numbers to make train, val, and test set');
%     n = round(length(nums)/2);
%     numsTrain = nums(1:n);
%     numsTest = nums(n+1:end);
%     n = n - d;
%     t = t - d;
%     if(n > d)
%         warning(['Not enough numbers, truncating to n: ' num2str(n) ', t: ' num2str(t) '.']);
%     else
%        error('Not enough numbers, unable to truncate because n <= d.');
%    end
end
    
    
end
