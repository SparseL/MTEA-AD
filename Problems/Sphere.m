function obj = Sphere(var,opt)
%Sphere function
%   - var: design variable vector
%   - opt: shift vector
%--------------------------------------------------------------------------
    [NN,~] = size(var);
    opt=repmat(opt,NN,1);
    var = (var - opt);
    obj=sum(var.^2,2);
end