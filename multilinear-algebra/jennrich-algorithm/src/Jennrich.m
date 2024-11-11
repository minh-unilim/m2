classdef Jennrich
    methods (Static)
        function [lambda, factors] = decompose(T)
            Ma = Jennrich.composed_matrix(T);
            Mb = Jennrich.composed_matrix(T);

            [U, ~] = eig(Ma/Mb);
            [V, ~] = eig(Ma'/Mb');

            






        end

        function M = composed_matrix(T)
            dims = size(T);

            if length(dims) ~= 3
                fprintf("Tensor must have order %d", 3);
            end

            v = Jennrich.random_unit_vector(dims(3));
            M = zeros(dims(1), dims(2));

            for i = 1:dims(3)
                M = M + T(:, :, i)*v(i);
            end
        end

        function v = random_unit_vector(dim)
            v = randn(dim, 1); 
            v = v / norm(v);
        end
    end
end