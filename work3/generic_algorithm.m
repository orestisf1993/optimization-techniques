function [k, x, g] = generic_algorithm(varargin)
%steepest_descent Steepest descent method with gamma given from variable input.

% default values
p = inputParser;
default_e = 1e-7;
default_x = [0; 0];
default_gamma = 0.8;

% data type checking functions
is_point = @(x) (isnumeric(x) && all(size(x) == [2 1]) && all(isfinite(x)));
is_positive_number = @(x) (isnumeric(x) && all(x > 0) && isscalar(x) && all(isfinite(x)));
is_function_handle = @(x) (isa(x, 'function_handle'));

% parameters to the parser
addParameter(p,'gamma', default_gamma, is_positive_number);
addParameter(p,'e', default_e, is_positive_number);
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

display(e)
display(gamma)
display(x)
display(gamma_rule)
display(use_hessian)

k = 1;
g = gradf(x(1,k) ,x(2,k));

gamma_inputs = {x, g, gamma};
d_inputs = {x, g, NaN};

if use_hessian
     h = hessianf(x(1,k), x(2,k));
    d_inputs{4} = h;
end


d = d_rule(d_inputs{:});
gamma = gamma_rule(gamma_inputs{:});
total_iterations = 0;

% main loop
while norm(g(:, k)) >= e
    total_iterations = total_iterations + 1;
    x(:, k + 1) = x(:, k) + gamma * d;
    g(:, k + 1) = gradf(x(1, k + 1) ,x(2, k + 1));
    gamma_inputs = {x, g, gamma};
    d_inputs = {x, g, d};
    if use_hessian
        h(:, :, k + 1) = hessianf(x(1, k + 1) ,x(2, k + 1));
        d_inputs{4} = h;
    end
    gamma = gamma_rule(gamma_inputs{:});
    if gamma(1) == -1
        gamma = gamma(2);
        continue;
    end
    d = d_rule(d_inputs{:});
    
    k = k + 1;
    if (k > 10000) 
        break; 
    end
end
display(total_iterations);
end