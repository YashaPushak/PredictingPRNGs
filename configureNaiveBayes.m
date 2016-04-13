function [learner] = configureNaiveBayes(getPRNG,n,v,t,d,k,seed)
%Configures the NaiveBayes function for a given PRNG, k,d, and seed, which
%uniquely define the training and validation databestErr = inf; 
%In this setting, Naive Bayes only has 1 parameter, which is the input
%format that we give it, so we note that it only has 2 configurations being 
%tried, which is significantly less effort spent on it in its 
%configuration process than the other generators. 
%INPUT:
%getPRNG - The random number generator function, see below for usage
%n - number of training points
%v - number of validation points
%t - number of testing points
%d - the random number seed to be used by the PRNG
%k - The number of labels outputed by the PRNG

%Naive Bayes always uses a label size of 1.
labelSize = 1;

bestErr = inf;

for featureType = ['s','c']
    %Save and restore the random number sequence
    s = rng;
    [X,y,Xval,yval,~,~] = getPRNG(n,v,t,d,k,featureType,labelSize,seed);
    rng(s);
    
    %reformat features to be binary
    if (featureType =='s')
        X =reformatBayes(X,n,d,k);
        Xval = reformatBayes(Xval,n,d,k);
    elseif (featureType =='c')
        X=reformatBayes(X,n,k,d);
        Xval = reformatBayes(Xval,n,k,d);
    end
    
    %Train on X test, validate on Xval
    model = naiveBayes(X,y);
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
        learner.train = @(X,y) naiveBayes(X,y);
        learner.featureType = featureType;
        learner.labelSize = labelSize;
        learner.name = 'Naive Bayes';
        save configureNaiveBayes;
    end
end

if(bestErr == inf)
    error('Something went wrong, we were unable to find any configuration with better validation error than infinity.');
end
end