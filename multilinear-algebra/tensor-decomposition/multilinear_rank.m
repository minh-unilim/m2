function ranks = multilinear_rank(X)
    nmode = length(size(X));

    ranks = zeros(1, nmode);

    for mode = 1:nmode
        ranks(mode) = rank(matricization(X, mode));
    end
end


