%% initialization
% u1 and u2 values in a meshgrid but are vectors
[p,q] = meshgrid(linspace(-2,2,35), linspace(-2,2,35));
pairs = [p(:) q(:)];
u1 = pairs(:,1)';
u2 = pairs(:,2)';

clear res;
clear costs;
% ga() options
options = gaoptimset('UseParallel', false, 'Vectorized', 'on', 'FitnessLimit', 1, 'TolFun', 1e-5);

% specify upper/lower bounds for x variables.
for nGaussian = 1:15
    clear LBt UBt;
    % unconstrained a_i
    LBt(1:nGaussian) = -Inf;
    UBt(1:nGaussian) = Inf;
    % positive sigma, upper bound related to our interest area
    LBt(nGaussian + 1:nGaussian*3) = 0;
    UBt(nGaussian + 1:nGaussian*3) = 2*sqrt(2);
    % bell centre inside interest area
    LBt(nGaussian*3 + 1:nGaussian*5) = -2;
    UBt(nGaussian*3 + 1:nGaussian*5) = 2;
    LB{nGaussian} = LBt;
    UB{nGaussian} = UBt;
end

%% initial run for all numbers of Gaussians
% parallel for. Replace 'parfor' with 'for' if errors occur.
parfor nGaussian = 1:15
    % call ga()
    x = ga(@(x) error_sum(x, nGaussian, u1, u2), 5*nGaussian, [], [], [], [], LB{nGaussian}, UB{nGaussian}, [], options);
    res{nGaussian} = x;
    costs(nGaussian) = error_sum(x,nGaussian,u1,u2);
end
display(costs)

%% recursive optimization
% select nGaussian that corresponds to the lowest cost.
nGaussian = find(min(costs)==costs);
x = res{nGaussian};
error_value = Inf;
while error_value > 1
    tic
    options = gaoptimset('UseParallel', false, 'Vectorized', 'on', 'FitnessLimit', 1, 'TolFun', 1e-5,   'InitialPopulation',x);
    x = ga(@(x) error_sum(x, nGaussian, u1, u2), 5*nGaussian, [], [], [], [], LB{nGaussian}, UB{nGaussian}, [], options);
    error_value = error_sum(x,nGaussian,u1,u2);
    display(error_value);
    toc
end