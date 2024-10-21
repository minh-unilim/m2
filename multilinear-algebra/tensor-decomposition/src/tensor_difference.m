function diff = tensor_difference(A, B)
    if size(A) ~= size(B)
        error('Two tensors must be of the same size');
    end 

    diff = sum((A-B).^2, 'all');
end