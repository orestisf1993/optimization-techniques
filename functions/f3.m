function [ y ] = f3( x )
%f3 The third function of the assigment.

global calcs;
calcs = calcs + 1;

y = sqrt(x+1) + (x^2 - 2) * log(x+1);

end