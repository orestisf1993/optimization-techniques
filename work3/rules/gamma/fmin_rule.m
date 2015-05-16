function [gamma] = fmin_rule(x, g, ~)
%fmin_rule Line search rule.

g = g(:, end);
gamma = fminsearch(@(gamma) f(x(1, end) - gamma * g(1), x(2, end) - gamma * g(2)), 0.5);

end