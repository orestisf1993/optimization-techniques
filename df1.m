function [y] = df1(x)
%df1 The derivative of the first function of the assigment.

global calcs;
calcs = calcs + 1;

y = 3 * x.^2 - 10 * x + 6;

end

