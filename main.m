% We provided MATLAB implementations for
% Multitask evolutionary algorithm based on anomaly detection (MTEA-AD).
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
clc,clear
addpath(genpath(pwd))

%% Parameter Initialization
name = 1;                                                                  % Test suites:1~10(The number of tasks in 1~9 (10) is 2(10))
Parameter = PARAMETER();
Parameter = initPARAMETER(Parameter);

%% Task Initialization
Task = TASK();
Task = initTASK(Task,name);
Parameter.maxfes = (100000+Parameter.N)*Task.M;                            % Maximum number of function evaluations

%% Multiple Experiments
EvBestFitness_evn = zeros(11,Task.M);                                      % Record the best fitness values for all tasks at intervals (100000* Task.m /10).Since the initialization result is also saved, so 10+1
BestFitness = zeros(Parameter.times,Task.M);                               % Store the optimal solution fitness values
bestSolution = zeros(Task.M,Task.D_multitask,Parameter.times);             % Best individuals
wall_clock_time = zeros(Parameter.times,1);                                % Store the running time for each run

for i =1:Parameter.times
    disp(['Times = ', num2str(i)]);
    data_MTEAAD(i) = MTEAAD(Parameter,Task);
    EvBestFitness_evn = EvBestFitness_evn + data_MTEAAD(i).EvBestFitness_evn;
    BestFitness(i,:) = data_MTEAAD(i).BestFitness;
    bestSolution(:,:,i) = data_MTEAAD(i).bestSolution;
    wall_clock_time(i) = data_MTEAAD(i).wall_clock_time;
end

%% Plot
for i=1:Task.M
    figure(i)
    hold on
    plot((Parameter.N*Task.M):((Parameter.maxfes-Parameter.N*Task.M)/10):Parameter.maxfes,log(EvBestFitness_evn(:,i)),'r-+','LineWidth',1.5);
    xlabel('Number of Evalutions');
    ylabel(['log(Averaged Objective Value of Task-', num2str(i), ')']);
    saveas(gcf,['Data\figure_evl_',num2str(name),'_Task',num2str(i),'.fig']);
end

%% Results
for i = 1:Task.M
    disp([ 'Task_',num2str(i),':',num2str(mean(BestFitness(:,i),1)),'(',num2str(std(BestFitness(:,i),1)),')']);
end
data.BestFitness = BestFitness;
data.EvBestFitness_evn = EvBestFitness_evn;
data.bestSolution = bestSolution;
data.wall_clock_time = wall_clock_time;
save(['Data\MTEA_AD_',num2str(name),'_datasum.mat'],'data');