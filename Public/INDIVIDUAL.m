classdef INDIVIDUAL  
    % This class contains P populations.
    % Consists of four items: the number of pop, the index of pop,
    % chromosomes, function value.
    % INDIVIDUAL needs to be initialized by initPOP.
    properties
        P;                                                                 % Number of pop
        flag;                                                              % Index of pop
        rnvec;                                                             % (genotype)--> Decode to find design variables --> (phenotype) 
        factorial_costs;                                                   % Function value
    end    
    methods        
        function object = initPOP(object,N,Task)
            object.P = Task.M;
            object.rnvec = rand(object.P*N,Task.D_multitask);
            object.factorial_costs = inf*ones(object.P*N,1);
            object.flag = zeros(object.P*N,1);
            for i=1:object.P
                object.flag((i-1)*N+1:i*N,1) = i;
            end
        end
    end
end