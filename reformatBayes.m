function [ Xbayes ] = reformatBayes( X,n, features, possibleValues)


Xbayes = zeros(n, features*possibleValues);
for i = 1:n
    index = 1;
    for j = 1:features
        
        for c = 1:possibleValues
            if (X(i,j) == c)
                Xbayes(i,index+c-1) = 1;
            end
        end
        index = index + possibleValues;
                

    end
end


end

