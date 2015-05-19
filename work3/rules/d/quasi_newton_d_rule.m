function [d] = quasi_newton_d_rule(x, g, d)
%conjugate_gradient_d_rule Conjugate gradient rule for d_k.

persistent D;

j = 1;

if isnan(d)
    D = eye(2,2);
    d = -D * g;
else

    p = x(:, end) - x(:, end - 1);
    q = g(:, end) - g(:, end - 1);
    t = q' * D(:, :, end) * q;
    u = p / (p' * q) - (D(:, :, end) * q)/t;
    D(:, :, end + 1) = D(:, :, end) + (p * p') / (p' * q) - (D(:, :, end) * q * q' * D(:, :, end)) / (q' * D(:, :, end) * q) + j * t * u * u';
    d = -D(:, :, end) * g(:, end);

end
end