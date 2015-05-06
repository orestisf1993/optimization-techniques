function [ y ] = f2( x )
%f2 The second function of the assigment.

global calcs;
calcs = calcs + 1;

y = (x-2)^2 + sin(x);

end

