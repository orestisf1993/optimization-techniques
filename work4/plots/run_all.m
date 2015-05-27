% Script that runs all the plots and code needed for the work4 report
%%  ----------------------- Initialization -------------------------------------

close all;
clear all;

%%  ----------------------- Calculate needed values ----------------------------

% calculate needed values for plots
[X,Y] = meshgrid(-2:.2:2, -2:.2:2);
Z = f(X, Y);
Gnorm = normgrad(X, Y);
minx = 0;
miny = 0;

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
% print('000f_mesh_plot', '-dpng', '-r300');
matlab2tikz('000f_mesh_plot.tikz', 'showInfo', false, 'checkForUpdates', false, 'height', '\figureheight', 'width', '\figurewidth');


% surf plot
hold off;
surf(X, Y, Z);
hold on;
ylabel('y');
xlabel('x');
title('f surf plot');
colorbar;
% print('001f_surf_plot', '-dpng', '-r300');
matlab2tikz('001f_surf_plot.tikz', 'showInfo', false, 'checkForUpdates', false, 'height', '\figureheight', 'width', '\figurewidth');


% contour plots
hold off;
contour(X, Y, Z, 11, 'ShowText','on');
ylabel('y');
xlabel('x');
title('f contour plot');
% print('002f_contour_plot_showtext', '-dpng', '-r300');
matlab2tikz('002f_contour_plot_showtext.tikz', 'showInfo', false, 'checkForUpdates', false, 'height', '\figureheight', 'width', '\figurewidth');


contourf(X, Y, Z);
hold on;
ylabel('y');
xlabel('x');
title('f contour plot');
colorbar;
% print('003f_contour_plot_fill', '-dpng', '-r300');
matlab2tikz('003f_contour_plot_fill.tikz', 'showInfo', false, 'checkForUpdates', false, 'height', '\figureheight', 'width', '\figurewidth');

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
cleanfigure;
% print('005gradf_mesh_plot', '-dpng', '-r300');
matlab2tikz('005gradf_mesh_plot.tikz', 'showInfo', false, 'checkForUpdates', false, 'height', '\figureheight', 'width', '\figurewidth');


% quiver plot with contour
hold off;
quiver(X, Y, X, Y);
hold on;
contour(X, Y, Z, 25);
ylabel('y', 'interpreter','latex');
xlabel('x', 'interpreter','latex');
title('quiver $\parallel \nabla f \parallel$ with contour f', 'interpreter', 'latex');
% print('006gradf_quiver_f_contour_plot', '-dpng', '-r300');
matlab2tikz('006gradf_quiver_f_contour_plot.tikz', 'showInfo', false, 'checkForUpdates', false, 'height', '\figureheight', 'width', '\figurewidth');


cd ..
clf;
close all;

%%  ----------------------- Algorithms plots -----------------------------------
mkdir algorithms
cd algorithms

%%  ----------------------- Steepest descent run -------------------------------

% for starting point [-5, -5] run with gamma [0.1, 1, 2, 10], e = 0.01

gamma = [0.1, 1, 2, 10];
fig = figure('visible', 'off');

for i = 1:4
    subplot(2, 2, i)
    [k, x] = generic_algorithm(@steepest_d_rule, @const_gamma_rule, ...
        'e', 1e-2, 'gamma', gamma(i), 'start_x', [-5; 5]);
    fprintf('gamma = %g, %d steps, (%g, %g) ending point\n', gamma(i), k, x(1,end), x(2,end));
    
    str = 'γ = %g';
    str = sprintf(str, gamma(i));
    process_plot(x, str);
    xlim([min(min(x(1,:)), min(x(2,:))) + 0.01 max(max(x(1,:)), max(x(2,:))) + 0.01]);
end
cleanfigure;
matlab2tikz('stepeest_plots.tikz', 'showInfo', false, 'checkForUpdates', false, 'height', '\figureheight', 'width', '\figurewidth');

%%  ----------------------- Steepest descent projection run --------------------

fig = figure('visible', 'off');
x = projection_algorithm('start_x', [8; 3], 's', 15, 'gamma', 0.1, 'e', 0.01);
process_plot(x);
print('plot_b', '-depsc', '-r1200');
% matlab2tikz('plot_b.tikz', 'showInfo', false, 'checkForUpdates', false, 'height', '\figureheight', 'width', '\figurewidth');
fig = figure('visible', 'off');
[x, xb, ~] = projection_algorithm('start_x', [-5; 7], 's', 20, 'gamma', 0.3, 'e', 0.02, 'max_k', 100);
process_plot(x);
print('plot_c', '-depsc', '-r1200');
process_plot(xb);
print('plot_c_bar', '-depsc', '-r1200');
fig = figure('visible', 'off');
x = projection_algorithm('start_x', [11; 3], 's', 0.1, 'gamma', 0.01, 'e', 0.01);
process_plot(x);
print('plot_d', '-depsc', '-r1200');
