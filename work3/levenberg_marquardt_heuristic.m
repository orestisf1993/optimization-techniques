function [k, x] = levenberg_marquardt_heuristic(varargin)
%levenberg_marquardt 

% default values
p = inputParser;
default_e = 1e-7;
default_x = [-2; -1];

% data type checking functions
is_point = @(x) (isnumeric(x) && all(size(x) == [2 1]) && all(isfinite(x)));
is_positive_number = @(x) (isnumeric(x) && all(x > 0) && isscalar(x) && all(isfinite(x)));

% parameters to the parser
addParameter(p,'e', default_e, is_positive_number);
addParameter(p,'start_x', default_x, is_point);

% parse inputs and evaluate values. Initialize variables
parse(p, varargin{:});
e = p.Results.e;
x = p.Results.start_x;

k = 1;
l = 10;


% main loop
while true
    g(:, k) = gradf(x(1,k) ,x(2,k));
    if norm(g(:, k)) < e    
        break
    end
    h(:, :, k) = hessianf(x(1,k), x(2,k));
    
    B = h(:,:, k) + l * eye(2,2);
    d = B \ (-g(:, k));
    xnew = x(:, k) + d;
    if f(xnew(1), xnew(2)) > f(x(1,k), x(2,k))
        l = l * 10;
        continue;
    else
        l = l / 2;
    end
    
    x(:, k + 1) = xnew;
    k = k + 1;    
    if k > 10000
        break
    end
end
end