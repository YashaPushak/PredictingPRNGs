function [model] = randomStump(X,y)
% [model] = randomStump(X,y)
%
% Fits a decision stump that splits on a single variable,
%   assuming that X is binary {0,1}, and y is categorical {1,2,3,...,C}.

% Compute number of training examples and number of features
[N,D] = size(X);

% Computer number of class lables
C = max(y);

% Address the trivial case where we do not split
count = zeros(C,1);
for n = 1:N
    count(y(n)) = count(y(n)) + 1;
end
[maxCount,maxLabel] = max(count);

% Compute total entropy
p = count/sum(count); % Convert to probabilities
entropyTotal = -sum(p.*log0(p));

maxGain = 0;
splitVariable = [];
splitThreshold = [];
splitLabel0 = maxLabel;
splitLabel1 = [];

% Loop over features looking for the best split
if any(y ~= y(1))
    d = randi([1,D]);
        thresholds = sort(unique(X(:,d)));
        
        for t = thresholds'
            
            % Count number of class labels where the feature is greater than threshold
            count1 = zeros(C,1);
            count1b = zeros(C,1);
%             for n = find(X(:,d) > t)'
%                 count1b(y(n)) = count1b(y(n)) + 1;
%             end
            for c = 1:C
                
               count1(c)= sum(X(y==c,d) > t) ;
            end
            
            count0 = count-count1;
                        
            % Compute infogain
            p1 = count1/sum(count1);
            p0 = count0/sum(count0);
            H1 = -sum(p1.*log0(p1));
            H0 = -sum(p0.*log0(p0));
            prob1 = sum(X(:,d) > t)/N;
            prob0 = 1-prob1;
            infoGain = entropyTotal - prob1*H1 - prob0*H0;
            
            % Compare to minimum error so far
            if infoGain > maxGain
                % This is the lowest error, store this value
                maxGain = infoGain;
                splitVariable = d;
                splitThreshold = t;
                % Compute majority class
                [maxCount,splitLabel1] = max(count1);
                [maxCount,splitLabel0] = max(count0);
            end
        end
    
end
model.splitVariable = splitVariable;
model.splitThreshold = splitThreshold;
model.label1 = splitLabel1;
model.label0 = splitLabel0;
model.predict = @predict;
end

function [y] = predict(model,X)
[T,D] = size(X);

if isempty(model.splitVariable)
    y = model.label0*ones(T,1);
else
    y = zeros(T,1);
    for n = 1:T
        if X(n,model.splitVariable) > model.splitThreshold
            y(n,1) = model.label1;
        else
            y(n,1) = model.label0;
        end
    end
end
end