function [gamma] = fmin_rule_bounded(x, g, ~, d)
%fmin_rule Line search rule.

% g = g(:, end);
% to_min = @(gamma) f(x(1, end) - gamma * g(1), x(2, end) - gamma * g(2));
% [a, b, ~, ~] = golden(to_min, 0.01, 0.2/norm(d), 1e-3);
% gamma = (a(:,end) + b(:,end)) / 2;


g = g(:, end);
to_min = @(gamma) f(x(1, end) - gamma * g(1), x(2, end) - gamma * g(2));
gamma = fminbnd(to_min, 0.01, 0.2/norm(d), optimset('TolX', 1e-2));
% [a, b, ~, ~] = golden(to_min, 0.01, 0.2/norm(d), 1e-3);
% gamma = (a(:,end) + b(:,end)) / 2;

end