%Configures each of the learners/classifiers

%Number of training inputs
n = 100;
%Number of validation inputs
v = 100;
%Number of test inputs
t = 100;

%Fix the seed used to generate the random data, if applicable, so that we
%are always retrieving the same data
seed = 12345;

for PRNG = 1:4
    fid = fopen(['Configure_PRNG=' num2str(PRNG) '.txt'],'w');
    
    
    if PRNG == 1
        fprintf(fid,'#Configuration times for Yasha\n');
        getPRNG = @(n,v,t,d,k,featureType,labelSize,seed) PRNGs('yasha',n,v,t,d,k,featureType,labelSize,seed);
    elseif PRNG == 2
        fprintf(fid,'#Configuration times for Kim\n');
        getPRNG = @(n,v,t,d,k,featureType,labelSize,seed) PRNGs('kim',n,v,t,d,k,featureType,labelSize,seed);
    elseif PRNG == 3
        fprintf(fid,'#Configuration times for LCG\n');
        getPRNG = @(n,v,t,d,k,featureType,labelSize,seed) PRNGs('lcg',n,v,t,d,k,featureType,labelSize,seed);
    else
        fprintf(fid,'#Configuration times for random.org\n');
        getPRNG = @(n,v,t,d,k,featureType,labelSize,seed) PRNGs('random.org',n,v,t,d,k,featureType,labelSize,seed);
    end
    
    fprintf(fid,'#Algorithm name, configuration time, [param name], [param value], ...\n');
    
    %We are fixing k and d, as preliminary results indicated no strong
    %correlation between parameter settings, k and d. We note that
    %configuring
    k = 3;
    d = 5;
    
    tic;
    learner(1) = configureRandomSampling(getPRNG,n,v,t,d,k,seed);
    timeTrain = toc;
    fprintf(fid,['Random Sampling, ' num2str(timeTrain) ', featureType, ' learner(1).featureType ', labelSize, ' num2str(learner(1).labelSize) '\n']);
    save(['configurations' num2str(PRNG)]);
    
    tic;
    learner(2) = configureRandomForests(getPRNG,n,v,t,d,k,seed);
    timeTrain = toc;
    fprintf(fid,['Random Forests, ' num2str(timeTrain) ', depth, ' num2str(learner(2).depth) ', nTrees, ' num2str(learner(2).nTrees) ', featureType, ' learner(1).featureType ', labelSize, ' num2str(learner(1).labelSize) '\n']);
    save(['configurations' num2str(PRNG)]);
    
    tic;
    learner(3) = configureKNN(getPRNG,n,v,t,d,k,seed);
    timeTrain = toc;
    fprintf(fid,['KNN, ' num2str(timeTrain) ', neighbours, ' num2str(learner(3).neighbours) ', featureType, ' learner(3).featureType ', labelSize, ' num2str(learner(3).labelSize) '\n']);
    save(['configurations' num2str(PRNG)]);
    
    tic;
    learner(4) = configureNaiveBayes(getPRNG,n,v,t,d,k,seed);
    timeTrain = toc;
    fprintf(fid,['Naive Bayes, ' num2str(timeTrain) ', featureType, ' learner(4).featureType ', labelSize, ' num2str(learner(4).labelSize) '\n']);
    save(['configurations' num2str(PRNG)]);
    
    
    learner(5) = configureLogisticRegression(getPRNG,n,v,t,d,k,seed);
    timeTrain = toc;
    fprintf(fid,['Logistic Regression, ' num2str(timeTrain) ', lambda, ' num2str(learner(5).lambda) ', featureType, ' learner(5).featureType ', labelSize, ' num2str(learner(5).labelSize) '\n']);
    save(['configurations' num2str(PRNG)]);
    
    fclose(fid);
    
    fid = fopen(['TestData_PRNG=' num2str(PRNG) '.txt'],'w');
    fprintf(fid, ['Test Data for PRNG = ' num2str(PRNG) '\n']);
    fprintf(fid,'#Algorithm name, k, d, training time, testing time, error\n');
    for k = [2,3,5]
        for d = [1,2,4,8,16,32,64,128,256]
            for i = 1:5
                [X,y,~,~,Xtest,ytest] = getPRNG(n,v,t,d,k,learner(i).featureType,learner(i).labelSize,seed);
                
                tic;
                model = learner(i).train(X,y);
                trainTime = toc;
                
                tic;
                yhat = model.predict(model,Xtest);
                testTime = toc;
                
                %Compute the test error, this depends on how the labels
                %are formatted.
                if(learner(i).labelSize == 1)
                    err = sum(yhat ~= ytest)/t;
                else
                    err = 1-sum(all(yhat' == ytest'))/t;
                end
                
                fprintf(fid, [learner(i).name ', ' k ', ' d ', ' trainTime ', ' testTime ', ' err '\n']);
                
            end
        end
    end
    
    fclose(fid);
    
end

