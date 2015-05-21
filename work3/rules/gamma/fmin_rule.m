function [gamma] = fmin_rule(x, g, ~)
%fmin_rule Line search rule.

g = g(:, end);
to_min = @(gamma) f(x(1, end) - gamma * g(1), x(2, end) - gamma * g(2));
gamma = fminsearch(to_min, 0.5, optimset('TolX', 1e-2));

% gamma = fminbnd(to_min, 0.1, 1.5/norm(g));
% gamma = fminbnd(to_min, 0.1, 1);
% display(gamma)

end