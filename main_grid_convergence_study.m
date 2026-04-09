function convergence = main_grid_convergence_study()
repoRoot = fileparts(mfilename('fullpath'));
addpath(genpath(repoRoot));

cfg = case_baseline_symmetric();
cfg.runName = 'verification_baseline_symmetric';
cfg.output.makePlots = true;
cfg.output.writeData = true;
resolutionList = [40, 80, 120];

convergence = run_grid_convergence_study(cfg, resolutionList);
plot_convergence_summary(convergence.resultsTable, cfg.runName, fullfile(cfg.output.baseDir, 'figures'));
export_verification_summary_table(convergence, fullfile(cfg.output.baseDir, 'data'));
disp(convergence.resultsTable);
if ~isempty(convergence.estimatedOrders)
    disp(convergence.estimatedOrders);
end
end
