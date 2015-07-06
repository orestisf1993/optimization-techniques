close all;

%% adapted plot

% fig = figure;
for nGaussian = 1:15
    fig = figure('visible', 'off');
    % adapted function
    x = res{nGaussian};
    adapted = @(u1, u2) gaussianSum(x, nGaussian, u1, u2);
    Z = adapted(p,q);
%     subplot(3, 5, nGaussian);
    mesh(p,q,Z); hold on;
    zlim([-1 1]);
    xlabel('u_1');
    ylabel('u_2');
    str = sprintf('nGaussian=%d', nGaussian);
    title(str);
%     plot3(u1,u2,adapted(u1,u2),'r*'); % plot points used for evaluation
    hold off;
    set(fig, 'PaperPositionMode', 'auto')
    str = sprintf('adapted_%d', nGaussian);
    print(fig, str, '-depsc');
end
% print(fig, 'adapted_all', '-depsc');


%% f plot
fig = figure('visible','off');
Z = f(p,q);
mesh(p,q,Z); hold on;
zlim([-1 1]);
xlabel('$u_1$', 'interpreter','latex');
ylabel('$u_2$', 'interpreter','latex');
title('$sin(u_1 + u_2)sin(u_1^2)$', 'interpreter','latex');
% save without points
print(fig, 'f', '-depsc', '-r1200');
plot3(u1,u2,f(u1,u2),'r*'); % plot points used for evaluation
% save with points
% print(fig, 'f_with_points', '-depsc', '-r1200');
hold off;

%% error plot
% fig = figure;
for nGaussian = 1:15
    fig = figure('visible', 'off');
    % adapted function
    x = res{nGaussian};
    adapted = @(u1, u2) gaussianSum(x, nGaussian, u1, u2);
    adapted_error = @(u1, u2) (f(u1, u2) - adapted(u1, u2));
    Z = adapted_error(p,q);
%     subplot(3, 5, nGaussian);
    mesh(p,q,Z); hold on;
    zlim([-1 1]);
    xlabel('u_1');
    ylabel('u_2');
    str = sprintf('nGaussian=%d', nGaussian);
    title(str);
%     plot3(u1,u2,adapted(u1,u2),'r*'); % plot points used for evaluation
    hold off;
    set(fig, 'PaperPositionMode', 'auto')
    str = sprintf('adapted_error_%d', nGaussian);
    print(fig, str, '-depsc');
end
% print(fig, 'adapted_all', '-depsc');