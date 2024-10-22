function [lambda, factors, converged] = cp_asl(X, r, epsilon, max_iter)
    % CP_ASL Computes a rank-r CP approximation of a tensor X.
    % Output:
    % - lambda: normalizing vector
    % - factors: factor matrices
    % - converged (0 or 1): specifies if the procedure converges before reaching max_iter

    arguments
        X;                % The tensor
        r;                % Rank of the decomposition
        epsilon = 1e-10;   % Convergence tolerance
        max_iter = 5000;  % Maximum number of iterations
    end

    converged = 1;

    % Get the dimensions of the tensor
    dims = size(X);
    n = ndims(X); % Number of modes

    % Initialize lambda and factor matrices
    lambda = ones(r, 1);
    factors = cell(1, n); % Cell array to store factor matrices

    % Randomly initialize the factor matrices
    for i = 1:n
        factors{i} = rand(dims(i), r);
    end

    fprintf('Approximating by rank-%d tensor...\n', r);

    % Iterate until convergence or reaching the maximum number of iterations
    for iter = 1:max_iter
        for mode = 1:n
            % Get all factor, except for current mode
            current_factors = factors([1:mode-1, mode+1:n]);
            reversed_factors = flip(current_factors);
            
            gramians = cellfun(@(mat) mat' * mat, current_factors, 'UniformOutput', false);
            V = hadamard(gramians{:});

            factors{mode} = matricization(X, mode)*katri_rao(reversed_factors{:})/V;

            % Normalize the factor matrix and adjust lambda
            lambda = sqrt(sum(factors{mode}.^2, 1))';
            factors{mode} = factors{mode} ./ lambda';
        end

        % Check for convergence
        diff = sum((X - tensor_from_cp(lambda, factors{:})).^2, 'all');
        % fprintf('Iteration %d: Norm of difference = %e\n', iter, diff);

        if diff < epsilon
            fprintf('Converged after %d iterations.\n', iter);
            break;
        end
    end
    
    if iter == max_iter
        fprintf('Reached maximum %d iterations.\n', max_iter);
        converged = 0;
    end


    fprintf('Final error %e.\n', diff);
    fprintf("------------------------------------------------------------------\n")
end
