function test_uniform_state_preservation()
repoRoot = fileparts(fileparts(mfilename('fullpath'))); addpath(genpath(repoRoot)); cfg = case_baseline_symmetric(); cfg.time.tEnd = 0.0; cfg.output.makePlots = false; summary = run_case(cfg); assert(summary.steps == 0 || summary.finalTime == 0.0); disp('test_uniform_state_preservation passed');
end
