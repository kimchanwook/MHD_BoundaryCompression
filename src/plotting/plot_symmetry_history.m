function figPath = plot_symmetry_history(history, runName, outDir)
figure('Name',[runName ' symmetry history']);
plot(history.t, history.symmetryPenalty, '-', 'DisplayName', 'combined'); hold on;
plot(history.t, history.symmetryLeftRight, '-', 'DisplayName', 'left-right');
plot(history.t, history.symmetryTopBottom, '-', 'DisplayName', 'top-bottom');
legend('Location','best'); xlabel('t'); ylabel('symmetry penalty'); grid on;
figPath = save_figure_if_requested(runName, 'symmetry_history', outDir);
end
