function [objective,calls,EvBestFitness_evn,TotalEvaluations_evn] = CalObj(Parameter,Task,rnvec,i,calls,EvBestFitness_evn,TotalEvaluations_evn)
% Calculate the objective function value of the i-th task
% Input: parameter(N,maxfes), task(M,Tdims,Lb,Ub,fun), chorme, task number,
% number of evaluations per task, the best fitness value after each
% evaluation, the best fitness values for all tasks at intervals (100000*
% Task.m /10).
% Output:the objective function value of the i-th task, number of
% evaluations per task, the best fitness value after each evaluation, the
% best fitness values for all tasks at intervals (100000*Task.m /10).
%--------------------------------------------------------------------------
    d = Task.Tdims(i);
    nvars = rnvec(:,1:d);
    NN = size(rnvec,1);
    minrange = Task.Lb(i,1:d);
    maxrange = Task.Ub(i,1:d);
    y=repmat(maxrange-minrange,[NN,1]);
    x = y.*nvars + repmat(minrange,[NN,1]);
    objective=Task.fun(i).fnc(x);
    for j=1:NN 
        if (mod(sum(calls),(Parameter.maxfes-Parameter.N*Task.M)/10) == (Parameter.N*Task.M)) % Record the best fitness values for all tasks at intervals (100000* Task.m /10).
            if (sum(calls)-Parameter.N*Task.M)==0
                for k=1:Task.M
                    TotalEvaluations_evn(1,k) = EvBestFitness_evn(k);
                end
                disp(['MTEA-AD Eval = ', num2str(sum(calls)), ' EvBestFitness = ', num2str(TotalEvaluations_evn(1,:))]);
            else
                for k=1:Task.M
                    TotalEvaluations_evn(((sum(calls)-Parameter.N*Task.M)/((Parameter.maxfes-Parameter.N*Task.M)/10))+1,k) = EvBestFitness_evn(k);
                end
                disp(['MTEA-AD Eval = ', num2str(sum(calls)), ' EvBestFitness = ', num2str(TotalEvaluations_evn(((sum(calls)-Parameter.N*Task.M)/((Parameter.maxfes-Parameter.N*Task.M)/10))+1,:))]);
            end
        end
        if sum(calls) < Parameter.maxfes
            calls(i) = calls(i) + 1;
            if calls(i)==1
                EvBestFitness_evn(i) = objective(j);
            else
                EvBestFitness_evn(i) = min(EvBestFitness_evn(i),objective(j));%minimization
            end
        end
    end
    end