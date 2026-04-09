function figPaths = plot_curated_suite_overview(ranking, plotTitle, outDir)
%PLOT_CURATED_SUITE_OVERVIEW Generate compact overview plots for the suite.
if ~exist(outDir, 'dir')
    mkdir(outDir);
end

labels = arrayfun(@(r) strrep(r.runName, '_', ' '), ranking, 'UniformOutput', false);
x = 1:numel(ranking);
peakObjective = arrayfun(@(r) r.peakObjective, ranking);
peakRho = arrayfun(@(r) r.peakRhoCompressionRatio, ranking);
peakB = arrayfun(@(r) r.peakBCompressionRatio, ranking);
peakP = arrayfun(@(r) r.peakPCompressionRatio, ranking);
bestRhoU = arrayfun(@(r) r.bestMetrics.rhoUniformity, ranking);
bestBU = arrayfun(@(r) r.bestMetrics.BmagUniformity, ranking);
bestPU = arrayfun(@(r) r.bestMetrics.pUniformity, ranking);
bestSym = arrayfun(@(r) r.bestMetrics.symmetryPenalty, ranking);
bestStag = arrayfun(@(r) r.bestMetrics.stagnationPenalty, ranking);

figure('Name', [plotTitle ' curated metric overview']);
plot(x, peakObjective, '-o', 'DisplayName', 'peak objective'); hold on;
plot(x, peakRho, '-s', 'DisplayName', 'peak rho compression');
plot(x, peakB, '-d', 'DisplayName', 'peak |B| compression');
plot(x, peakP, '-^', 'DisplayName', 'peak pressure compression');
set(gca, 'XTick', x, 'XTickLabel', labels, 'XTickLabelRotation', 25);
ylabel('metric value');
grid on; legend('Location','best');
title([plotTitle ' compression and objective']);
figPaths.metricOverview = save_figure_if_requested(plotTitle, 'curated_metric_overview', outDir);

figure('Name', [plotTitle ' curated penalty overview']);
plot(x, bestRhoU, '-o', 'DisplayName', 'best rho uniformity'); hold on;
plot(x, bestBU, '-s', 'DisplayName', 'best |B| uniformity');
plot(x, bestPU, '-d', 'DisplayName', 'best pressure uniformity');
plot(x, bestSym, '-^', 'DisplayName', 'best symmetry penalty');
plot(x, bestStag, '-v', 'DisplayName', 'best stagnation penalty');
set(gca, 'XTick', x, 'XTickLabel', labels, 'XTickLabelRotation', 25);
ylabel('penalty / nonuniformity');
grid on; legend('Location','best');
title([plotTitle ' uniformity and penalty diagnostics']);
figPaths.penaltyOverview = save_figure_if_requested(plotTitle, 'curated_penalty_overview', outDir);
end
