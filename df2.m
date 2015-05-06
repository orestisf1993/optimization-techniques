function [y] = df2(x)
%df2 The derivative of the second function of the assigment.

global calcs;
calcs = calcs + 1;

y = 2 * x + cos(x) - 4;

end

