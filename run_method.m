lvalues = 1/10000000 : 1/10000000 : 0.1;
k = zeros(1, length(lvalues));
parfor i = 1: length(lvalues)    
    [c, tmp] = golden(f, a, b, lvalues(i));
    k(i) = tmp;
end
figure;
plot(lvalues, k * 2)

