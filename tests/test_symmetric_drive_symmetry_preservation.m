function test_symmetric_drive_symmetry_preservation()
repoRoot = fileparts(fileparts(mfilename('fullpath'))); addpath(genpath(repoRoot)); grid = build_grid(default_grid_params()); U = initialize_uniform_state(grid, default_physics_params()); sym = compute_symmetry_metrics(U(grid.iy,grid.ix,1)); assert(sym.leftRight < 1e-12 && sym.topBottom < 1e-12); disp('test_symmetric_drive_symmetry_preservation passed');
end
