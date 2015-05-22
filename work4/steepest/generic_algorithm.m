function [total_iterations, x, g] = generic_algorithm(varargin)
%generic_algorithm 

% default values
p = inputParser;
default_e = 1e-8;
default_x = [-2; -1];
default_gamma = 0.8;
default_max_k = 1e4;

% data type checking functions
is_point = @(x) (isnumeric(x) && all(size(x) == [2 1]) && all(isfinite(x)));
is_positive_number = @(x) (isnumeric(x) && all(x > 0) && isscalar(x) && all(isfinite(x)));
is_function_handle = @(x) (isa(x, 'function_handle'));

% parameters to the parser
addParameter(p,'gamma', default_gamma, is_positive_number);
addParameter(p,'e', default_e, is_positive_number);
addParameter(p, 'max_k', default_max_k, is_positive_number);
addParameter(p,'start_x', default_x, is_point);
addParameter(p, 'use_hessian', false, @islogical);
addRequired(p, 'd_rule', is_function_handle);
addRequired(p, 'gamma_rule', is_function_handle);

% parse inputs and evaluate values. Initialize variables
parse(p, varargin{:});
e = p.Results.e;
gamma = p.Results.gamma;
x = p.Results.start_x;
gamma_rule = p.Results.gamma_rule;
d_rule = p.Results.d_rule;
use_hessian = p.Results.use_hessian;
max_k = p.Results.max_k;

k = 1;
total_iterations = 1;
g = gradf(x(1,k) ,x(2,k));

d_inputs = {x, g, NaN};
if use_hessian
    h = hessianf(x(1,k), x(2,k));
    d_inputs{4} = h;
end

d = d_rule(d_inputs{:});
gamma_inputs = {x, g, gamma, d};
gamma = gamma_rule(gamma_inputs{:});

% main loop
while norm(g(:, k)) >= e
    total_iterations = total_iterations + 1;
    x(:, k + 1) = x(:, k) + gamma * d;
    g(:, k + 1) = gradf(x(1, k + 1) ,x(2, k + 1));
    d_inputs = {x, g, d};
    if use_hessian
        h(:, :, k + 1) = hessianf(x(1, k + 1) ,x(2, k + 1));
        d_inputs{4} = h;
    end
    d = d_rule(d_inputs{:});
    gamma_inputs = {x, g, gamma, d};
    gamma = gamma_rule(gamma_inputs{:});
    if gamma(1) == -1
        gamma = gamma(2);
        continue;
    end   
    
    k = k + 1;
    if (k > max_k) 
        break; 
    end
end
end