load("/MATLAB Drive/ConnOrdered_040903.mat");

Celegans_weighted = full(A_init_t_ordered);
Bi_celegans = double(Celegans_weighted > 0);

figure; imagesc(Bi_celegans); colorbar % The Weight = Number of Chemical Synapses.
title('Connection Matrix Visualization');
xlabel('Nodes');
ylabel('Nodes');

metrics = compute_all_metrics(Celegans_weighted, true, false); % wei dir. here path length, ge and C don't say much without normalization
metrics_bi = compute_all_metrics(Celegans_weighted, false, false); % bi directed
metrics_bi_2 = compute_all_metrics(Bi_celegans, false, false); % compare

norm_metrics = normalizeMetrics(Celegans_weighted, true, false, metrics.path_length, metrics.C, metrics.GE, 10, 10);
norm_bi_metrics = normalizeMetrics(Bi_celegans, true, false, metrics_bi_2.path_length, metrics_bi_2.C, metrics_bi_2.GE, 10, 10);

% For potential SW observation
% SW_norm = norm_metrics.Cnorm / norm_metrics.Lnorm % celegans weighted directed matrix is showing small-world behavior
% SW_bi_norm = norm_bi_metrics.Cnorm / norm_bi_metrics.Lnorm

% FP and PN generation
Bi_celegans_FP = FP_uniform(Bi_celegans, false, 100);
figure; imagesc(Bi_celegans_FP - Bi_celegans); colorbar % The Weight = Number of Chemical Synapses.
title('Check for FP_uniform, only FP edges');

Bi_celegans_FP = FP_uniform(Bi_celegans, true, 100); % check for proped random distribution work
figure; imagesc(Bi_celegans_FP - Bi_celegans); colorbar
title('Check for FP_uniform, only FP edges');

% the weighted distribution was chosen to be uniform since it assumes the
% "grains" in the data
Celegans_FP = FP_uniform(Celegans_weighted, true, 100); % check weighted matrix
figure; imagesc(Celegans_FP - Celegans_weighted); colorbar
title('Check for FP_uniform, only FP edges');

Celegans_FN = FN_uniform(Celegans_weighted, 100);
figure; imagesc(Celegans_FN - Celegans_weighted); colorbar
title('Check for FP_uniform, only FP edges');

[Cs_FP, GEs_FP, Modularities_FP, Num_modules_FP, Cs_FN, GEs_FN, Modularities_FN, Num_modules_FN] = compute_dynamics(Celegans_weighted, 300, true, false);

figure; 
plot(1:300, Cs_FN, 'r', 1:300, Cs_FP, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Clustering Coefficient');
title('Comparison of Clustering Coefficients for FN and FP, weighted, directed');
legend('Cs FN', 'Cs FP');
grid on;

figure; 
plot(1:300, GEs_FN, 'r', 1:300, GEs_FP, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Global Efficiencies');
title('Comparison of Global Efficiencies for FN and FP, weighted, directed');
legend('GEs FN', 'GEs FP');
grid on;

figure; 
plot(1:300, Modularities_FN, 'r', 1:300, Modularities_FP, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Modularities');
title('Comparison of Modularities for FN and FP, weighted, directed');
legend('Modularities FN', 'Modularities FP');
grid on;

figure; 
plot(1:300, Num_modules_FN, 'r', 1:300, Num_modules_FP, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Number of modules');
title('Comparison of number of modules for FN and FP, weighted, directed');
legend('Number of modules FN', 'Number of modules FP');
grid on;

[Bi_Cs_FP, Bi_GEs_FP, Bi_Modularities_FP, Bi_Num_modules_FP, Bi_Cs_FN, Bi_GEs_FN, Bi_Modularities_FN, Bi_Num_modules_FN] = compute_dynamics(Bi_celegans, 300, false, false);

figure; 
plot(1:300, Bi_Cs_FN, 'r', 1:300, Bi_Cs_FP, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Clustering Coefficient');
title('Comparison of Clustering Coefficients for FN and FP, binary, directed');
legend('Cs FN', 'Cs FP');
grid on;

figure; 
plot(1:300, Bi_GEs_FN, 'r', 1:300, Bi_GEs_FP, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Global Efficiencies');
title('Comparison of Global Efficiencies for FN and FP, binary, directed');
legend('GEs FN', 'GEs FP');
grid on;

figure; 
plot(1:300, Bi_Modularities_FN, 'r', 1:300, Bi_Modularities_FP, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Modularities');
title('Comparison of Modularities for FN and FP, binary, directed');
legend('Modularities FN', 'Modularities FP');
grid on;

figure; 
plot(1:300, Bi_Num_modules_FN, 'r', 1:300, Bi_Num_modules_FP, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Number of modules');
title('Comparison of number of modules for FN and FP, binary, directed');
legend('Number of modules FN', 'Number of modules FP');
grid on;

% Symmetzation of the celegans matrix
Celegans_sym = (Celegans_weighted + Celegans_weighted') / 2;
Celegans_sym(1:size(Celegans_sym,1)+1:end) = 0;
figure; imagesc(Celegans_sym); colorbar;
title('Symmetrified Celegans Matrix');

[Cs_FP_sym, GEs_FP_sym, Modularities_FP_sym, Num_modules_FP_sym, Cs_FN_sym, GEs_FN_sym, Modularities_FN_sym, Num_modules_FN_sym] = compute_dynamics(Celegans_sym, 300, true, true);

figure; 
plot(1:300, Cs_FN_sym, 'r', 1:300, Cs_FP_sym, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Clustering Coefficient');
title('Comparison of Clustering Coefficients for FN and FP, weighted, undirected');
legend('Cs FN', 'Cs FP');
grid on;

figure; 
plot(1:300, GEs_FN_sym, 'r', 1:300, GEs_FP_sym, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Global Efficiencies');
title('Comparison of Global Efficiencies for FN and FP, weighted, undirected');
legend('GEs FN', 'GEs FP');
grid on;

figure; 
plot(1:300, Modularities_FN_sym, 'r', 1:300, Modularities_FP_sym, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Modularities');
title('Comparison of Modularities for FN and FP, weighted, undirected');
legend('Modularities FN', 'Modularities FP');
grid on;

figure; 
plot(1:300, Num_modules_FN_sym, 'r', 1:300, Num_modules_FP_sym, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Number of modules');
title('Comparison of number of modules for FN and FP, weighted, undirected');
legend('Number of modules FN', 'Number of modules FP');
grid on;

Bi_celegans_sym = double(Celegans_sym > 0);
[Bi_Cs_FP_sym, Bi_GEs_FP_sym, Bi_Modularities_FP_sym, Bi_Num_modules_FP_sym, Bi_Cs_FN_sym, Bi_GEs_FN_sym, Bi_Modularities_FN_sym, Bi_Num_modules_FN_sym] = compute_dynamics(Bi_celegans_sym, 300, false, true);

figure; 
plot(1:300, Bi_Cs_FN_sym, 'r', 1:300, Bi_Cs_FP_sym, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Clustering Coefficient');
title('Comparison of Clustering Coefficients for FN and FP, binary, undirected');
legend('Cs FN', 'Cs FP');
grid on;

figure; 
plot(1:300, Bi_GEs_FN_sym, 'r', 1:300, Bi_GEs_FP_sym, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Global Efficiencies');
title('Comparison of Global Efficiencies for FN and FP, binary, undirected');
legend('GEs FN', 'GEs FP');
grid on;

figure; 
plot(1:300, Bi_Modularities_FN_sym, 'r', 1:300, Bi_Modularities_FP_sym, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Modularities');
title('Comparison of Modularities for FN and FP, binary, undirected');
legend('Modularities FN', 'Modularities FP');
grid on;

figure; 
plot(1:300, Bi_Num_modules_FN_sym, 'r', 1:300, Bi_Num_modules_FP_sym, 'g'); 
xlabel('Number of FPs and FNs');
ylabel('Number of modules');
title('Comparison of number of modules for FN and FP, binary, undirected');
legend('Number of modules FN', 'Number of modules FP');
grid on;
