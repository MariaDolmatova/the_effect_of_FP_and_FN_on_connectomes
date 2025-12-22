function A_FP_uniform = FP_uniform(A, is_weighted, num_FP)

% The function generates false positive (FP) edges by randomly choosing a 0
% edge. For the weighted case, the weight is randomly drawn from the
% empirical non-zero edge weight distribution.

    if ~is_weighted
        zero_ids = find(A == 0); % make a list of all the 0 in A
        selected_ids = randsample(zero_ids, num_FP); % Randomly select num_FP indices
        A_FP_uniform = A;
        A_FP_uniform(selected_ids) = 1; % Set the selected indices to 1
    else
        % Handle the case when the matrix A is weighted
        zero_ids = find(A == 0); % Find indices of non-zero elements
        selected_ids = randsample(zero_ids, num_FP); % Randomly select num_FP indices
        A_FP_uniform = A;
        A_w = A(A > 0);
        weights = datasample(A_w, num_FP);
        for i = 1:num_FP
            A_FP_uniform(selected_ids(i)) = weights(i); 
        end
    end
end