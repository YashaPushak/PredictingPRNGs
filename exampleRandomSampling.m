clear

for i = 1:100
    
    n = 1000;
    d = 20;
    t = 1000;
    k = 2;
    
    [X,y,Xtest,ytest] = yashaPRNG(n,d,t,k,'c');
    
    model = randomSampling(X,y);
    yhat = model.predict(model,Xtest);
    err(i) = 1-sum(all(yhat' == ytest'))/t;
    
    disp(['iteration: ' num2str(i) ]);
    fprintf('Average Error for Random Sampling: %.04f \n', mean(err));
    fprintf('Median Error for Random Sampling: %.04f \n', median(err));
    
    if(mod(i,100) == 0)
        cdfplot(err);
        pause(0.1);
    end
end


fprintf('Average Error for Random Sampling: %.04f \n', mean(err));
fprintf('Median Error for Random Sampling: %.04f \n', median(err));
cdfplot(err);



