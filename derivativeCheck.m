function d = derivativeCheck(funObj,x,varargin)
% diff = derivativeCheck(funObj,x,varargin)

[f,g] = funObj(x,varargin{:});

fprintf('Checking Gradient...\n');
[f2,g2] = autoGrad(x,2,funObj,varargin{:});

fprintf('Max difference between user and numerical gradient: %e\n',max(abs(g-g2)));
d = max(abs(g-g2));
if d > 1e-4
    fprintf('User NumDif:\n');
    [g g2]
    diff = abs(g-g2)
    pause
end

