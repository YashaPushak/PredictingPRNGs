%Configures each of the learners/classifiers

%Number of training inputs
n = 500;
%Number of validation inputs
v = 500;
%Number of test inputs
t = 500;

%Fix the seed used to generate the random data, if applicable, so that we
%are always retrieving the same data
seed = 12345;

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
    
    learner(1) = configureRandomSampling(getPRNG,n,v,t,d,k,seed);
    save(['configurations' num2str(PRNG)]);
    learner(2) = configureRandomForests(getPRNG,n,v,t,d,k,seed);
    save(['configurations' num2str(PRNG)]);
    learner(3) = configureKNN(getPRNG,n,v,t,d,k,seed);
    save(['configurations' num2str(PRNG)]);
    learner(4) = configureNaiveBayes(getPRNG,n,v,t,d,k,seed);
    save(['configurations' num2str(PRNG)]);
    learner(5) = configureLogisticRegression(getPRNG,n,v,t,d,k,seed);
    save(['configurations' num2str(PRNG)]);
    
    for k = [2,3,5]
        for d = [1,2,4,8,16,32,64,128,256]
            for i = 1:5
                [X,y,~,~,Xtest,ytest] = getPRNG(n,v,t,d,k,learner(i).featureType,learner(i).labelSize,seed);
                model = learner(i).train(X,y);
                yhat = model.predict(model,Xtest);
            end
        end
    end
    
end

