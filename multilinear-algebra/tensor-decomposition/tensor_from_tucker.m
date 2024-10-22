function X = tensor_from_tucker(G, varargin)
    X = G;

    for i = 1:length(varargin)
         X = X.times(varargin{i}, i);
    end
end