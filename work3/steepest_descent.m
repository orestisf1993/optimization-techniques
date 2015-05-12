function [k] = steepest_descent(starting_point, gamma, e)
%steepest_descent Steepest descent method with constant gamma

if ~exist('gamma', 'var') || isempty(gamma)
    gamma = 0.8;
end

if ~exist('e', 'var') || isempty(e)
    e = 1e-7;
end

k = 1;

point = [starting_point zeros(2, 15)];
x = point(1, k);
y = point(2, k);
g = gradf(x ,y);

while norm(g) >= e
    point(:, k + 1) = point(:, k) - gamma * g;
    
    k = k + 1;    
    x = point(1, k);
    y = point(2, k);
    g = gradf(x ,y);    
end
end