function [learner] = configureRandomForests(getPRNG,k,d,seed)
%Configures the Random Forests function for a given PRNG, k,d, and seed, which
%uniquely define the training and validation databestErr = inf; 
%Random Forests has thre configurable parameters, the format of the features we are
%inputing to it, the depth of the trees, and the number of trees. We are
%configuring using 2 values for feature type, 5 values for depth, and 5
%INPUT:
%values for the number of trees, results in 50 configurations being tried.
%getPRNG - The random number generator function, see below for usage
%k - The number of labels outputed by the PRNG
%d - the random number seed to be used by the PRNG

%Random Forests always uses a label size of 1.
labelSize = 1;

bestErr = inf;
for featureType = ['s','c']
    %Save and restore the random number sequence
    s = rng;
    [X,y,Xval,yval,~,~] = getPRNG(n,v,t,d,k,featureType,labelSize,seed);
    rng(s);
    for depth = [3,4,5,6,7]
        for nTrees = [50,75,100,125,150]
            %Train on X test, validate on Xval
            model = randomForest(X,y,depth,nTrees);
            yhat = model.predict(model,Xval);
            
            %Compute the validation error, this depends on how the labels
            %are formatted.
            if(labelSize == 1)
                err = sum(yhat ~= yval)/t;
            else
                err = 1-sum(all(yhat' == yval'))/t;
            end
            
            %If we've found a configuration with better validation error we
            %save it to be returned later
            if(err < bestErr)
               bestErr = err;
               learner.train = @(X,y) randomForest(X,y,depth,nTrees);
               learner.featureType = featureType;
               save configureRandomForests;
            end
        end
    end
end

if(bestErr == inf)
    error('Something went wrong, we were unable to find any configuration with better validation error than infinity.');
end 
end