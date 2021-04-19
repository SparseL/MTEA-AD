function obj = Spherem(var,MM,opt)
%Sphere function
%   - var: design variable vector
%   - MM: rotation matrix
%   - opt: shift vector
%--------------------------------------------------------------------------
    dim = length(MM);
    var = var(:,1:dim);
    [NN,~] = size(var);
    opt=repmat(opt,NN,1);
    var = (MM*(var-opt)')';
    obj=sum(var.^2,2);
end