function [learner] = configureLogisticRegression(getPRNG,k,d,seed)
%Configures the logisticRegression function for a given PRNG, k,d, and seed, which
%uniquely define the training and validation databestErr = inf;
%In this setting, logistic regression  has 2 parameters, the input
%format that we give it, and the regularization constant, lambda.
%We try 2 values for feature type and 25 values for lambda so that we have
%a total of 50 configurations that we are trying.
%This logistic regression function is being trained with the
%barzilai-borwein algorithm, while this could be a point for configuration,
%we found that it was most effective through previous experimentation. This
%could be considered as skewing our results by spending more time
%configuring this algorithm than the others.
%INPUT:
%getPRNG - The random number generator function, see below for usage
%k - The number of labels outputed by the PRNG
%d - the random number seed to be used by the PRNG

%Logistic Regression always uses a label size of 1.
labelSize = 1;

bestErr = inf;
for featureType = ['s','c']
    %Save and restore the random number sequence
    s = rng;
    [X,y,Xval,yval,~,~] = getPRNG(n,v,t,d,k,featureType,labelSize,seed);
    rng(s);
    for lambda = 2.^(-20:5)
        %Train on X test, validate on Xval
        model = regularizedLogisticRegression(X,y,lambda);
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
            learner.train = @(X,y) regularizedLogistic(X,y,lambda);
            learner.featureType = featureType;
            save configureKNN;
        end
    end
end


if(bestErr == inf)
    error('Something went wrong, we were unable to find any configuration with better validation error than infinity.');
end
end