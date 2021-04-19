%------------------------------- Reference --------------------------------
% B. S. Da, Y. S. Ong, L. Feng, A. K. Qin, A. Gupta, Z. Zhu, C. Ting, K.
% Tang, and X. Yao, “Evolutionary multitasking for single-objective
% continuous optimization: Benchmark problems, performance metric, and
% baseline results,” CoRR, vol. abs/1706.03470, 2017. [Online]. Available:
% http://arxiv.org/abs/1706.03470.
% 
% Y. Chen, J. Zhong, L. Feng, and J. Zhang, "An adaptive archive-based
% evolutionary framework for many-task optimization," IEEE Trans. Emerg.
% Topics Comput. Intell., vol. 4, no. 3, pp. 369-384, Jun. 2020.
%
%------------------------------- Copyright --------------------------------
% Copyright (c) 2021-2022 Jing Group. You are free to use the MTEA-AD for 
% research purposes. All publications which use this code should acknowledge
% the use of "EMEA-AD" and reference C. Wang, J. Liu, K. Wu and Z. Wu, 
% "Solving multi-task optimization problems with adaptive knowledge 
% transfer via anomaly detection," in IEEE Transactions on Evolutionary 
% Computation, doi: 10.1109/TEVC.2021.3068157.
%
% If you have any questions, please contact this Email:xiaofengxd@126.com
%--------------------------------------------------------------------------
classdef TASK    
    %This class contains all task information and needs to be initialized
    %by initTASK.
    properties
        M;                                  % Number of tasks
        Tdims;                              % Dimension of tasks
        D_multitask;                        % Unified search space
        Lb;                                 % Task lower bounds
        Ub;                                 % Task upper bounds
        fun;                                % TASK functions
    end    
    methods        
        function object = initTASK(object,name)
            switch name
                case 1 % complete intersection with high similarity, Griewank and Rastrigin
                    load('Tasks\CI_H.mat')  % loading data from folder .\Tasks
                    object.M = 2;
                    object.Tdims = zeros(object.M,1);
                    object.Tdims(1) = 50;
                    object.Tdims(2) = 50;
                    object.D_multitask = max(object.Tdims);
                    object.Lb = ones(object.M,object.D_multitask);
                    object.Ub = ones(object.M,object.D_multitask);
                    object.Lb(1,:) = -100*object.Lb(1,:);
                    object.Lb(2,:) = -50*object.Lb(2,:);
                    object.Ub(1,:) = 100*object.Ub(1,:);
                    object.Ub(2,:) = 50*object.Ub(2,:);
                    object.fun(1).fnc=@(x)Griewank(x,Rotation_Task1,GO_Task1);
                    object.fun(2).fnc=@(x)Rastrigin(x,Rotation_Task2,GO_Task2);
                    
                case 2 % complete intersection with medium similarity, Ackley and Rastrigin
                    load('Tasks\CI_M.mat')
                    object.M = 2;
                    object.Tdims = zeros(object.M,1);
                    object.Tdims(1) = 50;
                    object.Tdims(2) = 50;
                    object.D_multitask = max(object.Tdims);
                    object.Lb = ones(object.M,object.D_multitask);
                    object.Ub = ones(object.M,object.D_multitask);
                    object.Lb(1,:) = -50*object.Lb(1,:);
                    object.Lb(2,:) = -50*object.Lb(2,:);
                    object.Ub(1,:) = 50*object.Ub(1,:);
                    object.Ub(2,:) = 50*object.Ub(2,:);
                    object.fun(1).fnc=@(x)Ackley(x,Rotation_Task1,GO_Task1);
                    object.fun(2).fnc=@(x)Rastrigin(x,Rotation_Task2,GO_Task2);
                    
                case 3 % complete intersection with low similarity, Ackley and Schwefel
                    load('Tasks\CI_L.mat')
                    object.M = 2;
                    object.Tdims = zeros(object.M,1);
                    object.Tdims(1) = 50;
                    object.Tdims(2) = 50;
                    object.D_multitask = max(object.Tdims);
                    object.Lb = ones(object.M,object.D_multitask);
                    object.Ub = ones(object.M,object.D_multitask);
                    object.Lb(1,:) = -50*object.Lb(1,:);
                    object.Lb(2,:) = -500*object.Lb(2,:);
                    object.Ub(1,:) = 50*object.Ub(1,:);
                    object.Ub(2,:) = 500*object.Ub(2,:);
                    object.fun(1).fnc=@(x)Ackley(x,Rotation_Task1,GO_Task1);
                    object.fun(2).fnc=@(x)Schwefel(x);

                case 4 % partially intersection with high similarity, Rastrigin and Sphere
                    load('Tasks\PI_H.mat')
                    object.M = 2;
                    object.Tdims = zeros(object.M,1);
                    object.Tdims(1) = 50;
                    object.Tdims(2) = 50;
                    object.D_multitask = max(object.Tdims);
                    object.Lb = ones(object.M,object.D_multitask);
                    object.Ub = ones(object.M,object.D_multitask);
                    object.Lb(1,:) = -50*object.Lb(1,:);
                    object.Lb(2,:) = -100*object.Lb(2,:);
                    object.Ub(1,:) = 50*object.Ub(1,:);
                    object.Ub(2,:) = 100*object.Ub(2,:);
%                     object.Lb(1,:) = -500*object.Lb(1,:);
%                     object.Lb(2,:) = -50*object.Lb(2,:);
%                     object.Ub(1,:) = 500*object.Ub(1,:);
%                     object.Ub(2,:) = 50*object.Ub(2,:);
                    object.fun(1).fnc=@(x)Rastrigin(x,Rotation_Task1,GO_Task1);
                    object.fun(2).fnc=@(x)Sphere(x,GO_Task2);
                    
                case 5 % partially intersection with medium similarity, Ackley and Rosenbrock
                    load('Tasks\PI_M.mat')
                    object.M = 2;
                    object.Tdims = zeros(object.M,1);
                    object.Tdims(1) = 50;
                    object.Tdims(2) = 50;
                    object.D_multitask = max(object.Tdims);
                    object.Lb = ones(object.M,object.D_multitask);
                    object.Ub = ones(object.M,object.D_multitask);
                    object.Lb(1,:) = -50*object.Lb(1,:);
                    object.Lb(2,:) = -50*object.Lb(2,:);
                    object.Ub(1,:) = 50*object.Ub(1,:);
                    object.Ub(2,:) = 50*object.Ub(2,:);
                    object.fun(1).fnc=@(x)Ackley(x,Rotation_Task1,GO_Task1);
                    object.fun(2).fnc=@(x)Rosenbrock(x);

                case 6 % partially intersection with low similarity, Ackley and Weierstrass
                    load('Tasks\PI_L.mat')
                    object.M = 2;
                    object.Tdims = zeros(object.M,1);
                    object.Tdims(1) = 50;
                    object.Tdims(2) = 25;
                    object.D_multitask = max(object.Tdims);
                    object.Lb = ones(object.M,object.D_multitask);
                    object.Ub = ones(object.M,object.D_multitask);
                    object.Lb(1,:) = -50*object.Lb(1,:);
                    object.Lb(2,:) = -0.5*object.Lb(2,:);
                    object.Ub(1,:) = 50*object.Ub(1,:);
                    object.Ub(2,:) = 0.5*object.Ub(2,:);
                    object.fun(1).fnc=@(x)Ackley(x,Rotation_Task1,GO_Task1);
                    object.fun(2).fnc=@(x)Weierstrass(x,Rotation_Task2,GO_Task2);
                    
                case 7 % no intersection with high similarity, Rosenbrock and Rastrigin
                    load('Tasks\NI_H.mat')
                    object.M = 2;
                    object.Tdims = zeros(object.M,1);
                    object.Tdims(1) = 50;
                    object.Tdims(2) = 50;
                    object.D_multitask = max(object.Tdims);
                    object.Lb = ones(object.M,object.D_multitask);
                    object.Ub = ones(object.M,object.D_multitask);
                    object.Lb(1,:) = -50*object.Lb(1,:);
                    object.Lb(2,:) = -50*object.Lb(2,:);
                    object.Ub(1,:) = 50*object.Ub(1,:);
                    object.Ub(2,:) = 50*object.Ub(2,:);
                    object.fun(1).fnc=@(x)Rosenbrock(x);
                    object.fun(2).fnc=@(x)Rastrigin(x,Rotation_Task2,GO_Task2);
                    
                case 8 % no intersection with medium similarity, Griewank and Weierstrass
                    load('Tasks\NI_M.mat')
                    object.M = 2;
                    object.Tdims = zeros(object.M,1);
                    object.Tdims(1) = 50;
                    object.Tdims(2) = 50;
                    object.D_multitask = max(object.Tdims);
                    object.Lb = ones(object.M,object.D_multitask);
                    object.Ub = ones(object.M,object.D_multitask);
                    object.Lb(1,:) = -100*object.Lb(1,:);
                    object.Lb(2,:) = -0.5*object.Lb(2,:);
                    object.Ub(1,:) = 100*object.Ub(1,:);
                    object.Ub(2,:) = 0.5*object.Ub(2,:);
                    object.fun(1).fnc=@(x)Griewank(x,Rotation_Task1,GO_Task1);
                    object.fun(2).fnc=@(x)Weierstrass(x,Rotation_Task2,GO_Task2);
                    
                case 9 % no overlap with low similarity, Rastrigin and Schwefel
                    load('Tasks\NI_L.mat')
                    object.M = 2;
                    object.Tdims = zeros(object.M,1);
                    object.Tdims(1) = 50;
                    object.Tdims(2) = 50;
                    object.D_multitask = max(object.Tdims);
                    object.Lb = ones(object.M,object.D_multitask);
                    object.Ub = ones(object.M,object.D_multitask);
                    object.Lb(1,:) = -50*object.Lb(1,:);
                    object.Lb(2,:) = -500*object.Lb(2,:);
                    object.Ub(1,:) = 50*object.Ub(1,:);
                    object.Ub(2,:) = 500*object.Ub(2,:);
                    object.fun(1).fnc=@(x)Rastrigin(x,Rotation_Task1,GO_Task1);
                    object.fun(2).fnc=@(x)Schwefel(x);
                    
                case 10 % ten tasks
                    object.M = 10;
                    object.Tdims = zeros(object.M,1);
                    object.Tdims(1) = 50;
                    object.Tdims(2) = 50;
                    object.Tdims(3) = 50;
                    object.Tdims(4) = 25;
                    object.Tdims(5) = 50;
                    object.Tdims(6) = 50;
                    object.Tdims(7) = 50;
                    object.Tdims(8) = 50;
                    object.Tdims(9) = 50;
                    object.Tdims(10) = 50;
                    object.D_multitask = max(object.Tdims);
                    
                    object.Lb = ones(object.M,object.D_multitask);
                    object.Ub = ones(object.M,object.D_multitask);
                    object.Lb(1,:) = -100*object.Lb(1,:);%Sphere1
                    object.Ub(1,:) = 100*object.Ub(1,:);%Sphere1
                    object.Lb(2,:) = -100*object.Lb(2,:);%Sphere2
                    object.Ub(2,:) = 100*object.Ub(2,:);%Sphere2
                    object.Lb(3,:) = -100*object.Lb(3,:);%Sphere3
                    object.Ub(3,:) = 100*object.Ub(3,:);%Sphere3
                    object.Lb(4,:) = -0.5*object.Lb(4,:);%Weierstrass25D
                    object.Ub(4,:) = 0.5*object.Ub(4,:);%Weierstrass25D
                    object.Lb(5,:) = -50*object.Lb(5,:);%Rosenbrock
                    object.Ub(5,:) = 50*object.Ub(5,:);%Rosenbrock
                    object.Lb(6,:) = -50*object.Lb(6,:);%Ackley
                    object.Ub(6,:) = 50*object.Ub(6,:);%Ackley
                    object.Lb(7,:) = -0.5*object.Lb(7,:);%Weierstrass50D
                    object.Ub(7,:) = 0.5*object.Ub(7,:);%Weierstrass50D
                    object.Lb(8,:) = -500*object.Lb(8,:);%Schwefel
                    object.Ub(8,:) = 500*object.Ub(8,:);%Schwefel
                    object.Lb(9,:) = -100*object.Lb(9,:);%Griewank
                    object.Ub(9,:) = 100*object.Ub(9,:);%Griewank
                    object.Lb(10,:) = -50*object.Lb(10,:);%Rastrigin
                    object.Ub(10,:) = 50*object.Ub(10,:);%Rastrigin
                    
                    opt1=0*ones(1,object.Tdims(1));
                    object.fun(1).fnc=@(x)Sphere(x,opt1);
                    opt2=80*ones(1,object.Tdims(2));
                    object.fun(2).fnc=@(x)Sphere(x,opt2);
                    opt3=-80*ones(1,object.Tdims(3));
                    object.fun(3).fnc=@(x)Sphere(x,opt3);
                    opt4=-0.4*ones(1,object.Tdims(4));
                    M4=eye(object.Tdims(4),object.Tdims(4));
                    object.fun(4).fnc=@(x)Weierstrass(x,M4,opt4);
                    opt5=-1*ones(1,object.Tdims(5));
                    M5=eye(object.Tdims(5),object.Tdims(5));
                    object.fun(5).fnc=@(x)Rosenbrockm(x,M5,opt5);
                    opt6=40*ones(1,object.Tdims(6));
                    M6=eye(object.Tdims(6),object.Tdims(6));
                    object.fun(6).fnc=@(x)Ackley(x,M6,opt6);
                    opt7=-0.4*ones(1,object.Tdims(7));
                    M7=eye(object.Tdims(7),object.Tdims(7));
                    object.fun(7).fnc=@(x)Weierstrass(x,M7,opt7);
%                     opt8=420.9687*ones(1,object.Tdims(8));
                    opt8=zeros(1,object.Tdims(8));
                    M8=eye(object.Tdims(8),object.Tdims(8));
                    object.fun(8).fnc=@(x)Schwefelm(x,M8,opt8);
                    opt9=80*ones(1,object.Tdims(9));
                    opt9(1:object.Tdims(9)/2)=-opt9(1:object.Tdims(9)/2);
                    M9=eye(object.Tdims(9),object.Tdims(9));
                    object.fun(9).fnc=@(x)Griewank(x,M9,opt9);
                    opt10=-40*ones(1,object.Tdims(10));
                    opt10(1:object.Tdims(10)/2)=-opt10(1:object.Tdims(10)/2);
                    M10=eye(object.Tdims(10),object.Tdims(10));
                    object.fun(10).fnc=@(x)Rastrigin(x,M10,opt10);
            end
        end  
    end
end