function A_FN_uniform = FN_uniform(A, num_FN)

% The function generates false negative (FN) edges by randomly choosing a
% non-zero edge and assigning it the weight of 0.

    non_zero_ids = find(A ~= 0); 
    selected_ids = randsample(non_zero_ids, num_FN); % Randomly select num_FP indices
    A_FN_uniform = A;
    A_FN_uniform(selected_ids) = 0; % Set the selected indices to 0
end