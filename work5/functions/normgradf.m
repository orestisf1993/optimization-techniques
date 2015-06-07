function [z] = normgradf(x,y)
%NORMGRADF norm of grad f(x,y)

z = sqrt((4 * x - 3* y).^2 + (-3 * x + 4 * y).^2);

end

