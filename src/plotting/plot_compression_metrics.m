function figPath = plot_compression_metrics(history, runName, outDir)
figure('Name',[runName ' compression metrics']);
plot(history.t, history.rhoUniformity, '-', 'DisplayName', 'rho uniformity'); hold on;
plot(history.t, history.BmagUniformity, '-', 'DisplayName', '|B| uniformity');
plot(history.t, history.objective, '-', 'DisplayName', 'objective');
legend('Location','best'); xlabel('t'); ylabel('metric'); grid on;
figPath = save_figure_if_requested(runName, 'compression_metrics', outDir);
end
