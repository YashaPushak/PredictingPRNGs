function [X,y] = reformat(nums,n,d,k, featureType)
%% Reformat a sequence of numbers into training set and labels

X = zeros(n,d);
y = zeros(n,k);

if (nargin < 5)

    featureType = 's'
end

if(featureType == 's')
    for i = 1:n

        X(i,:) = nums(i:i+d-1);
        for j = 1:k
            if(nums(i+d) == j)
                y(i,j) = 1;
            else
                y(i,j) = -1;
            end
        end
    end
else
if (featureType == 'c')
    
   for i = 1:n
    seqI = nums(i:i+d-1);
      
    
    for j = 1:k
        X(i,j) = sum(seqI == j );
        
        if(nums(i+d) == j)
            y(i,j) = 1;
        else
            y(i,j) = -1;
        end
    end
   end

end
    

end