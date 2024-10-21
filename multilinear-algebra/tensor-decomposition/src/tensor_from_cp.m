function X = tensor_from_cp(lambda, varargin)
    % Rebuild the tensor from the CP decomposition
    % lambda: the vector of weights for each component
    % varargin: the factor matrices

    % Initialize the reconstructed tensor to zeros with appropriate dimensions
    dims = cellfun(@(x) size(x, 1), varargin); % Get the dimensions of the tensor
    X = zeros(dims);  % Initialize tensor with correct dimensions
    
    % Iterate through the rank
    for r_idx = 1:length(lambda)
        % Initialize a cell to hold the r_idx column of each matrix
        columns = cellfun(@(M) M(:, r_idx), varargin, 'UniformOutput', false);
        
        % Concatenate these columns to form the outer product
        X = X + lambda(r_idx) * outer_product(columns{:});
    end
end
