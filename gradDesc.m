function [w,f] = gradDesc(funObj,w,maxEvals,varargin)
% Find local minimizer of differentiable function

% Step size
alpha = 1e-2;

[~,k] = size(w);

% Evaluate initial function and gradient
[f,g] = funObj(w,varargin{:});
funEvals = 1;

while funEvals < maxEvals
    
    wold = w;
    if(funEvals == 1)
        %normal gradient descent to start
        w = w - alpha*g;
    else
        %BB step
        for i = 1:k
            alpha = (s(:,i)'*y(:,i))/(y(:,i)'*y(:,i));
            w(:,i) = w(:,i) - alpha*g(:,i);
        end
    end
    
    gold = g;
    [f,g] = funObj(w,varargin{:});
    funEvals = funEvals + 1;
    
    %BB update s and y
    s = w - wold;
    y = g - gold;
    
    % Print out how we are doing
    optCond = norm(g,'inf');
   % fprintf('%6d %15.5e %15.5e %15.5e\n',funEvals,alpha,f,optCond);
    
    if optCond < 0.1
        %fprintf('Solution found with optCond < 0.1\n');
        break;
    end
end

