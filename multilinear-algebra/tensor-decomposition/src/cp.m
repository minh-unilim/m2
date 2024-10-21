function [lambda, factors] = cp(X, epsilon, max_iter)
    % CP Decomposition of a tensor X
    % Returns lambda (a vector of weights) and factors (cell array of factor matrices)
    arguments
        X;                % The tensor
        epsilon = 1e-10;   % Convergence tolerance
        max_iter = 5000;  % Maximum number of iterations
    end
    
    dims = size(X);
    fprintf("Tensor of dimensions: ");
    disp(dims);

    [i, j] = ndgrid(1:length(dims), 1:length(dims));
    % Create a mask for i not equal to j
    mask = i ~= j;
    % Apply the mask using arrayfun
    mutual_products = arrayfun(@(x, y) dims(x) * dims(y), i(mask), j(mask));

    max_rank = min(mutual_products(:));

    fprintf("Max possible rank: %d", max_rank)

    for r=1:max_rank
        [lambda, factors, converged] = cp_asl(X, r);
        if converged == 1
            break
        end
    end
end
