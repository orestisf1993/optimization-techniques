function [] = process_plot(x, X, Y, Z, title_str)
%process_plot 

contour(X, Y, Z, 25);
ylabel('y');
xlabel('x');
title(title_str);
hold on;
plot(x(1, :), x(2, :), 'r*');
plot(x(1, :), x(2, :), 'k');
hold off;

end
