function norm_metrics = normalizeMetrics(A, is_weighted, is_symmetric, L, C, GE, network_num, num_edges)

% The function normalizes the metrics -- charachteristic path length (L),
% clustering coefficient (C), and global efficiency (GE) based on the
% reference measurements provided and on the reference matrix A by
% computing the average of the metrics over M-S rewiring and later
% normalization of the reference data over the average randomized data. 

% Lnorm was exctluded for this particular research but is fully
% functionable. 

    %Lrandom = zeros(network_num, 1);
    Crandom = zeros(network_num, 1);
    GErandom = zeros(network_num, 1); 

    for j = 1:network_num

        if is_weighted && is_symmetric
            B = randmio_und(A, num_edges);
            B_conv = weight_conversion(B, 'lengths'); % account for 0 connections that we will have a lot for celegans
            D = distance_wei(B_conv);
            %Lrandom(j) = mean(D(~isinf(D) & D > 0)); % we will have inf, account for them here too 
            Crandom(j) = mean(clustering_coef_wu(B));
            GErandom(j) = efficiency_wei(B_conv);

        elseif is_weighted && ~is_symmetric
            Abin = double(A > 0);
            Bbin = randmio_dir(Abin, num_edges);
            w = A(A > 0);  % existing weights
            w = w(randperm(numel(w))); % shuffle
            B = zeros(size(A));
            B(Bbin > 0) = w;

            B_conv = weight_conversion(B, 'lengths');
            D = distance_wei(B_conv);
            %Lrandom(j) = mean(D(~isinf(D) & D > 0));
            Crandom(j) = mean(clustering_coef_wd(B));
            GErandom(j) = efficiency_wei(B_conv);

        elseif ~is_weighted && is_symmetric
            B = randmio_und(A, num_edges);
            D = distance_bin(B);
            %Lrandom(j) = mean(D(~isinf(D) & D > 0));
            Crandom(j) = mean(clustering_coef_bu(B));
            GErandom(j) = efficiency_bin(B_conv);

        else
            Abin = double(A > 0);
            Bbin = randmio_dir(Abin, num_edges);
            w = A(A > 0);               
            w = w(randperm(numel(w)));   
            B = zeros(size(A));
            B(Bbin > 0) = w;

            %D = distance_bin(B);
            %Lrandom(j) = mean(D(~isinf(D) & D > 0));
            Crandom(j) = mean(clustering_coef_bd(B));
            GErandom(j) = efficiency_bin(B_conv);
        end
    end

    %norm_metrics.Lrand = mean(Lrandom);
    norm_metrics.Crand = mean(Crandom);
    norm_metrics.GErand = mean(GErandom);
    %norm_metrics.Lnorm = L / norm_metrics.Lrand;
    norm_metrics.Cnorm = C / norm_metrics.Crand;
    norm_metrics.GEnorm = GE / norm_metrics.GErand;
end
