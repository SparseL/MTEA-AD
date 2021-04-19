function obj = Ackley(var,MM,opt)
%Ackley function
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
    obj = 20 + exp(1) - 20*exp(-0.2*sqrt((1/dim)*sum(var.^2,2))) - exp((1/dim)*sum(cos(2*pi*var),2));
end

