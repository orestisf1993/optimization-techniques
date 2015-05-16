function [k, x, g] = steepest_descent(varargin)
%steepest_descent Steepest descent method with gamma given from variable input.

% default values
p = inputParser;
default_e = 1e-7;
% default_c = 2;
default_x = [0; 0];
default_gamma = 0.8;

% data type checking functions
is_point = @(x) (isnumeric(x) && all(size(x) == [2 1]) && all(isfinite(x)));
is_positive_number = @(x) (isnumeric(x) && all(x > 0) && isscalar(x) && all(isfinite(x)));
is_function_handle = @(x) (isa(x, 'function_handle'));

% parameters to the parser
% addParameter(p,'c', default_c, is_positive_number);
addParameter(p,'gamma', default_gamma, is_positive_number);
addParameter(p,'e', default_e, is_positive_number);
addParameter(p,'start_x', default_x, is_point);
addRequired(p, 'd_rule', is_function_handle);
addRequired(p, 'gamma_rule', is_function_handle);

% parse inputs and evaluate values. Initialize variables
parse(p, varargin{:});
e = p.Results.e;
gamma = p.Results.gamma;
x = p.Results.start_x;
gamma_rule = p.Results.gamma_rule;
d_rule = p.Results.d_rule;

display(e)
display(gamma)
display(x)
display(gamma_rule)

k = 1;
g = gradf(x(1,k) ,x(2,k));
d = d_rule(x, g, -1);

% main loop
while norm(g(:, k)) >= e
    gamma = gamma_rule(x, g, gamma);
    d = d_rule(x, g, d);
    x(:, k + 1) = x(:, k) - gamma * d * g(:, k);
    
    k = k + 1;
    g(:, k) = gradf(x(1,k) ,x(2, k));
end

end