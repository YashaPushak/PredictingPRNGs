clear

for i = 1
    
    n = 4000;
    v = 1000;
    t = 4000;
    d = 9;
    k = 2;
    featureType = 's';
    labelSize = 1;
    seed= 0;
    PRNGtype = 'yasha';
    
    [X,y,Xval, Yval, Xtest,ytest] = PRNGs(PRNGtype, n, v, t, d, k, featureType, labelSize, seed);
    
    
    if (featureType =='s')
        X =reformatBayes(X,n,d,k);
        Xtest = reformatBayes(Xtest,n,d,k);
    elseif (featureType =='c')
        X=reformatBayes(X,n,k,d);
        Xtest = reformatBayes(Xtest,n,k,d);
        
    end
    
    model = naiveBayes(X,y);
    yhat = model.predict(model,Xtest);
    err(i) = sum(yhat ~= ytest)/t;
    
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
