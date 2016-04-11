function [ model ] = KNN( Xtrain, Ytrain, k )

if nargin < 3,
    k = 1;
end

[~,model.classesk] = size(Ytrain);

model.Xtrain = Xtrain;
model.Ytrain = Ytrain;
model.K = k;
model.predict = @(model, Xtest) predict(model, Xtest);
end

function yhat = predict(model, Xtest)
nTest = size(Xtest, 1);
yhat = zeros(nTest, model.classesk);
dist = pdist2(Xtest, model.Xtrain);
for i=1:nTest,
    [~, perm] = sort(dist(i, :));
    s_perm = perm(1:model.K);
    s_label = model.Ytrain(s_perm,:);
    [~,class] = max(sum(s_label == 1));
    for j = 1:model.classesk
        if(j == class)
            yhat(i,j) = 1;
        else
            yhat(i,j) = -1;
        end
    end
end
end