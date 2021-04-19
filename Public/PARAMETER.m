classdef PARAMETER    
    %This class contains all parameters and needs to be initialized by
    %initPARAMETER.
    properties
        N;                                     % Population size
        proC;                                  % SBX probability
        disC;                                  % SBX parameter
        proM;                                  % PM probability
        disM;                                  % PM parameter
        TRP;                                   % Probability of the knowledge transfer
        gen;                                   % Max generation,Note: The stop criterion in this code is the maximum number of function evaluations
        selection_process;                     % Options:elitist,roulette wheel,Tournament
        times;                                 % Number of runs
        maxfes;                                % Maximum number of function evaluations
        stopfitness;                           % Stop if fitness < stopfitness (minimization)
    end    
    methods        
        function object = initPARAMETER(object)
            object.N = 100;                                   % Population size
            object.proC = 1;                                  % SBX probability
            object.disC = 2;                                  % SBX parameter
            object.proM = 1;                                  % PM probability
            object.disM = 5;                                  % PM parameter
            object.TRP = 0.1;                                 % Probability of the knowledge transfer
            object.selection_process = 'elitist';             % Options:elitist,roulette wheel,Tournament
            object.times = 5;                                 % Number of runs
            object.stopfitness = 1e-06;                       % Stop if fitness < stopfitness (minimization)
        end  
    end
end