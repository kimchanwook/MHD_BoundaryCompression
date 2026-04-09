function cases = build_curated_baseline_suite_cases()
%BUILD_CURATED_BASELINE_SUITE_CASES Assemble a small named baseline suite.
% The suite is intentionally small and physically interpretable.

cases = {};

cases{end+1} = make_case('weak_symmetric_pulse', ...
    'Weak symmetric pulse', 'symmetric_amplitude_scan', ...
    0.05, 0.20, struct('left',0.0,'right',0.0,'bottom',0.0,'top',0.0));

cases{end+1} = make_case('moderate_symmetric_pulse', ...
    'Moderate symmetric pulse', 'symmetric_amplitude_scan', ...
    0.10, 0.20, struct('left',0.0,'right',0.0,'bottom',0.0,'top',0.0));

cases{end+1} = make_case('strong_symmetric_pulse', ...
    'Strong symmetric pulse', 'symmetric_amplitude_scan', ...
    0.15, 0.20, struct('left',0.0,'right',0.0,'bottom',0.0,'top',0.0));

cases{end+1} = make_case('shorter_symmetric_pulse', ...
    'Shorter symmetric pulse', 'symmetric_pulse_width_scan', ...
    0.10, 0.14, struct('left',0.0,'right',0.0,'bottom',0.0,'top',0.0));

cases{end+1} = make_case('longer_symmetric_pulse', ...
    'Longer symmetric pulse', 'symmetric_pulse_width_scan', ...
    0.10, 0.28, struct('left',0.0,'right',0.0,'bottom',0.0,'top',0.0));

cases{end+1} = make_case('asymmetric_timing_perturbation', ...
    'Asymmetric timing perturbation', 'symmetry_breaking_probe', ...
    0.10, 0.20, struct('left',0.0,'right',0.015,'bottom',0.0,'top',0.015));
end

function cfg = make_case(runName, studyLabel, studyFamily, ampFrac, tStop, sideOffsets)
cfg = case_baseline_symmetric();
cfg.runName = runName;
cfg.output.makePlots = false;
cfg.output.writeData = true;
cfg.output.baseDir = fullfile('outputs', 'baseline_suite_curated', runName);
cfg.drive.parameters.amplitude_fraction_fast = ampFrac;
cfg.drive.parameters.tStop = tStop;
cfg.drive.parameters.sideTimeOffsets = sideOffsets;
cfg.meta = struct();
cfg.meta.studyLabel = studyLabel;
cfg.meta.studyFamily = studyFamily;
cfg.meta.amplitude_fraction_fast = ampFrac;
cfg.meta.pulse_tStop = tStop;
cfg.meta.sideTimeOffsets = sideOffsets;
end
