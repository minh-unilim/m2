function X = tensor_from_matrix(A, mode, dims)
    % Rearrange the dimensions so that the specified mode becomes the first mode
    perm = [mode, 1:mode-1, mode+1:numel(dims)];
    
    % Reshape the matrix back into the permuted dimensions
    reshaped_dims = [dims(mode), dims(perm(2:end))];
    X = reshape(A, reshaped_dims);
    
    % Inverse permute the dimensions to get back to the original order
    X = ipermute(X, perm);
end
