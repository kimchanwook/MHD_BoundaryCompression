function test_positive_pressure_density()
repoRoot = fileparts(fileparts(mfilename('fullpath'))); addpath(genpath(repoRoot)); grid = build_grid(default_grid_params()); physics = default_physics_params(); numerics = default_numerics_params(); U = initialize_uniform_state(grid, physics); U(:,:,1) = -1.0; U = apply_state_floors(U, physics, numerics); P = conservative_to_primitive(U, physics, numerics); assert(all(P.rho(:) > 0)); assert(all(P.p(:) > 0)); disp('test_positive_pressure_density passed');
end
