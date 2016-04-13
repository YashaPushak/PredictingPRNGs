clear

for i = 1
    
    n = 1000;
    v = 1000;
    t = 1000;
    d = 12;
    k = 5;
    featureType = 's';
    labelType = k;
    
    
    PRNGtype = 'yasha';
    % [X,y,Xtest,ytest] = rotatingPRNG(n,d,t,k,0.1);
    % [X,y,Xtest,ytest] = matlabTwisterPRNG(n,d,t,k,'s');
    %[X,y,Xtest,ytest] = yashaPRNG(n,d,t,k,'c');
    %[X,y,Xtest,ytest] = lcgPRNG(n,d,t,k,'s');
    [X,y,Xval, Yval, Xtest,Ytest] = PRNGs(PRNGtype, n, v, t, d, k, featureType, labelSize, seed)

    
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



