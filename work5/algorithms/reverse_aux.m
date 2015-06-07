function [ B ] = reverse_aux(g, x, y)
%reverse_aux reverse auxiliary function

if ~inX(g,x,y)
    B = Inf;
    return
end

m = length(g);
B = 0;
for i = 1:m
    B = B - 1./g{i}(x, y);
end

end

