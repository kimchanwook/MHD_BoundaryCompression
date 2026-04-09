function test_energy_component_bookkeeping()
repoRoot = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(repoRoot));
grid = build_grid(default_grid_params());
physics = default_physics_params();
numerics = default_numerics_params();
U = initialize_uniform_state(grid, physics);
energy = compute_energy_components(U, grid, physics, numerics);
assert(isfinite(energy.total) && energy.total > 0.0);
assert(abs(energy.total - (energy.kinetic + energy.internal + energy.magnetic)) < 1e-10 * max(energy.total, 1.0));
disp('test_energy_component_bookkeeping passed');
end
