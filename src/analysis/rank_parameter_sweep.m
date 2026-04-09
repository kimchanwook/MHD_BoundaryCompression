function ranking = rank_parameter_sweep(results)
%RANK_PARAMETER_SWEEP Sort results by peak objective, then by final objective.
peakObjectives = arrayfun(@(r) r.peakObjective, results);
finalObjectives = arrayfun(@(r) r.finalObjective, results);
keys = [-peakObjectives(:), -finalObjectives(:)];
[~, order] = sortrows(keys, [1, 2]);
ranking = results(order);

fprintf('\nSweep ranking by peak objective:\n');
for k = 1:numel(order)
    r = ranking(k);
    fprintf('%2d. %-30s peakJ = %10.6f   finalJ = %10.6f   peak<rho> = %9.5f   peak<|B|> = %9.5f\n', ...
        k, r.runName, r.peakObjective, r.finalObjective, r.peakRhoCoreMean, r.peakBmagCoreMean);
end
end
