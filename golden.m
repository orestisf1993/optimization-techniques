function [a, b, n, calcs] = golden(f, a, b, l)
%golden The golden section method.

gamma = 0.618;
n = 1;
while gamma^(n-1) >= l / (b - a)
    n = n + 1;
end

global calcs;
calcs = 0;

x1 = a + (1 - gamma) * (b - a);
x2 = a + gamma * (b - a);
f1 = f(x1);
f2 = f(x2);

x1 = [x1 zeros(1, n-1)];
x2 = [x2 zeros(1, n-1)];
a = [a zeros(1, n-1)];
b = [b zeros(1, n-1)];

for k = 1: n-2
    x1(k) = a(k) + (1 - gamma) * (b(k) - a(k));
    x2(k) = a(k) + gamma * (b(k) - a(k));
    if f1 > f2
        a(k+1) = x1(k);
        b(k+1) = b(k);
        x1(k + 1) = x2(k);
        x2(k + 1) = a(k+1) + gamma * (b(k+1) - a(k+1));
        f1 = f2;
        f2 = f(x2(k+1));
    else
        a(k+1) = a(k);
        b(k+1) = x2(k);
        x1(k+1) = a(k+1) + (1-gamma) * (b(k+1) - a(k+1));
        x2(k+1) = x1(k);
        f2 = f1;
        f1 = f(x1(k+1));
    end
end

% k = n - 1
% no need to calculate f here.
if f1 > f2
    a(n) = x1(n - 1);
    b(n) = b(n - 1);
    x1(n) = x2(n - 1);
    x2(n) = a(n) + gamma * (b(n) - a(n));
else
    a(n) = a(n - 1);
    b(n) = x2(n - 1);
    x1(n) = a(n) + (1-gamma) * (b(n) - a(n));
    x2(n) = x1(n - 1);
end