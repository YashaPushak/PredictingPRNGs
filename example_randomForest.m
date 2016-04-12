clear

for i = 1:5
    
    n = 5000;
    d = 9;
    t = 5000;
    k = 3;
    featureType = 's';
    labelSize = 1;
   %[X,y,Xtest,ytest] = rotatingPRNG(n,d,t,k,0.1,featureType,labelSize);
   %[X,y,Xtest,ytest] = matlabTwisterPRNG(n,d,t,k,featureType,labelSize);
   [X,y, Xtest, ytest] = lcgPRNG(n,d,t,k, featureType, labelSize);


% Compute validation error with bootstrapped decision tree
    depth = 10;
    nTrees = 100;
    model = randomForest(X,y,depth,nTrees);
    yhat = model.predict(model,Xtest);
    
    if(labelSize ==1 )
        err(i) = sum(yhat ~= ytest)/t;
    else
        err(i) = 1-sum(all(yhat' == ytest'))/t;
    end
    
    disp(['iteration: ' num2str(i) ]);
    fprintf('Average Error for Random Forest: %.04f \n', mean(err));
    fprintf('Median Error for Random Forest: %.04f \n', median(err));
    
    if(mod(i,100) == 0)
        cdfplot(err);
        pause(0.1);
    end
    
end

fprintf('Average Error for Random Forest: %.04f \n', mean(err));
fprintf('Median Error for Random Forest: %.04f \n', median(err));
cdfplot(err);
