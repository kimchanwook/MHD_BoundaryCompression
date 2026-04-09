function convergence = run_grid_convergence_study(baseCaseConfig, resolutionList)
%RUN_GRID_CONVERGENCE_STUDY Run the same case at several resolutions and compare against the finest grid.
numCases = numel(resolutionList);
summaries = cell(numCases,1);
for k = 1:numCases
    cfg = baseCaseConfig;
    cfg.grid.Nx = resolutionList(k);
    cfg.grid.Ny = resolutionList(k);
    cfg.runName = sprintf('%s_N%03d', baseCaseConfig.runName, resolutionList(k));
    summaries{k} = run_case(cfg);
end

peakObjective = cellfun(@(s) s.peakObjective, summaries);
peakRhoCompression = cellfun(@(s) s.peakRhoCompressionRatio, summaries);
minRhoUniformity = cellfun(@(s) s.minRhoUniformity, summaries);
maxDivBRms = cellfun(@(s) s.maxDivBRms, summaries);
massDrift = cellfun(@(s) s.massDrift, summaries);
energyDrift = cellfun(@(s) s.totalEnergyDrift, summaries);
h = 1 ./ resolutionList(:);

refPeakObjective = peakObjective(end);
refPeakRhoCompression = peakRhoCompression(end);
refMinRhoUniformity = minRhoUniformity(end);

resultsTable = table(resolutionList(:), h, peakObjective(:), peakRhoCompression(:), ...
    minRhoUniformity(:), maxDivBRms(:), massDrift(:), energyDrift(:), ...
    abs(peakObjective(:) - refPeakObjective), ...
    abs(peakRhoCompression(:) - refPeakRhoCompression), ...
    abs(minRhoUniformity(:) - refMinRhoUniformity), ...
    'VariableNames', {'N','h','peakObjective','peakRhoCompression','minRhoUniformity', ...
    'maxDivBRms','massDrift','energyDrift','error_peakObjective','error_peakRhoCompression','error_minRhoUniformity'});

convergence = struct();
convergence.baseRunName = baseCaseConfig.runName;
convergence.resolutionList = resolutionList(:);
convergence.summaries = summaries;
convergence.resultsTable = resultsTable;
convergence.estimatedOrders = compute_convergence_rates(resultsTable);
end
