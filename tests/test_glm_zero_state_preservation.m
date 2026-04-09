function test_glm_zero_state_preservation()
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(repoRoot));

grid = build_grid(default_grid_params());
physics = default_physics_params();
numerics = default_numerics_params();
U = initialize_uniform_state(grid, physics);

% A uniform, divergence-free field with zero psi should remain unchanged by the
% standalone GLM damping stage.
U2 = apply_divergence_cleaning(U, grid, numerics, physics);
err = max(abs(U2(:) - U(:)));
assert(err < 1e-12, 'Uniform zero-psi state changed under GLM cleaning.');
disp('test_glm_zero_state_preservation passed');
end
