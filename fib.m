function [ y ] = fib(x)

global fib_array;
if x == 0;
    y = 1;
else
    y = fib_array(x);


end

