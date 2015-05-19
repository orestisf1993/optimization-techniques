function [d] = levenberg_marquardt_d_rule(~, g, ~, h)
%levenberg_marquardt_d_rule Levenberg-Marquardt rule for d_k.

h = h(:, :, end);
g = g(:, end);

% Find the smaller eigenvalue (negative)
m = min(eig(h));

if m > 0
    % The array was positive defined in the first place.
    m = 0;
end

% m should be positive and big enough to make the hessian positive definite.
m = abs(m) * 1.01;

% Solve the  system.
d = (h + m * eye(2,2)) \ (-g);
