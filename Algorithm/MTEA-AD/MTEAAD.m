function data_MTEAAD = MTEAAD(Parameter,Task)
    % We provided MATLAB implementations for
    % Multitask evolutionary algorithm based on anomaly detection (MTEA-AD).
    % Input: parameter information(N,proC,disC,proM,disM,TRP,gen,selection_process,times,maxfes)
    % and task information (M,Tdims,D_multitask,Lb,Ub,fun).
    % Output: data_MTEAAD (run time, best value for each evaluation, the
    % best fitness values for all tasks at intervals (100000* Task.m /10), best individual).
    %--------------------------------------------------------------------------
    tic
    %% 0.Record the optimal solution matrix
    BestFitness = zeros(Task.M,1);                          % The best fitness value after each evaluation
    EvBestFitness_evn = zeros(11,Task.M);                   % Record the best fitness values for all tasks at intervals (100000* Task.m /10).
    Evaluations=zeros(Task.M,1);                            % Number of individual evaluations on each task
    bestSolution = zeros(Task.M,Task.D_multitask);          % Best individuals
    num = zeros(Task.M,2);
    num(:,1) = 1;
    epsilon = zeros(1,Task.M);                              % Parameter of the anomaly detection model

    %% 1.Initial population
    Population = INDIVIDUAL();           
    Population = initPOP(Population,Parameter.N,Task);

    %% 2.Evaluate the objective function value of each individual
    for j = 1:Population.P
            [Population.factorial_costs(Population.flag == j,1),Evaluations,BestFitness,EvBestFitness_evn]=CalObj(Parameter,Task,Population.rnvec(Population.flag == j,:),j,Evaluations,BestFitness,EvBestFitness_evn);
            [~,y] = sort(Population.factorial_costs(Population.flag == j)); % Ascending sort
            trnvec = Population.rnvec(Population.flag == j,:);
            bestSolution(j,:) = trnvec(y(1),:);
    end

    %% 3.Optimization process
    i=1;
    while(sum(Evaluations)<Parameter.maxfes && sum(BestFitness >= Parameter.stopfitness) > 0) 
        epsilont = zeros(1,Task.M);
        for j = 1:Population.P
            if (BestFitness(j) >= Parameter.stopfitness)
                % 3.1 Generate offspring
                Offspring = Population;
                Offspring.rnvec(Offspring.flag == j,:) = GA(Population.rnvec(Population.flag == j,:),{Parameter.proC,Parameter.disC,Parameter.proM,Parameter.disM});
                
                % Knowledge transfer
                if rand() < Parameter.TRP
                    
                    % 3.2 Learning the anomaly detection model
                    if i == 1
                        NL = 1;% Initialization
                    else
                        NL = epsilon(i-1,j);% Self-adaption
                    end
                    [tfsol,num(j,1) ] = learn_anomaly_detection(Offspring, Task, j, NL);

                    % 3.3 Evaluation of individual offspring and candidate transferred solutions
                    [Offspring.factorial_costs(Offspring.flag == j,1),Evaluations,BestFitness,EvBestFitness_evn]=CalObj(Parameter,Task,Offspring.rnvec(Offspring.flag == j,:),j,Evaluations,BestFitness,EvBestFitness_evn);
                    [factorial_costs,Evaluations,BestFitness,EvBestFitness_evn]=CalObj(Parameter,Task,tfsol,j,Evaluations,BestFitness,EvBestFitness_evn);

                    % 3.4 Merge parent,offspring and candidate transferred solutions
                    [Population, num(j,2)] = tfES(Population,Offspring,tfsol,factorial_costs,Parameter,j);
                    [~,y] = sort(Population.factorial_costs(Population.flag == j));% Ascending sort
                    trnvec = Population.rnvec(Population.flag == j,:);
                    bestSolution(j,:) = trnvec(y(1),:);
                    
                    % 3.5 Parameter adaptation strategy via elitism
                    epsilont(1,j) = (num(j,2)/num(j,1));
                    
                % No knowledge transfer
                else                
                    % 3.2 Evaluation of individual offspring
                    [Offspring.factorial_costs(Offspring.flag == j,1),Evaluations,BestFitness,EvBestFitness_evn]=CalObj(Parameter,Task,Offspring.rnvec(Offspring.flag == j,:),j,Evaluations,BestFitness,EvBestFitness_evn);
                 
                    % 3.3 Merge the parents and the children
                    Population = EnvironmentalSelection(Population,Offspring,Parameter,j);
                    [~,y] = sort(Population.factorial_costs(Population.flag == j));% Ascending sort
                    trnvec = Population.rnvec(Population.flag == j,:);
                    bestSolution(j,:) = trnvec(y(1),:);
                end
            end
        end
        epsilon = [epsilon;epsilont];
        i = i+1; 
    end
    if sum(BestFitness > Parameter.stopfitness) == 0
        for k=1:Task.M
            EvBestFitness_evn(EvBestFitness_evn(:,k)==0,k) = BestFitness(k);
            [~,y] = sort(Population.factorial_costs(Population.flag == k));% Ascending sort
            trnvec = Population.rnvec(Population.flag == k,:);
            bestSolution(k,:) = trnvec(y(1),:);
        end
        disp(['MTEA-AD Eval = ', num2str(sum(Evaluations)), ' EvBestFitness = ', num2str(BestFitness(:)')]);
    end

    %% Record algorithm results
    data_MTEAAD.wall_clock_time=toc;
    data_MTEAAD.BestFitness=BestFitness;
    data_MTEAAD.EvBestFitness_evn = EvBestFitness_evn;
    data_MTEAAD.bestSolution = bestSolution;
end