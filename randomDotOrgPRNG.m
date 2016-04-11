function [X,y,Xtest,Ytest] = randomDotOrgPRNG(n,d,t,k,featureType)
%n - number of inputs
%d - Number of preceeding values used for predictions
%t - Number of test values
%k - Number of classes NOTE: Can only take values 2, 3, or 5 for this PRNG

%set up default
if nargin < 5,
    featureType = 's';
end

if(k == 2)
    text = fileread('random.org-k=2.txt');
elseif(k == 3)
    text = fileread('random.org-k=3.txt');
elseif(k == 5)
    text = fileread('random.org-k=5.txt');
else
    error('Not a supported value for k. Only values of 2, 3, and 5 are supported.');
end
nums = str2num(text); %#ok<ST2NM>

%If we have more numbers than we need, then we truncate the numbers
if(length(nums) >= n + t + 2*d)
    temp = nums(1:n+t+2*d);
    clearvars nums;
    nums = temp;
    
    numsTrain = nums(1:n+d);
    numsTest = nums(n+d+1:end);
    
elseif(length(nums) < n + t + 2*d)
    n = round(length(nums)/2);
    numsTrain = nums(1:n);
    numsTest = nums(n+1:end);
    n = n - d;
    t = t - d;
    if(n > d)
        warning(['Not enough numbers, truncating to n: ' num2str(n) + ', t: ' num2str(t) '.']);
    else
        error('Not enough numbers, unable to truncate because n <= d.');
    end
end

[X,y] = reformat(numsTrain,n,d,k, featureType);
[Xtest,Ytest] = reformat(numsTest,t,d,k, featureType);

end