function [y] = error_sum(x, nGaussian, u1, u2)
%ERROR_SUM The sum of all errors^2 between f() and the Gaussian approximation
    % f(u1, u2) - gaussianSum() for every x vector.
    diff = bsxfun(@minus, f(u1, u2), gaussianSum(x, nGaussian, u1, u2));
    % sum of each row, power of 2
    y = sum((diff).^2, 2);
end
