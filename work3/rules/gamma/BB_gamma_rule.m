function [gamma] = BB_gamma_rule(x, y, g, gamma)
%BB_gamma_rule Barzilai and Borwein (BB method) for the step

if length(x) > 1
    dx = x(end) - x(end - 1);
    dy = y(end) - y(end - 1);
    d = [dx; dy];
    dg = g(:, end) - g(:, end - 1);
    gamma = abs(((dg') * d)/((dg') * dg));
    if isnan(gamma)
        gamma = 1/2;
    end
end

end

