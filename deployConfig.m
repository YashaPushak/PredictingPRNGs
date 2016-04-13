%Configures each of the learners/classifiers

%Number of training inputs
n = 500;
%Number of validation inputs
v = 500;
%Number of test inputs
t = 500;

%Fix the seed used to generate the random data, if applicable, so that we
%are always retrieving the same data
seed = 0;

for PRNG = 1:4
    if PRNG == 1
        getPRNG = @(n,v,t,d,k,featureType,labelSize,seed) PRNGs('yasha',n,v,t,d,k,featureType,labelSize,seed);
    elseif PRNG == 2
        getPRNG = @(n,v,t,d,k,featureType,labelSize,seed) PRNGs('kim',n,v,t,d,k,featureType,labelSize,seed);
    elseif PRNG == 3
        getPRNG = @(n,v,t,d,k,featureType,labelSize,seed) PRNGs('lcg',n,v,t,d,k,featureType,labelSize,seed);
    else
        getPRNG = @(n,v,t,d,k,featureType,labelSize,seed) PRNGs('random.org',n,v,t,d,k,featureType,labelSize,seed);
    end
    
    %We are fixing k and d, as preliminary results indicated no strong
    %correlation between parameter settings, k and d. We note that
    %configuring
    k = 3;
    d = 5;
    
    randomSampling = configureRandomSampling(getPRNG,n,v,t,d,k,seed);
    save configurations;
    randomForests = configureRandomForests(getPRNG,n,v,t,d,k,seed);
    save configurations;
    KNN = configureKNN(getPRNG,n,v,t,d,k,seed);
    save configurations;
    naiveBayes = configureNaiveBayes(getPRNG,n,v,t,d,k,seed);
    save configurations;
    logisticRegression = configureLogisticRegression(getPRNG,n,v,t,d,k,seed);
    save configurations;
end