function [y] = df3(x)
%df3 The derivative of the third function of the assigment.

global calcs;
calcs = calcs + 1;

y = (x.^2 -2) / (x + 1) + 1 / (2 * sqrt(x + 1)) + 2 * x * log(x + 1);

end