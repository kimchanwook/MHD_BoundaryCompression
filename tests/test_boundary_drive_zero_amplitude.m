function test_boundary_drive_zero_amplitude()
repoRoot = fileparts(fileparts(mfilename('fullpath'))); addpath(genpath(repoRoot)); cfg = case_baseline_symmetric(); cfg.drive.parameters.amplitude_fraction_fast = 0.0; cfg.time.tEnd = 0.05; cfg.output.makePlots = false; summary = run_case(cfg); assert(isfinite(summary.finalObjective)); disp('test_boundary_drive_zero_amplitude passed');
end
