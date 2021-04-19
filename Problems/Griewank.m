function obj = Griewank( var,M,opt )
%GRIEWANK function
%   - var: design variable vector
%   - M: rotation matrix
%   - opt: shift vector
%--------------------------------------------------------------------------
    dim = length(M);
    var = var(:,1:dim);
    [NN,dim] = size(var);
    opt=repmat(opt,NN,1);
    var = (M*(var-opt)')';
    i=repmat(1:dim,NN,1);
    obj = 1+1/4000*sum(var.^2,2)-prod(cos(var./(sqrt(i))),2);
end

