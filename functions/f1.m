function [ y ] = f1( x )
%f1 The first function of the assigment.

global calcs;
calcs = calcs + 1;

y = (x-2)^3 + (x-3)^2;

end