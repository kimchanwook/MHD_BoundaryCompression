function test_zero_drive_energy_stability()
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(repoRoot));
cfg = case_baseline_symmetric();
cfg.runName = 'test_zero_drive_energy';
cfg.drive.parameters.amplitude_fraction_fast = 0.0;
cfg.output.makePlots = false;
cfg.output.writeData = false;
cfg.time.tEnd = 0.05;
summary = run_case(cfg);
assert(abs(summary.totalEnergyDrift) < 1e-8);
assert(abs(summary.massDrift) < 1e-8);
disp('test_zero_drive_energy_stability passed');
end
