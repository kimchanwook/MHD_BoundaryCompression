function figPath = plot_sweep_summary(results, plotTitle, outDir)
%PLOT_SWEEP_SUMMARY Compare objective and compression histories across runs.
figure('Name',[plotTitle ' comparison']);
plotComparison(results, 'objective', 'objective');
figPath = save_figure_if_requested(plotTitle, 'comparison_objective', outDir);

figure('Name',[plotTitle ' rho comparison']);
plotComparison(results, 'rhoCoreMean', '<rho>_{core}');
save_figure_if_requested(plotTitle, 'comparison_rho_core', outDir);

figure('Name',[plotTitle ' B comparison']);
plotComparison(results, 'BmagCoreMean', '<|B|>_{core}');
save_figure_if_requested(plotTitle, 'comparison_B_core', outDir);

figure('Name',[plotTitle ' uniformity comparison']);
plotComparison(results, 'rhoUniformity', 'rho uniformity'); hold on;
plotComparison(results, 'BmagUniformity', '|B| uniformity', true);
legend('Location','best');
save_figure_if_requested(plotTitle, 'comparison_uniformity', outDir);
end

function plotComparison(results, fieldName, yLabelText, keepHold)
if nargin < 4
    keepHold = false;
end
for k = 1:numel(results)
    history = results(k).history;
    plot(history.t, history.(fieldName), 'DisplayName', sanitize_label(results(k).runName));
    hold on;
end
xlabel('t'); ylabel(yLabelText); grid on;
if ~keepHold
    legend('Location','best');
end
end

function label = sanitize_label(name)
label = strrep(name, '_', '\_');
end
