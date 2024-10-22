function [core, factors] = hooi(X, ranks, max_iter, tol)
    arguments
        X;
        ranks = multilinear_rank(X);
        max_iter = 10;
        tol = 1e-3;
    end

    nmodes = length(size(X));
    [core, factors] = hosvd(X, ranks);

    if nargin == 1
        fprintf("Multilinear ranks not specified, computing HOSVD...\n")
        [core, factors] = hosvd(X, ranks);
        return
    end

    for iter = 1:max_iter
        for mode = 1:nmodes 
            % Calculate mode product for other modes
            for inner_mode = 1:nmodes
                
                Y = X;
                if inner_mode == mode
                    continue
                end

                Y = tensor_matrix_product(Y, factors{inner_mode}', inner_mode);
            end

            Ymode = matricization(Y, mode);
            [U, ~, ~] = svd(Ymode);
            factors{mode} = U(:, 1:ranks(mode));
        end
        
        core = X;

        for inner_mode = 1:nmodes
            core = tensor_matrix_product(core, factors{inner_mode}', inner_mode);
        end
        
        % Reshape core to a tensor
        core = reshape(core, ranks);

        X_approx = core;

        for inner_mode = 1:nmodes
            disp(X_approx)
            X_approx = tensor_matrix_product(X_approx, factors{inner_mode}, inner_mode);
        end    

        error = tensor_difference(X, X_approx);
        disp(error)

        if error < tol
            fprintf("Converged after %d iterations.\n", iter)
            break
        end
    end


    if (iter == max_iter)
        fprintf("Maximum %d iterations reached without convergence.\n", iter)
    end

    fprintf("Final error %e.\n", tensor_difference(X, Y))
    
end