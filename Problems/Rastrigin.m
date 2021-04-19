function obj = Rastrigin(var,MM,opt)
%Rastrigin function
%   - var: design variable vector
%   - MM: rotation matrix
%   - opt: shift vector
%--------------------------------------------------------------------------
    dim = length(MM);
    var = var(:,1:dim);
    [NN,dim] = size(var);
%     opt=0*ones(NN,dim);
    opt=repmat(opt,NN,1);
    var = (MM*(var-opt)')'; 
    obj = 10*dim + sum(var.^2-10*cos(2*pi*var),2);
end