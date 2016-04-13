function [learner] = configureKNN(getPRNG,n,v,t,d,k,seed)
%Configures the KNN function for a given PRNG, k,d, and seed, which
%uniquely define the training and validation databestErr = inf;
%KNN has two configurable parameters, the format of the features we are
%inputing to it, and the number of neighbours considered. We are checking 2
%values for the feature type, and 25 values for the number of neighbours,
%this results in a total of 50 configurations being tested.
%INPUT:
%getPRNG - The random number generator function, see below for usage
%n - number of training points
%v - number of validation points
%t - number of testing points
%d - the random number seed to be used by the PRNG
%k - The number of labels outputed by the PRNG


%KNN always uses a label size of k.
labelSize = k;

bestErr = inf;
for featureType = ['s','c']
    %Save and restore the random number sequence
    s = rng;
    [X,y,Xval,yval,~,~] = getPRNG(n,v,t,d,k,featureType,labelSize,seed);
    rng(s);
    for neighbours = [21,25,31,35,41,45,51,55,61,65,71,75,81,85,91,95,101,105,111,115,121]
        %Train on X test, validate on Xval
        model = KNN(X,y,neighbours);
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
            learner.train = @(X,y) KNN(X,y,neighbours);
            learner.featureType = featureType;
            learner.neighbours = neighbours;
            save configureKNN;
        end
    end
end


if(bestErr == inf)
    error('Something went wrong, we were unable to find any configuration with better validation error than infinity.');
end
end