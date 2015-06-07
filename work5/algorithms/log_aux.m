function [ B ] = log_aux(g, x, y)
%log_aux logarithmic auxiliary function

if ~inX(g,x,y)
    B = Inf;
    return
end

m = length(g);
B = 0;
for i = 1:m
    B = B - log(-g{i}(x, y));
end

end
