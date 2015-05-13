function [k, x, y, g] = steepest_descent(varargin)
%steepest_descent Steepest descent method with gamma given from variable input.

% default values
p = inputParser;
default_e = 1e-7;
default_c = 2;
default_point = [0; 0];
default_gamma = 1;

% data type checking functions
is_point = @(x) (isnumeric(x) && all(size(x) == [2 1]) && all(isfinite(x)));
is_positive_number = @(x) (isnumeric(x) && all(x > 0) && isscalar(x) && all(isfinite(x)));
is_function_handle = @(x) (isa(x, 'function_handle'));

% parameters to the parser
addParameter(p,'c', default_c, is_positive_number);
addParameter(p,'gamma', default_gamma, is_positive_number);
addParameter(p,'e', default_e, is_positive_number);
addParameter(p,'point', default_point, is_point);
addRequired(p, 'gamma_rule', is_function_handle);

% parse inputs and evaluate values. Initialize variables
parse(p, varargin{:});
e = p.Results.e;
gamma = p.Results.gamma;
point = p.Results.point;
gamma_rule = p.Results.gamma_rule;

display(e)
display(gamma)
display(point)
display(gamma_rule)

k = 1;
x = point(1, k);
y = point(2, k);
g = gradf(x ,y);

% main loop
while norm(g(:, k)) >= e
    gamma = gamma_rule(x, y, g, gamma);
    point(:, k + 1) = point(:, k) - gamma * g(:, k);
    
    k = k + 1;
    x(k) = point(1, k);
    y(k) = point(2, k);
    g(:, k) = gradf(x(k) ,y(k));
end

end