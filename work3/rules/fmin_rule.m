function [gamma] = fmin_rule(x, y, g, ~)
%fmin_rule Line search rule.

g = g(:, end);
gamma = fminsearch(@(gamma) f(x(end) - gamma * g(1), y(end) - gamma * g(2)), 0.5);

end