function obj = Schwefel(var)
%SCHWEFEL function
%   - var: design variable vector
%--------------------------------------------------------------------------
    [~,dim] = size(var);
    obj = 418.9829*dim-sum(var.*sin(sqrt(abs(var))),2);
    
end

