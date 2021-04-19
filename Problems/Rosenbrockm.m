function obj = Rosenbrockm(var,MM,opt)
%ROSENBROCK function
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
    temp1 = var-1;
    obj = sum(100*(var(:,2:dim)-var(:,1:dim-1).^2).^2+temp1(:,1:dim-1).^2,2);
end