function [z] = gaussianSum(x, nGaussian, u1, u2)
%GAUSSIANSUM The sum of Gaussian functions given u1, u2 coordinates and their
%constants

    a = x(:, 1:nGaussian);
    sigma = x(:, nGaussian + 1:nGaussian*3);
    c = x(:, nGaussian*3 + 1:end);
    
    z = 0;
    for i = 1:nGaussian
        z = z + bsxfun(@times, a(:, i), exp(...
            -bsxfun(@rdivide, (bsxfun(@minus, u1, c(:, i*2 - 1))).^2, 2*(sigma(:, i*2 - 1)).^2) + ...
            -bsxfun(@rdivide, ((bsxfun(@minus, u2, c(:, i*2))).^2),2*(sigma(:, i*2)).^2) ...
            ));
    end

end
