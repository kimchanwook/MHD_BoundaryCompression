function figPath = plot_time_history(history, runName, outDir)
figure('Name',[runName ' time history']);
plot(history.t, history.rhoCoreMean, '-', 'DisplayName', '<rho>_{core}'); hold on;
plot(history.t, history.BmagCoreMean, '-', 'DisplayName', '<|B|>_{core}');
plot(history.t, history.vCoreMean, '-', 'DisplayName', '<|v|>_{core}');
legend('Location','best'); xlabel('t'); ylabel('metric'); grid on;
figPath = save_figure_if_requested(runName, 'time_history', outDir);
end
