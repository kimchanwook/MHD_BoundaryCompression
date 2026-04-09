function U = initialize_uniform_state(grid, physics)
nxTot = grid.Nx + 2*grid.ng; nyTot = grid.Ny + 2*grid.ng;
rho = physics.rho0 * ones(nyTot, nxTot);
vx = physics.v0(1) * ones(nyTot, nxTot);
vy = physics.v0(2) * ones(nyTot, nxTot);
vz = physics.v0(3) * ones(nyTot, nxTot);
Bx = physics.B0(1) * ones(nyTot, nxTot);
By = physics.B0(2) * ones(nyTot, nxTot);
Bz = physics.B0(3) * ones(nyTot, nxTot);
psi = zeros(nyTot, nxTot);
E = compute_total_energy(rho, vx, vy, vz, physics.p0 * ones(nyTot, nxTot), Bx, By, Bz, physics);
U = primitive_to_conservative(rho, vx, vy, vz, Bx, By, Bz, E, psi);
end
