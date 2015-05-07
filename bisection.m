function [a, b, k, n, calcs] = bisection(f, a, b, e, l)
%bisection The bisection method.

% calculate the theoritical number of iterations, n
n = 1;
while (1/2)^n > l / (b - a)
    n = n + 1;
end

% initialize values

global calcs;
calcs = 0;
k = 1;
a = [a zeros(1, n)];
b = [b zeros(1, n)];

while b(k) - a(k) >= l
    c = (a(k) + b(k))/2;
    x1 = c - e;
    x2 = c + e;
    if f(x1) < f(x2)
        a(k + 1) = a(k);
        b(k + 1) = x2;
    else
        a(k + 1) = x1;
        b(k + 1) = b(k);
    end
    k = k + 1;
end
k = k - 1;
end