% Script that runs all the plots and functions needed for the work3.pdf report
%%  ----------------------- Initialization -------------------------------------

close all;
clear all;

% save images in new folder plots. If the folder exists we still save them there
mkdir plots
cd plots

%%  ----------------------- Calculate needed values ----------------------------

% find f minimum
to_min = @(x)f(x(1), x(2));
[minX, minf] = fminsearch(to_min,[-8, 8]);
minx = minX(1);
miny = minX(2);

% calculate needed values for plots
X = -3:0.1:3;
Y = X;

for i=1:length(X)
    for j=1:length(Y)
        Z(i,j) = f(X(i),Y(j));
        g = gradf(X(i), Y(j));
        Gnorm(i,j) = norm(g);
        U(i, j) = g(1);
        V(i, j) = g(2);
    end
end


%%  ----------------------- Function plots -------------------------------------

mkdir functions
cd functions

% f plots
fig = figure('visible','off'); % create not visible figure

% mesh plot
mesh(X, Y, Z);
hold on;
ylabel('y');
xlabel('x');
title('f mesh plot');
colorbar;
save_plot(fig, '000f_mesh_plot');

% surf plot
hold off;
surf(X, Y, Z);
hold on;
ylabel('y');
xlabel('x');
title('f surf plot');
colorbar;
save_plot(fig, '001f_surf_plot');

% contour plots
hold off;
contour(X, Y, Z, 11, 'ShowText','on');
ylabel('y');
xlabel('x');
title('f contour plot');
save_plot(fig, '002f_contour_plot_showtext');

contourf(X, Y, Z);
hold on;
ylabel('y');
xlabel('x');
title('f contour plot');
colorbar;
save_plot(fig, '003f_contour_plot_fill');

hold off;
contourf(X, Y, Z, -0.6:0.1:0.6);
hold on;
ylabel('y');
xlabel('x');
title('f contour plot');
colorbar;
plot(minx, miny,'d');
text(minx, miny + 0.05, 'min');
save_plot(fig, '004f_contour_plot_fill_min');

% gradf plots
% mesh plot
close all;
figure1 = figure('visible','off');
axes1 = axes('Parent',figure1);
mesh(X, Y, Gnorm);
view(axes1,[-134.5 36]);
ylabel('y', 'interpreter','latex');
xlabel('x', 'interpreter','latex');
title('$\parallel \nabla f \parallel$','interpreter','latex');
save_plot(figure1, '005gradf_mesh_plot');

% quiver plot with contour
hold off;
quiver(X, Y, U, V);
hold on;
contour(X, Y, Z, 25);
ylabel('y', 'interpreter','latex');
xlabel('x', 'interpreter','latex');
title('quiver $\parallel \nabla f \parallel$ with contour f', 'interpreter', 'latex');
save_plot(figure1, '006gradf_quiver_f_contour_plot');

cd ..
clf;
close all;

%%  ----------------------- Algorithm plots ------------------------------------

mkdir algorithm_plots
cd algorithm_plots

%%  ----------------------- Steepest descent -----------------------------------

% constant step
to_plot = @(gamma) generic_algorithm(@steepest_d_rule, @const_gamma_rule, ...
    'e', 1e-8, 'start_x', [-2; -1], 'gamma', gamma);

x1 = 1e-7:0.01:1;
x2 = 0.1:0.01:0.7;

parfor i = 1:length(x1)
    res1(i) = to_plot(x1(i));
end

parfor i = 1:length(x2)
    res2(i) = to_plot(x2(i));
end

fig = figure('visible','off');

plot(x1, res1);
ylabel('Number of iterations');
xlabel('γ');
title('Number of iterations for each gamma');
save_plot(fig, '100steepest_descent_const_gammaiii');

plot(x2, res2);
ylabel('Number of iterations');
xlabel('γ');
title('Number of iterations for each gamma');
save_plot(fig, '101steepest_descent_const_gamma_smalliii');

gamma_min = fminsearch(to_plot, 0.5);
display(gamma_min)

% plot process graph for -2,-1

figure('visible','off');
[~, x, ~] = generic_algorithm(@steepest_d_rule, @const_gamma_rule, ...
    'e', 1e-8, 'start_x', [-2; -1], 'gamma', gamma_min);

str = 'Steps of steepest descent for γ = %g';
str = sprintf(str, gamma_min);
process_plot(x, X, Y, Z, str)
print('doc_1020steepest_descent_const_gamma_process_iii_gamma_min', '-dpng', '-r300');

hold off;
str = 'f values with steepest descent for γ = %g';
str = sprintf(str, gamma_min);
value_process_plot(x, str);
print('doc_1021steepest_descent_const_gamma_value_plot_iii_gamma_min', '-dpng', '-r300');

% plot process graphs for -3,3

fig = figure('visible','off');
[~, x, ~] = generic_algorithm(@steepest_d_rule, @const_gamma_rule, ...
    'e', 1e-8, 'start_x', [-3; 3], 'gamma', 0.3);
subplot(3,1,1);
str = 'Steps of steepest descent for γ = %g';
str = sprintf(str, 0.3);
process_plot(x, X, Y, Z, str)

[~, x, ~] = generic_algorithm(@steepest_d_rule, @const_gamma_rule, ...
    'e', 1e-8, 'start_x', [-3; 3], 'gamma', 1e4);
subplot(3,1,2);
str = 'Steps of steepest descent for γ = %d';
str = sprintf(str, 1e4);
process_plot(x, X, Y, Z, str)

[~, x, ~] = generic_algorithm(@steepest_d_rule, @const_gamma_rule, ...
    'e', 1e-8, 'start_x', [-3; 3], 'gamma', 1e8);
subplot(3,1,3);
str = 'Steps of steepest descent for γ = %d';
str = sprintf(str, 1e8);
process_plot(x, X, Y, Z, str)
save_plot(fig, '1030steepest_descent_const_gamma_iv');

figure('visible','off')
str = 'f values with steepest descent for γ = %d';
str = sprintf(str, 1e8);
value_process_plot(x, str);
print('1031steepest_descent_const_gamma_value_plot_iv', '-dpng', '-r300');


% fmin step
clf;
close all;
fig = figure('visible','off');

profile on;
[~, x, ~] = generic_algorithm(@steepest_d_rule, @fmin_rule, 'e', 1e-8, 'start_x', [-2; -1]);
assert(all(abs(x(:,end) - [-1/2;-1/2]) <= 1e-8))
stats = profile('info');
profile off;
idx = arrayfun(@(x)all(x.FunctionName=='f'),stats.FunctionTable);
fcalls = stats.FunctionTable(idx).NumCalls;
fprintf('steepest: -2,-1 fmin: %d fcalls, %d steps\n', fcalls, length(x));

subplot(2,1,1);
process_plot(x, X, Y, Z, 'Steps of steepest descent for optimized γ')

profile on;
[~, x, ~] = generic_algorithm(@steepest_d_rule, @fmin_rule, 'e', 1e-8, 'start_x', [-3; 3]);
assert(all(abs(x(:,end) - [-1/2;-1/2]) <= 1e-8))
stats = profile('info');
profile off;
idx = arrayfun(@(x)all(x.FunctionName=='f'),stats.FunctionTable);
fcalls = stats.FunctionTable(idx).NumCalls;
fprintf('steepest: -3,3 fmin: %d fcalls, %d steps\n', fcalls, length(x));

subplot(2,1,2);
process_plot(x, X, Y, Z, 'Steps of steepest descent for optimized γ')
print('doc_104steepest_descent_fmin_gamma', '-dpng', '-r300');

% heuristic step

clf;
close all;
fig = figure('visible','off');

profile on;
[k, x, ~] = generic_algorithm(@steepest_d_rule, @heuristic_gamma_rule, 'e', 1e-8, 'start_x', [-2; -1]);
assert(all(abs(x(:,end) - [-1/2;-1/2]) <= 1e-8))
stats = profile('info');
profile off;
idx = arrayfun(@(x)all(x.FunctionName=='f'),stats.FunctionTable);
fcalls = stats.FunctionTable(idx).NumCalls;
fprintf('steepest: -2,-1 heuristic: %d fcalls, %d steps\n', fcalls, k);

subplot(3,1,1);
process_plot(x, X, Y, Z, 'Steps of steepest descent for heuristic γ')

profile on;
[k, x, ~] = generic_algorithm(@steepest_d_rule, @heuristic_gamma_rule, 'e', 1e-8, 'start_x', [-3; 3]);
assert(all(abs(x(:,end) - [-1/2;-1/2]) <= 1e-8))
stats = profile('info');
profile off;
idx = arrayfun(@(x)all(x.FunctionName=='f'),stats.FunctionTable);
fcalls = stats.FunctionTable(idx).NumCalls;
fprintf('steepest: -3,3 heuristic: %d fcalls, %d steps\n', fcalls, k);

subplot(3,1,2);
process_plot(x, X, Y, Z, 'Steps of steepest descent for heuristic γ')

profile on;
[k, x, ~] = generic_algorithm(@steepest_d_rule, @heuristic_gamma_rule, 'e', 1e-8, 'start_x', [-3; 3], 'gamma', 1e7);
assert(all(abs(x(:,end) - [-1/2;-1/2]) <= 1e-8))
stats = profile('info');
profile off;
idx = find(arrayfun(@(x)all(x.FunctionName=='f'),stats.FunctionTable));
fcalls = stats.FunctionTable(idx).NumCalls;
fprintf('steepest: -3,3 heuristic: %d fcalls, %d steps\n', fcalls, k);

subplot(3,1,3);
process_plot(x, X, Y, Z, 'Steps of steepest descent for heuristic γ with starting γ = 1e7')
save_plot(fig, 'doc_105steepest_descent_heuristic_gamma');


%%  ----------------------- Newton ---------------------------------------------

fig = figure('visible','off');

[~, x, ~] = generic_algorithm(@newton_d_rule, @const_gamma_rule, 'e', 1e-8, 'start_x', [-2; -1], 'use_hessian', true, 'gamma', 0.5);
subplot(3,1,1);
process_plot(x, X, Y, Z, 'Steps of Newton method for γ = 0.5, e = 1e-8');

[~, x, ~] = generic_algorithm(@newton_d_rule, @const_gamma_rule, 'e', 1e-30, 'start_x', [-2; -1], 'use_hessian', true, 'gamma', 0.5);
subplot(3,1,2);
process_plot(x, X, Y, Z, 'Steps of Newton method for γ = 0.5, e = 1e-30');

[~, x, ~] = generic_algorithm(@newton_d_rule, @fmin_rule, 'e', 1e-8, 'start_x', [-2; -1], 'use_hessian', true);
subplot(3,1,3);
process_plot(x, X, Y, Z, 'Steps of Newton method for optimized γ');

save_plot(fig, '201newton');

%%  ----------------------- Levengerg-Marquardt --------------------------------


%%  ----------------------- Finish ---------------------------------------------
cd ..

clf;
close all;
% cd ..