function [point] = steepest_descent2(point, e)
%steepest_descent2 Steepest descent method with variable gamma

if ~exist('e', 'var') || isempty(e)
    e = 1e-7;
end

k = 1;
x = point(1, k);
y = point(2, k);
g = gradf(x ,y);

while norm(g) >= e
    to_min = @(gamma) f(x - gamma * g(1), y - gamma * g(2));
    gamma = fminbnd(to_min, 0, 5);
    point(:, k + 1) = point(:, k) - gamma * g;
    
    k = k + 1;    
    x = point(1, k);
    y = point(2, k);
    g = gradf(x ,y);    
end
end