for PRNG = 1:4
    if PRNG == 1
        getPRNG = @(n,v,t,d,k,featureType,labelSize,seed) yashaPRNG(n,v,t,d,k,featureType,labelSize,seed);
    elseif PRNG == 2
        getPRNG = @(n,v,t,d,k,featureType,labelSize,seed) kimPRNG(n,v,t,d,k,featureType,labelSize,seed);
    elseif PRNG == 3
        getPRNG = @(n,v,t,d,k,featureType,labelSize,seed) lcgPRNG(n,v,t,d,k,featureType,labelSize,seed);
    else
        getPRNG = @(n,v,t,d,k,featureType,labelSize,seed) randomDotOrgPRNG(n,v,t,d,k,featureType,labelSize,seed);
    end
    
    %We are fixing k and d, as preliminary results indicated no strong
    %correlation between parameter settings, k and d. We note that
    %configuring 
    k = 3;
    d = 5;
    
    %Fix the seed used to generate the random data, if applicable, so that we
    %are always retrieving the same data
    seed = 0;

    randomSampling = configureRandomSampling(getPRNG,k,d);
    save configurations;
    randomForests = configureRandomForests(getPRNG,k,d);
    save configurations;
    KNN = configureKNN(getPRNG,k,d);
    save configurations;
    naiveBayes = configureNaiveBayes(getPRNG,k,d);
    save configurations;
    logisticRegression = configureLogisticRegression(getPRNG,k,d);
    save configurations;
end