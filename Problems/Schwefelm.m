function obj = Schwefelm(var,MM,opt)
%SCHWEFEL function
%   - var: design variable vector
%   - MM: rotation matrix
%   - opt: shift vector
%--------------------------------------------------------------------------
    dim = length(MM);
    var = var(:,1:dim);
    [NN,~] = size(var);
%     opt=0*ones(NN,dim);
    opt=repmat(opt,NN,1);
    var = (MM*(var-opt)')';
    
    [~,dim] = size(var);
    obj = 418.9829*dim-sum(var.*sin(sqrt(abs(var))),2);
    
end

