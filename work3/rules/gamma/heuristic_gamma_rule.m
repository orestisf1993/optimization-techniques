function [gamma] = heuristic_gamma_rule(x, ~, gamma)
%heuristic_gamma_rule Heuristic rule for gamma.

[~, k] = size(x);
if k > 1
    
    newx = x(1, end);
    oldx = x(1, end - 1);
    newy = x(2, end);
    oldy = x(2, end - 1);
    
    if f(newx, newy) > f(oldx, oldy)
        % decrease stepsize
        gamma = 0.5 * gamma;
        gamma = [-1 gamma];
    else
        % increase stepsize
        gamma = 1.2 * gamma;
    end

end

end