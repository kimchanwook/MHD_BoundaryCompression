function suite = main_drive_parameter_sweep()
%MAIN_DRIVE_PARAMETER_SWEEP Sweep drive amplitude and pulse duration.
clc;
repoRoot = fileparts(mfilename('fullpath'));
addpath(genpath(repoRoot));

amplitudeFractions = [0.05, 0.10, 0.15, 0.20];
pulseStops = [0.12, 0.20, 0.28, 0.36];

results = struct([]);
idx = 0;
for ia = 1:numel(amplitudeFractions)
    for ip = 1:numel(pulseStops)
        idx = idx + 1;
        cfg = case_baseline_symmetric();
        cfg.runName = sprintf('amp_%0.3f_tstop_%0.3f', amplitudeFractions(ia), pulseStops(ip));
        cfg.drive.parameters.amplitude_fraction_fast = amplitudeFractions(ia);
        cfg.drive.parameters.tStop = pulseStops(ip);
        cfg.output.makePlots = false;
        cfg.output.verbose = false;
        cfg.meta.amplitude_fraction_fast = amplitudeFractions(ia);
        cfg.meta.tStop = pulseStops(ip);
        fprintf('Running sweep case %2d / %2d : %s\n', idx, numel(amplitudeFractions)*numel(pulseStops), cfg.runName);
        results(idx) = run_case(cfg); %#ok<AGROW>
    end
end

suite = postprocess_sweep_results(results, fullfile('outputs','parameter_sweep'), 'drive_parameter_sweep');
fprintf('\nSweep complete. Best run: %s\n', suite.bestRunName);
end
