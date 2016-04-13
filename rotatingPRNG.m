function [nums] = rotatingPRNG(n,k,noise)
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


rng('shuffle');
% rng(0,'twister');

nums = ones(1,n);
for j = 1:k
    for i = j:k:(n)
        nums(i) = j;
    end
end
for i = 1:n
    if(rand < noise)
        nums(i) = randi(k);
    end
end

end