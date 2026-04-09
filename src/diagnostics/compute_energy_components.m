function energy = compute_energy_components(U, grid, physics, numerics)
%COMPUTE_ENERGY_COMPONENTS Integrated energy bookkeeping over the active cells.
P = conservative_to_primitive(U, physics, numerics);
ix = grid.ix; iy = grid.iy;
cellArea = grid.dx * grid.dy;

rho = P.rho(iy, ix);
vx = P.vx(iy, ix); vy = P.vy(iy, ix); vz = P.vz(iy, ix);
p  = P.p(iy, ix);
Bx = P.Bx(iy, ix); By = P.By(iy, ix); Bz = P.Bz(iy, ix);
E  = P.E(iy, ix);

kin = 0.5 * rho .* (vx.^2 + vy.^2 + vz.^2);
internal = p / (physics.gamma - 1);
mag = 0.5 / physics.mu0 * (Bx.^2 + By.^2 + Bz.^2);

energy = struct();
energy.cellArea = cellArea;
energy.mass = sum(rho(:)) * cellArea;
energy.momentumX = sum((rho .* vx), 'all') * cellArea;
energy.momentumY = sum((rho .* vy), 'all') * cellArea;
energy.momentumZ = sum((rho .* vz), 'all') * cellArea;
energy.kinetic = sum(kin(:)) * cellArea;
energy.internal = sum(internal(:)) * cellArea;
energy.magnetic = sum(mag(:)) * cellArea;
energy.total = sum(E(:)) * cellArea;
end
