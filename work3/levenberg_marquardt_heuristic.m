function [total_iterations, x] = levenberg_marquardt_heuristic(varargin)
%levenberg_marquardt 

% default values
p = inputParser;
default_e = 1e-8;
default_x = [-2; -1];
default_m = 0.05;

% data type checking functions
is_point = @(x) (isnumeric(x) && all(size(x) == [2 1]) && all(isfinite(x)));
is_positive_number = @(x) (isnumeric(x) && all(x > 0) && isscalar(x) && all(isfinite(x)));
is_bigger_than_one = @(x) (isnumeric(x) && all(x > 1) && isscalar(x) && all(isfinite(x)));

% parameters to the parser
addParameter(p,'e', default_e, is_positive_number);
addParameter(p,'start_m', default_m, is_positive_number);
addParameter(p,'increase', 7, is_bigger_than_one);
addParameter(p,'decrease', 17, is_bigger_than_one);
addParameter(p,'start_x', default_x, is_point);

% parse inputs and evaluate values. Initialize variables
parse(p, varargin{:});
e = p.Results.e;
x = p.Results.start_x;
m = p.Results.start_m;

k = 1;
total_iterations = 0;
fold = f(x(1,k), x(2,k));

% main loop
while true    
    g(:, k) = gradf(x(1,k) ,x(2,k));
    if norm(g(:, k)) < e    
        break
    end
    total_iterations = total_iterations + 1;
    h(:, :, k) = hessianf(x(1,k), x(2,k));
    
    B = h(:,:, k) + m * eye(2,2);
    d = B \ (-g(:, k));
    xnew = x(:, k) + d;
    fnew = f(xnew(1), xnew(2));
    if  fnew > fold
        m = m * p.Results.increase;
        continue;
    else
        m = m / p.Results.decrease;
        fold = fnew;
    end
    
    x(:, k + 1) = xnew;
    k = k + 1;    
    if k > 10000
        break
    end
end
end