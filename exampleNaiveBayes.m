clear

for i = 1
    
    n = 4000;
    d = 9;
    t = 4000;
    k = 3;
    featureType = 's';
    labelSize = 1;
    
    minErr =1;
    minD = 0;
    

    % [X,y,Xtest,ytest] = rotatingPRNG(n,d,t,k,0.1);
    % [X,y,Xtest,ytest] = matlabTwisterPRNG(n,d,t,k,'s');
    %[X,y,Xtest,ytest] = yashaPRNG(n,d,t,k,featureType, labelSize);
    [X,y,Xtest,ytest] = kimPRNG(n,d,t,k,featureType, labelSize);
    %[X,y,Xtest,ytest] = randomDotOrgPRNG(n,d,t,2,featureType, labelSize);
    %[X,y,Xtest,ytest] = lcgPRNG(n,d,t,5,featureType, labelSize);
    %[X,y,Xtest,ytest] = joelPRNG(n,d,t,2,featureType, labelSize);
    
    
    
    
    
    if (featureType =='s')
        X =reformatBayes(X,n,d,k);
        Xtest = reformatBayes(Xtest,n,d,k);
    else
        if (featureType =='c')
            X=reformatBayes(X,n,k,d);
            Xtest = reformatBayes(Xtest,n,k,d);
        end
    end
    
    
    
    
    model = naiveBayes(X,y);
    yhat = model.predict(model,Xtest);
    err(i) = sum(yhat ~= ytest)/t;

    
     fprintf('Best Error for Naive Bayes: %.04f \n', minErr);
    fprintf('Best D for Naive Bayes: %.04f \n', minD);
    
    disp(['iteration: ' num2str(i) ]);
    fprintf('Average Error for Naive Bayes: %.04f \n', mean(err));
    fprintf('Median Error for Naive Bayes: %.04f \n', median(err));
    
    
    
    
    if(mod(i,100) == 0)
        cdfplot(err);
        pause(0.1);
    end
end


fprintf('Average Error for Naive Bayes: %.04f \n', mean(err));
fprintf('Median Error for Naive Bayes: %.04f \n', median(err));
cdfplot(err);
