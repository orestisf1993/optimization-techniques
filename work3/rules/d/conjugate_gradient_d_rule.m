function [d] = conjugate_gradient_d_rule(~, g, d)
%conjugate_gradient_d_rule Conjugate gradient rule for d_k.

if isnan(d)
    d = -g;
else
    oldg = g(:, end - 1);
    g = g(:, end);
    b = (g' * (g - oldg)) / (oldg' * oldg);
    d = -g + b * d;
    
    if(abs(g' * oldg) > 0.1 * (norm(oldg))^2)
                d = -g;
    end
end
end
