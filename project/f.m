function [y] = f(u1, u2)
%F

y = sin(u1 + u2) .* sin(u1.^2);


end
