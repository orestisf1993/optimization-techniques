function [gamma] = heuristic_gamma_rule(x, y, g, gamma)
%heuristic_gamma_rule Heuristic rule for gamma.

if length(x) > 1
    
    newx = x(end);
    oldx = x(end - 1);
    newy = y(end);
    oldy = y(end - 1);
    
    if f(newx, newy) > f(oldx, oldy)
        % decrease stepsize
        gamma = 0.5 * gamma;
    else
        % increase stepsize
        gamma = 1.2 * gamma;
    end

end

end