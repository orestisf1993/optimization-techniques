function [gamma] = fmin_rule(x, y, g, gamma) %#ok<*INUSD>
%fmin_rule line search rule

gamma = fminbnd(@(gamma) f(x(end) - gamma * g(1), y(end) - gamma * g(2)), 0.01, 1.5/norm(g));


end

