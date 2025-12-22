function metrics = compute_all_metrics(A, is_weighted, is_symmetric)
    
% The function computes network density (binary and weighted), clustering
% coeficient (C), global efficiency (GE), characteristic path length,
% modularity and rich club coeffiicient based on the reference matrix A.
% The computation is provided for directed, undirected, binary and weighted
% matrices.

% Rich club was not included in the final study but is fully functionable.


    % Ensure binary is indeed binary
    if ~is_weighted
        A = double(A > 0);
    end


    % Remove diagonal
    A_no_diag = A - diag(diag(A));
    n = size(A, 1);


    % density
    if is_symmetric % this is actually not necessary but a bit more efficient
        max_edges = n * (n - 1) / 2;
        
        % Binary density
        A_binary = (A_no_diag > 0);
        metrics.binary_density = nnz(triu(A_binary, 1)) / max_edges;
        
        % Weighted density
        if is_weighted
            max_weight = max(A_no_diag(:));
            sum_weights = sum(sum(triu(A_no_diag, 1)));
            metrics.weighted_density = sum_weights / (max_weight * max_edges);
        end
        
    else  % Directed
        max_edges = n * (n - 1);
        
        % Binary density
        A_binary = (A_no_diag > 0);
        metrics.binary_density = nnz(A_binary) / max_edges;
        
        % Weighted density
        if is_weighted
            max_weight = max(A_no_diag(:));
            sum_weights = sum(A_no_diag(:));
            metrics.weighted_density = sum_weights / (max_weight * max_edges);
        end
    end


    % Clustering
    if is_weighted && is_symmetric
        metrics.C = mean(clustering_coef_wu(A));  % weighted undirected
    elseif is_weighted && ~is_symmetric
        metrics.C = mean(clustering_coef_wd(A));  % weighted directed
    elseif ~is_weighted && is_symmetric
        metrics.C = mean(clustering_coef_bu(A));  % binary undirected
    else
        metrics.C = mean(clustering_coef_bd(A));  % binary directed
    end
    

    % Avg path length 
    if is_weighted
        A_inv = A;
        A_inv(A_inv > 0) = 1 ./ A_inv(A_inv > 0);
        D = distance_wei(A_inv);
    else
        D = distance_bin(A);
    end
    metrics.path_length = mean(D(~isinf(D))); % minus inf values



    % GE %interchangeable with path length, for now left both (better inf
    % management since 1/inf)
    if is_weighted
        metrics.GE = efficiency_wei(A);
    else
        metrics.GE = efficiency_bin(A);
    end
    
    
    % Modularity 
    if ~is_symmetric
        [Ci, Q] = modularity_und(A);
        metrics.modularity = Q;
        metrics.num_modules = length(unique(Ci));
    else
        [Ci, Q] = modularity_dir(A);  
        metrics.modularity = Q;
        metrics.num_modules = length(unique(Ci));
    end

    
    % % Rich club
    % if is_weighted && is_symmetric
    %     metrics.rich_club = rich_club_wu(A); 
    % elseif is_weighted && ~is_symmetric
    %     metrics.rich_club = rich_club_wd(A); 
    % elseif ~is_weighted && is_symmetric
    %     metrics.rich_club = rich_club_bu(A); 
    % else
    %     metrics.rich_club = rich_club_bd(A);  
    % end
end