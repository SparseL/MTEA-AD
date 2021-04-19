function [Population,num] = tfES(Population,Offspring,tfsol,factorial_costs,Parameter,M)
% EnvironmentalSelection
% Input:population chromes and objective values, offspring chromes and
% objective values, candidate transferred solutions' chromes and objective
% values, selection_process (option: elitist,roulette wheel), task number
% M.
% Output: population chromes and objective values, the number of effect
% transfer solutions.
%--------------------------------------------------------------------------
    nvec = [Population.rnvec(Population.flag == M,:);Offspring.rnvec(Offspring.flag == M,:);tfsol];
    fitness = [Population.factorial_costs(Population.flag == M,1);Offspring.factorial_costs(Offspring.flag == M,1);factorial_costs];
    if strcmp(Parameter.selection_process,'elitist')
        [~,index]=sort(fitness);
    elseif strcmp(Parameter.selection_process,'roulette wheel')
        index = RouletteWheelSelection(Parameter.N,fitness);
    elseif strcmp(Parameter.selection_process,'Tournament')
        index = TournamentSelection(2,Parameter.N,fitness);
    end
    Population.rnvec(Population.flag == M,:) = nvec(index(1:Parameter.N),:);
    Population.factorial_costs(Population.flag == M,1) = fitness(index(1:Parameter.N),1);
    
    num = sum(index(1:Parameter.N) > 2*Parameter.N);
end