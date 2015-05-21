function [] = value_process_plot(x, str)
%value_process_plot

F = arrayfun(@f, x(1,:), x(2,:));
plot(1:length(x), F);
ylabel('f');
xlabel('k');
title(str);


end
