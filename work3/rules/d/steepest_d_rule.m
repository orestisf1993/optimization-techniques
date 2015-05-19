function [d] = steepest_d_rule(~, g, ~)
%steepest_d_rule Steepest descent rule for d_k.

d = -eye(2, 2) * g(:, end);

end