function [core, factors] = hosvd(X, ranks)
    % HOSVD Computes higher-order SVD of a tensor X, with respect to
    % multilinear ranks

    arguments
        X;
        ranks = multilinear_rank(X);
    end

    dims = size(X);
    nmodes = length(dims);

    if nargin == 1
        fprintf("Multilinear ranks not specified, computing max ones...\n")
    else
        if length(ranks) ~= nmodes
            error("Expected %d ranks, got %d\n", nmodes, length(ranks))
        end
    end

    disp(ranks)

    factors = cell(1, nmodes);
    max_ranks = multilinear_rank(X);

    for mode = 1:nmodes
        if ranks(mode) > max_ranks(mode)
            error("Mode %d has max rank %d, got %d", mode, max_ranks(mode), ranks(mode))   
        end
        [U, ~, ~] = svd(matricization(X, mode));
        factors{mode} = U(:, 1:ranks(mode));
    end

    core = X;

    for mode=1:nmodes
        core = tensor_matrix_product(core, factors{mode}', mode);
    end

    core = reshape(core, ranks);

end