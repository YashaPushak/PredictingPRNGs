%Configures each of the learners/classifiers

%Number of training inputs
n = 150;
%Number of validation inputs
v = 150;
%Number of test inputs
t = 150;

%Fix the seed used to generate the random data, if applicable, so that we
%are always retrieving the same data
seed = 12345;

for PRNG = 1:4
    fprintf(['Configuring and Testing PRNG =' num2str(PRNG)  '\n']);
    fid = fopen(['Configure_PRNG=' num2str(PRNG) '.csv'],'w');
    
    
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
    learner(1).config = configureRandomSampling(getPRNG,n,v,t,d,k,seed);
    timeTrain = toc;
    fprintf(fid,['Random Sampling, ' num2str(timeTrain) ', featureType, ' learner(1).config.featureType ', labelSize, ' num2str(learner(1).config.labelSize) '\n']);
    save(['configurations' num2str(PRNG)]);
    
    tic;
    learner(2).config = configureRandomForests(getPRNG,n,v,t,d,k,seed);
    timeTrain = toc;
    fprintf(fid,['Random Forests, ' num2str(timeTrain) ', depth, ' num2str(learner(2).config.depth) ', nTrees, ' num2str(learner(2).config.nTrees) ', featureType, ' learner(2).config.featureType ', labelSize, ' num2str(learner(2).config.labelSize) '\n']);
    save(['configurations' num2str(PRNG)]);
    
    tic;
    learner(3).config = configureKNN(getPRNG,n,v,t,d,k,seed);
    timeTrain = toc;
    fprintf(fid,['KNN, ' num2str(timeTrain) ', neighbours, ' num2str(learner(3).config.neighbours) ', featureType, ' learner(3).config.featureType ', labelSize, ' num2str(learner(3).config.labelSize) '\n']);
    save(['configurations' num2str(PRNG)]);
    
    tic;
    learner(4).config = configureNaiveBayes(getPRNG,n,v,t,d,k,seed);
    timeTrain = toc;
    fprintf(fid,['Naive Bayes, ' num2str(timeTrain) ', featureType, ' learner(4).config.featureType ', labelSize, ' num2str(learner(4).config.labelSize) '\n']);
    save(['configurations' num2str(PRNG)]);
    
    
    learner(5).config = configureLogisticRegression(getPRNG,n,v,t,d,k,seed);
    timeTrain = toc;
    fprintf(fid,['Logistic Regression, ' num2str(timeTrain) ', lambda, ' num2str(learner(5).config.lambda) ', featureType, ' learner(5).config.featureType ', labelSize, ' num2str(learner(5).config.labelSize) '\n']);
    save(['configurations' num2str(PRNG)]);
    
    fclose(fid);
    
    fid = fopen(['TestData_PRNG=' num2str(PRNG) '.csv'],'w');
    fprintf(fid, ['Test Data for PRNG = ' num2str(PRNG) '\n']);
    fprintf(fid,'#Algorithm name, k, d, training time, testing time, error\n');
    for k = [2,3,5]
        for d = [1,2,4,8,16,32,64,128,256]
            for i = 1:5
                if( learner(i).config.labelSize ==1)
                    labelSize =1;
                else labelSize = k;
                end
                [X,y,~,~,Xtest,ytest] = getPRNG(n,v,t,d,k,learner(i).config.featureType,labelSize,seed);
                
                tic;
                model = learner(i).config.train(X,y);
                trainTime = toc;
                
                tic;
                yhat = model.predict(model,Xtest);
                testTime = toc;
                
                %Compute the test error, this depends on how the labels
                %are formatted.
                if(learner(i).config.labelSize == 1)
                    err = sum(yhat ~= ytest)/t;
                else
                    err = 1-sum(all(yhat' == ytest'))/t;
                end
                
                fprintf(fid, [num2str(learner(i).config.name) ', ' num2str(k) ', ' num2str(d) ', ' num2str(trainTime) ', ' num2str(testTime) ', ' num2str(err) '\n']);
                
            end
        end
    end
    
    fclose(fid);
    
end

