function X = tensor_from_matrix(A, mode, dims)
    % Rearrange the dimensions so that the specified mode becomes the first mode
    perm = [mode, 1:mode-1, mode+1:numel(dims)];
    
    % Reshape the matrix back into the permuted dimensions
    reshaped_dims = [dims(mode), dims(perm(2:end))];
    reshaped_array = reshape(A, reshaped_dims);
    
    % Inverse permute the dimensions to get back to the original order
    reshaped_array = ipermute(reshaped_array, perm);
    
    % Flatten the array
    flattened_array = reshaped_array(:);
    
    % Create an instance of the Tensor class and return it
    X = Tensor(flattened_array', dims);
end
