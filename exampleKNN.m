clear

for i = 1:1000
    
    n = 1000;
    d = 500;
    t = 1000;
    k = 5;
    
    [X,y,Xtest,ytest] = rotatingPRNG(n,d,t,k,0.1);
    
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



