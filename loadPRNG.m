function [numsTrain, numsTest] = loadPRNG(filePrefix,n,d,t,k)
%Loads the PRNGS from a file using the file prefix specified of the form
%"filename" such that "<filename>-k=<k>.txt" specifies the file containing
%the PRNG information.
%n - number of inputs
%d - Number of preceeding values used for predictions
%t - Number of test values
%k - Number of classes NOTE: Can only take values 2, 3, or 5 for this PRNG


if(k == 2)
    text = fileread([filePrefix '-k=2.txt']);
elseif(k == 3)
    text = fileread([filePrefix '-k=3.txt']);
elseif(k == 5)
    text = fileread([filePrefix '-k=5.txt']);
else
    error('Not a supported value for k. Only values of 2, 3, and 5 are supported.');
end

nums = str2num(text(:)); %#ok<ST2NM>

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
        warning(['Not enough numbers, truncating to n: ' num2str(n) ', t: ' num2str(t) '.']);
    else
        error('Not enough numbers, unable to truncate because n <= d.');
    end
end
end