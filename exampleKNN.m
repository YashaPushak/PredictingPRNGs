clear

for i = 1:1000
    
    n = 1000;
    d = 500;
    t = 1000;
    k = 3;
    
    [X,y,Xtest,ytest] = matlabTwisterPRNG(n,d,t,k);
    
    model = KNN(X,y,101);
    yhat = model.predict(model,Xtest);
    err(i) = sum(sum(yhat ~= ytest))/(t*k);
    
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



