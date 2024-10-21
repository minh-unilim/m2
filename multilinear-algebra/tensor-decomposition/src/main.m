X = cat(3, [1, 2; 3, 4], [5, 6; 7, 8]);

%%
cp(X)

%%
[lambda, factors] = cp_asl(X, 2);

%%
Y = tensor_from_cp(lambda, factors{:});