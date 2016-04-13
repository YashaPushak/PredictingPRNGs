function [nums] = loadPRNG(filePrefix,k)
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



end