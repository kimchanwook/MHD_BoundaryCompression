function figPath = plot_convergence_summary(resultsTable, runName, outDir)
figure('Name',[runName ' convergence']);
loglog(resultsTable.h, resultsTable.error_peakObjective, '-o', 'DisplayName', 'peak objective'); hold on;
loglog(resultsTable.h, resultsTable.error_peakRhoCompression, '-s', 'DisplayName', 'peak rho compression');
loglog(resultsTable.h, resultsTable.error_minRhoUniformity, '-^', 'DisplayName', 'min rho uniformity');
set(gca, 'XDir', 'reverse');
legend('Location','best'); xlabel('grid spacing h'); ylabel('absolute error vs finest'); grid on;
figPath = save_figure_if_requested(runName, 'convergence_summary', outDir);
end
