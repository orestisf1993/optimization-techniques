function [ b ] = inX(g, x, y)
%inX inX

for i = 1:length(g)
    if g{i}(x, y) > 0
        b = false;
        return;
    end

end

b = true;
