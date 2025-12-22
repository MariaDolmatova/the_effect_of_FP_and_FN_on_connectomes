function [Cs_FP, GEs_FP, Modularities_FP, Num_modules_FP, Cs_FN, GEs_FN, Modularities_FN, Num_modules_FN] = compute_dynamics(Celegans_weighted, num_it, is_weighted, is_symmetric)

% The function dynamically computes all the values of the
% compute_all_metrics for the assigned number of itirations with subsequent
% addition of FP or FN comnections. Once a connection is established or removed, a new
% edited matrix will become the reference. On each step only 1 connection
% is either added or removed. 

    Celeg_temp_FP = Celegans_weighted;
    Celeg_temp_FN = Celegans_weighted;
    Cs_FP = zeros(num_it, 1);
    Cs_FN = zeros(num_it, 1);
    GEs_FP = zeros(num_it, 1);
    GEs_FN = zeros(num_it, 1);
    Modularities_FP = zeros(num_it, 1);
    Modularities_FN = zeros(num_it, 1);
    Num_modules_FP = zeros(num_it, 1);
    Num_modules_FN = zeros(num_it, 1);
    
    for i = 1:num_it
        fprintf('iter FP %d\n', i);
        Celeg_temp_FP = FP_uniform(Celeg_temp_FP, is_weighted, 1);
        metrics_FP = compute_all_metrics(Celeg_temp_FP, is_weighted, is_symmetric); % weighted, directed
        Cs_FP(i) = metrics_FP.C; 
        GEs_FP(i) = metrics_FP.GE; 
        Modularities_FP(i) = metrics_FP.modularity; 
        Num_modules_FP(i) = metrics_FP.num_modules;
        
        fprintf('iter FN %d\n', i);
        Celeg_temp_FN = FN_uniform(Celeg_temp_FN, 1);
        metrics_FN = compute_all_metrics(Celeg_temp_FN, is_weighted, is_symmetric); 
        Cs_FN(i) = metrics_FN.C; 
        GEs_FN(i) = metrics_FN.GE; 
        Modularities_FN(i) = metrics_FN.modularity; 
        Num_modules_FN(i) = metrics_FN.num_modules;  
    end
end