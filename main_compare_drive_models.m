function suite = main_compare_drive_models()
%MAIN_COMPARE_DRIVE_MODELS Compare a few prescribed-velocity drive variants.
clc;
repoRoot = fileparts(mfilename('fullpath'));
addpath(genpath(repoRoot));

cases = {};

cfg = case_baseline_symmetric();
cfg.runName = 'compare_uniform_single_pulse';
cfg.output.makePlots = false;
cases{end+1} = cfg;

cfg = case_baseline_symmetric();
cfg.runName = 'compare_cosine_taper_single_pulse';
cfg.drive.parameters.spatial_profile = 'cosine_taper';
cfg.output.makePlots = false;
cases{end+1} = cfg;

cfg = case_baseline_symmetric();
cfg.runName = 'compare_uniform_pulse_train';
cfg.drive.parameters.temporal_profile = 'pulse_train';
cfg.drive.parameters.pulseCount = 3;
cfg.drive.parameters.pulseSpacing = 0.07;
cfg.drive.parameters.pulseWidth = 0.04;
cfg.drive.parameters.tStop = 0.24;
cfg.output.makePlots = false;
cases{end+1} = cfg;

cfg = case_baseline_symmetric();
cfg.runName = 'compare_small_left_right_delay';
cfg.drive.parameters.sideTimeOffsets.left = 0.00;
cfg.drive.parameters.sideTimeOffsets.right = 0.01;
cfg.drive.parameters.sideTimeOffsets.bottom = 0.00;
cfg.drive.parameters.sideTimeOffsets.top = 0.01;
cfg.output.makePlots = false;
cases{end+1} = cfg;

results = repmat(struct(), numel(cases), 1);
for k = 1:numel(cases)
    fprintf('Running comparison case %d / %d : %s\n', k, numel(cases), cases{k}.runName);
    results(k) = run_case(cases{k}); %#ok<AGROW>
end

suite = postprocess_sweep_results(results, fullfile('outputs','drive_comparison'), 'drive_comparison');
end
