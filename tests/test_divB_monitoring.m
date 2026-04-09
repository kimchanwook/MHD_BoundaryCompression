function test_divB_monitoring()
repoRoot = fileparts(fileparts(mfilename('fullpath'))); addpath(genpath(repoRoot)); grid = build_grid(default_grid_params()); physics = default_physics_params(); U = initialize_uniform_state(grid, physics); metrics = compute_divB_metrics(U, grid); assert(metrics.maxAbsDivB < 1e-12); disp('test_divB_monitoring passed');
end
