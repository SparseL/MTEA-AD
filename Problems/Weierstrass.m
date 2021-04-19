function obj = Weierstrass(var,MM,opt)
%WEIERSTASS function
%   - var: design variable vector
%   - MM: rotation matrix
%   - opt: shift vector
%--------------------------------------------------------------------------
    kkmax = 20;
    dim = length(MM);
    var = var(:,1:dim);
    [NN,dim] = size(var);
%     opt=0*ones(NN,dim);
    opt=repmat(opt,NN,1);
    var = (MM*(var-opt)')'; 
    kmax = repmat(1:kkmax,[NN,1]);
    a = 0.5*ones(NN,kkmax);
    b = 3*ones(NN,kkmax);
    obj = 0;
    for i =1:dim
        obj = obj + sum((a.^kmax).*cos(2*pi*(b.^kmax).*(repmat(var(:,i),[1,kkmax])+0.5)),2);
    end
    obj = obj - sum(dim*(a.^kmax).*cos(2*pi*(b.^kmax)*0.5),2);
end