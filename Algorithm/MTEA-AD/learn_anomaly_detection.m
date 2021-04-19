function [ tfsol, num ] = learn_anomaly_detection(Population,Task, tn, NL)
    % Learning anomaly detection model of task tn
    % Input: chorme, task(Tdims), task number, anomaly detection parameter.
    % Output: candidate transferred solutions, the number of candidate transferred
    % solutions.
    
    % Sample, make sure that the fitted covariance is a square, symmetric, positive definite matrix.
    rrnvec = Population.rnvec(Population.flag == tn,1:Task.Tdims(tn));
    nsamples = floor(0.01*size(rrnvec,1));
    randMat = rand(nsamples,Task.Tdims(tn));
    rrnvec = [rrnvec;randMat];
    
    % Fit
    mmean = mean(rrnvec);
    sstd1 = cov(rrnvec);
    sstd = sstd1 + (10e-6)*eye(size(rrnvec,2));
    
    % Calculate the scores
    [rnvec,~] = unique(Population.rnvec(Population.flag ~= tn,:),'rows');
    Y = mvnpdf(rnvec(:,1:Task.Tdims(tn)),mmean,sstd);
    
    % Select the candidate transferred solutions
    [~,ii] = sort(Y,'descend');
    if NL == 0
        mm = Y(1); % Ensure that the number of transferred individuals is not 0
    else
        mm = Y(ii(ceil(size(Y,1)*NL)));
    end
    
    % Count the number of candidate transferred solutions
    tte = Y >= mm;
    tfsol = rnvec(tte,:);
    num = sum(tte);
    
end