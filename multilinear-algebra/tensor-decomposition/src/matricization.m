function Y = matricization(X, mode)
    % Get the size of the tensor
    sizeX = size(X);
    
    % Check if the mode is valid
    if mode < 1 || mode > ndims(X)
        error('Invalid mode. Mode must be between 1 and %d.', ndims(X));
    end
    
    % Rearrange the tensor
    % Rearranging the tensor based on the specified mode
    % Permute the tensor such that the specified mode becomes the first dimension
    % Then reshape the tensor into a matrix
    perm = [mode, setdiff(1:ndims(X), mode)];
    Y = reshape(permute(X, perm), sizeX(mode), []);
end
