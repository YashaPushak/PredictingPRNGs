function [X,y] = reformat(nums,n,d,k, featureType, labelSize)
%% Reformat a sequence of numbers into training set and labels
%nums - randomly generated sequence of numbers
%n - number of inputs
%d - Number of preceeding values used for predictions
%k - Number of classes
%featureType -  determines how features for each example are calculated:
%            - 's': features are the 'd' preceding numbers
%            - 'c': features are the counts of each of the k classes in the 'd'
%            preceding numbers
%labelSize - the number of labels for each training example:
%            - 1: label = class number
%            - k: label is of size k with each entry representing one of the
%            k classes. The corresponding class is marked with 1, rest are -1


%set default to sequence features and k labels
if (nargin < 6)
    labelSize =k;
    
    if(nargin <5)
        featureType = 's';
    end
end

X = zeros(n,d);
y = zeros(n,labelSize);

for i = 1:n
    
    %Set Features depending on featureType
    if(featureType == 's')
        X(i,:) = nums(i:i+d-1);
    else
        if(featureType =='c')
            seqI = nums(i:i+d-1);
            
            for j = 1:k
                X(i,j) = sum(seqI == j );
            end
        else
            fprintf('Unknown input for Feature type')
        end
    end
    
    
    %Format labels depending on labelSize
    
    if( labelSize == 1)
        y(i) = nums(i+d);
    else
        if (labelSize == k)
            for j = 1:k
                if(nums(i+d) == j)
                    y(i,j) = 1;
                else
                    y(i,j) = -1;
                end
            end
            
        else
            fprintf('Unknown input for Feature type')
        end
        
    end
end



end