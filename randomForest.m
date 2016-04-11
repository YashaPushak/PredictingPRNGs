function [model] = randomForest(X,y,depth,nBootstraps)
% w = randomForest(X,y,depth,nBootstraps)
%
% Computes Bootstrapped Random Tree Classifier

[N,D] = size(X);

for k = 1:nBootstraps
    %sample = 1:N;
    sample = randi([1,N], 1,N)
    model.subModel{k} = randomTree(X(sample,:),y(sample),depth);
end

model.predict = @predict;

end

function [y] = predict(model,X)

for k = 1:length(model.subModel)
    y(:,k) = model.subModel{k}.predict(model.subModel{k},X);
end
y = mode(y,2);
end