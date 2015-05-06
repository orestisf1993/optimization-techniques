function [ y ] = fib(x)
%fib Calculates the fibonacci sequence of x using a fib_array.

global fib_array;
if x == 0;
    y = 1;
else
    y = fib_array(x);


end

