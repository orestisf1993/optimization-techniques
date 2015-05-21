function [d] = newton_d_rule(~, g, ~, h)
%newton_d_rule Newton rule for d_k.

h = h(:, :, end);
g = g(:, end);

d = -inv(h) * g;

end