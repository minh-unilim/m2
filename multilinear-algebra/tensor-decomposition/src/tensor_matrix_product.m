function Y = tensor_matrix_product(X, A, n)
    % X: input tensor
    % A: matrix for mode-n multiplication
    % n: mode along which to multiply (1-indexed)

    % Get the dimensions of X
    dims = size(X);
    
    % Permute the tensor to bring the n-th mode to the front
    order = [n, 1:n-1, n+1:length(dims)];
    X_permuted = permute(X, order);
    
    % Reshape the permuted tensor into a matrix for multiplication
    X_mat = reshape(X_permuted, dims(n), []);
    
    % Perform the matrix multiplication
    Y_mat = A * X_mat;
    
    % Calculate the new dimensions after multiplication
    new_dims = [size(A, 1), dims(1:n-1), dims(n+1:end)];
    
    % Reshape and permute the result back to the original order
    Y = ipermute(reshape(Y_mat, new_dims), order);
end
