function [c, n]=fibonacci_search_with_e(f, a, b, e, l)
%fibonacci_search_with_e The fibonacci search method using e.

% calculate n
n=2;
global fib_array;
fib_array(1) = 0;
fib_array(2) = 1;
% Fn > (b - a) / l
while( fib_array(n) <= (b - a) / l)
   n = n + 1;
   fib_array(n) = fib_array(n-1) + fib_array(n-2);
end

% calculate initial values of x1, x2, f1 and f2
% 2 calculations of f here.

x1 = a + fib(n - 2) / fib(n) * (b - a);
x2 = a + fib(n - 1) / fib(n) * (b - a);
f1 = f(x1);
f2 = f(x2);

% Allocate space for a, b, x1 and x2
a = [a zeros(1, n-1)];
b = [b zeros(1, n-1)];
x1 = [x1 zeros(1, n-1)];
x2 = [x2 zeros(1, n-1)];

% n - 4 calculations of f here
for k = 1: n-3
    if f1 > f2
        a(k+1) = x1(k);
        b(k+1) = b(k);
        x1(k+1) = x2(k);
        x2(k+1) = a(k + 1) + fib(n - k - 1) / fib(n - k) * (b(k + 1) - a(k + 1));
        f1 = f2;
        f2 = f(x2(k + 1));
    else
        a(k+1) = a(k);
        b(k+1) = x2(k);
        x1(k+1) = a(k + 1) + fib(n - k -2) / fib(n -k) * (b(k+1) - a(k+1));
        x2(k+1) = x1(k);
        f2 = f1;
        f1 = f(x1(k + 1));
    end
end

% k = n - 2
% no need to calculate f here.
if f1 > f2
    a(n - 1) = x1(n - 2);
    b(n - 1) = b(n - 2);
    x1(n - 1) = x2(n - 2);
    x2(n - 1) = a(n - 1) + fib(1) / fib(2) * (b(n - 1) - a(n - 1));
else
    a(n - 1) = a(n - 2);
    b(n - 1) = x2(n - 2);
    x1(n - 1) = a(n - 1);
    x2(n - 1) = x1(n - 2);
end

% 2 calculations of f here.
x1(n) = x1(n - 1);
x2(n) = x1(n - 1) + e;
if f(x1(n)) > f(x2(n))
    a(n) = x1(n);
    b(n) = b(n-1);
else
    a(n) = a(n-1);
    b(n) = x1(n);
end

c = (a(n) + b(n))/2;