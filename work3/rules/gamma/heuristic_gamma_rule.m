function [gamma] = heuristic_gamma_rule(x, ~, gamma)
%heuristic_gamma_rule Heuristic rule for gamma.

if length(x) > 1
    
    newx = x(1, end);
    oldx = x(1, end - 1);
    newy = x(2, end);
    oldy = x(2, end - 1);
    
    if f(newx, newy) > f(oldx, oldy)
        % decrease stepsize
        gamma = 0.1 * gamma;
    else
        % increase stepsize
        gamma = 1.2 * gamma;
    end
    display(gamma)

end

end