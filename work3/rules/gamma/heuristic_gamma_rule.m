function [gamma] = heuristic_gamma_rule(x, ~, gamma, ~)
%heuristic_gamma_rule Heuristic rule for gamma.

persistent fold;

[~, k] = size(x);
newx = x(1, end);
newy = x(2, end);

if k > 1    
    fnew = f(newx, newy);
    
    if fnew > fold
        % decrease stepsize
        gamma = 0.5 * gamma;
        gamma = [-1 gamma];
    else
        % increase stepsize
        gamma = 1.2 * gamma;
        fold = fnew;
    end

else
    fold = f(newx, newy);

end