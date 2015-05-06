function [c, calcs] = bisection( f, a, b, e, l )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

global calcs;
calcs = 0;

k = 1;

n = ceil(log2((b-a)/l));

% n = 1;
% while n <= (log(b-a) - log(l))/log(2)
%     n = n + 1;
% end
display(n)

a = [a zeros(1, 15)];
b = [b zeros(1, 15)];

iter = 0;

while b(k) - a(k) >=1 l
    iter = iter + 1;
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
display(iter);
display(k);
end

