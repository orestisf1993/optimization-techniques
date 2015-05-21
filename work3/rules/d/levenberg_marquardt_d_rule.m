function [d] = levenberg_marquardt_d_rule(~, g, ~, h)
%levenberg_marquardt_d_rule Levenberg-Marquardt rule for d_k.

h = h(:, :, end);
g = g(:, end);
m = max(abs(eig(h))) * 1.05;
h = h + m * eye(2,2);
d = h\(-g);