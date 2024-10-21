function idx = multiindex(sizes)
    % Generate all multi-indices for the given sizes
    n = numel(sizes);
    [idx{1:n}] = ndgrid(arrayfun(@(x) 1:x, sizes, 'UniformOutput', false));
    idx = cellfun(@(x) x(:), idx, 'UniformOutput', false); % Convert to column vectors
    idx = [idx{:}]; % Concatenate indices into a single array of multi-indices
end