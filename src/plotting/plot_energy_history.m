function figPath = plot_energy_history(history, runName, outDir)
figure('Name',[runName ' energy history']);
plot(history.t, history.totalEnergyTotal, '-', 'DisplayName', 'total'); hold on;
plot(history.t, history.kineticEnergyTotal, '-', 'DisplayName', 'kinetic');
plot(history.t, history.internalEnergyTotal, '-', 'DisplayName', 'internal');
plot(history.t, history.magneticEnergyTotal, '-', 'DisplayName', 'magnetic');
legend('Location','best'); xlabel('t'); ylabel('integrated energy'); grid on;
figPath = save_figure_if_requested(runName, 'energy_history', outDir);
end
