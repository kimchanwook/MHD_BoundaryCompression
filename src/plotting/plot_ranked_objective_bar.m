function figPath = plot_ranked_objective_bar(ranking, plotTitle, outDir)
labels = arrayfun(@(r) strrep(r.runName, '_', ' '), ranking, 'UniformOutput', false);
values = arrayfun(@(r) r.peakObjective, ranking);
figure('Name',[plotTitle ' ranked objective']);
bar(values);
set(gca, 'XTick', 1:numel(labels), 'XTickLabel', labels, 'XTickLabelRotation', 30);
ylabel('peak objective'); grid on;
title([plotTitle ' ranked by peak objective']);
figPath = save_figure_if_requested(plotTitle, 'ranked_peak_objective', outDir);
end
