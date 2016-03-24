function [X,y] = reformat(nums,n,d,k)
%% Reformat a sequence of numbers into training set and labels

X = zeros(n,d);
y = zeros(n,k-1);
%TODO: I'm using k-1 right now because I haven't converted logistic
%regression to a multi-clas model yet. This will need to be updated.

for i = 1:n
    X(i,:) = nums(i:i+d-1);
    for j = 1:k-1
        if(nums(i+d) == j)
            y(i,j) = 1;
        else
            y(i,j) = -1;
        end
    end
end

end