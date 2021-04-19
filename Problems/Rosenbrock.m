function obj = Rosenbrock(var)
%ROSENBROCK function
%   - var: design variable vector
%--------------------------------------------------------------------------
    [~,dim] = size(var);
    temp1 = var-1;
    obj = sum(100*(var(:,2:dim)-var(:,1:dim-1).^2).^2+temp1(:,1:dim-1).^2,2);
end