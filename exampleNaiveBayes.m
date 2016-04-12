clear

for i = 1
    
    n = 4000;
    d = 9;
    t = 4000;
    k = 3;
    

    % [X,y,Xtest,ytest] = rotatingPRNG(n,d,t,k,0.1);
    % [X,y,Xtest,ytest] = matlabTwisterPRNG(n,d,t,k,'s');
    [X,y,Xtest,ytest] = kimPRNG(n,d,t,k,'s',1);
    
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



