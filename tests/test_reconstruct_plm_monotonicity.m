function test_reconstruct_plm_monotonicity()
cfg = case_baseline_symmetric();
cfg.grid.Nx = 16;
cfg.grid.Ny = 8;
grid = build_grid(cfg.grid);

U = initialize_uniform_state(grid, cfg.physics);
U(:,:,1) = U(:,:,1) + 0.1 * repmat(linspace(0,1,size(U,2)), size(U,1), 1);

[UL, UR] = reconstruct_plm(U, 'x', cfg.physics, cfg.numerics);
pL = conservative_to_primitive(UL, cfg.physics, cfg.numerics);
pR = conservative_to_primitive(UR, cfg.physics, cfg.numerics);

assert(all(isfinite(pL.rho(:))));
assert(all(isfinite(pR.rho(:))));
assert(min(pL.rho(:)) > 0);
assert(min(pR.rho(:)) > 0);
disp('test_reconstruct_plm_monotonicity passed');
end
