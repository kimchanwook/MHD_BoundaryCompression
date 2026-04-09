function verification = main_verification_suite()
repoRoot = fileparts(mfilename('fullpath'));
addpath(genpath(repoRoot));

verification = struct();
verification.tests = { ...
    'test_uniform_state_preservation', ...
    'test_boundary_drive_zero_amplitude', ...
    'test_symmetric_drive_symmetry_preservation', ...
    'test_energy_component_bookkeeping', ...
    'test_zero_drive_energy_stability'};

for k = 1:numel(verification.tests)
    feval(verification.tests{k});
end

verification.convergence = main_grid_convergence_study();
end
