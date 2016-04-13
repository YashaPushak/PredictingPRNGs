clear

for i = 1
    
    n = 1000;
    v = 1000;
    t = 1000;
    d = 12;
    k = 5;
    featureType = 's';
    labelSize = k;
    seed= 0;
    PRNGtype = 'yasha';
    
    [X,y,Xval, Yval, Xtest,ytest] = PRNGs(PRNGtype, n, v, t, d, k, featureType, labelSize, seed);

    
    model = KNN(X,y,101);
    yhat = model.predict(model,Xtest);
    err(i) = 1-sum(all(yhat' == ytest'))/t;
    
    disp(['iteration: ' num2str(i) ]);
    fprintf('Average Error for KNN: %.04f \n', mean(err));
    fprintf('Median Error for KNN: %.04f \n', median(err));
    
    if(mod(i,100) == 0)
        cdfplot(err);
        pause(0.1);
    end
end


fprintf('Average Error for KNN: %.04f \n', mean(err));
fprintf('Median Error for KNN: %.04f \n', median(err));
cdfplot(err);



