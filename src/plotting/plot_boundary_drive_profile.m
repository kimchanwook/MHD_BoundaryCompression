function figPath = plot_boundary_drive_profile(driveModel, timeParams, runName, outDir)
t = linspace(0, timeParams.tEnd, 300);
a = zeros(size(t));
for i = 1:numel(t)
    a(i) = evaluate_temporal_profile(driveModel.parameters, 'left', t(i));
end
figure('Name',[runName ' drive profile']);
plot(t, a, '-'); xlabel('t'); ylabel('normalized drive amplitude'); grid on;
title([runName ' temporal drive profile']);
figPath = save_figure_if_requested(runName, 'drive_profile', outDir);
end
