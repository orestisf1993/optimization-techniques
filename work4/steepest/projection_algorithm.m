function [x, xbar, selected] = projection_algorithm(varargin)
%projection_algorithm 

% default values
p = inputParser;
default_e = 0.01;
default_x = [0; 0];
default_gamma = 1;
default_max_k = 1e4;
default_s = 1;
default_a = [-20; -12];
default_b = [10; 15];

% data type checking functions
is_point = @(x) (isnumeric(x) && all(size(x) == [2 1]) && all(isfinite(x)));
is_positive_number = @(x) (isnumeric(x) && all(x > 0) && isscalar(x) && all(isfinite(x)));

% parameters to the parser
addParameter(p,'gamma', default_gamma, is_positive_number);
addParameter(p,'e', default_e, is_positive_number);
addParameter(p,'s', default_s, is_positive_number);
addParameter(p, 'max_k', default_max_k, is_positive_number);
addParameter(p,'start_x', default_x, is_point);
addParameter(p,'a', default_a, is_point);
addParameter(p,'b', default_b, is_point);
addParameter(p, 'norm_terminate', false, @islogical);

% parse inputs and evaluate values. Initialize variables
parse(p, varargin{:});
e = p.Results.e;
s = p.Results.s;
gamma = p.Results.gamma;
x = p.Results.start_x;
a = p.Results.a;
b = p.Results.b;
max_k = p.Results.max_k;
norm_terminate = p.Results.norm_terminate;

k = 1;

% main loop
while true
    g = gradf(x(1, k) ,x(2, k));
    
    % terminate by comparing the norm(gradf) with e.
    if norm_terminate
        if norm(g) < e
            return
        end
    end
    
    % the point that will be projected
    selected(:, k) = x(:, k) - s * g;
    % calculating xbar
    xbar(:, k) = ...
        a .* (selected(:,k) <= a) + ...  % smaller than low bound
        b .* (selected(:, k) >= b) + ... % greater than uper bound
        selected(:, k) .* (a < selected(:, k) ) .* (selected(:, k) < b); % inside bounds
    d = (xbar(:, k) - x(:, k));
    % calculating the next point
    x(:, k + 1) = x(:, k) + gamma * d;
    
    % terminate by comparing the norm of x_{k+1} - xbar_k with e
    if ~norm_terminate
        if norm(x(:, k+1) - xbar(:, k)) < e
            return
        end
    end    
    
    k = k + 1;
    if (k > max_k) 
        break; 
    end
end
end