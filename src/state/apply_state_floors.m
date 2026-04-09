function U = apply_state_floors(U, physics, numerics)
prim = conservative_to_primitive(U, physics, numerics);
prim.rho = max(prim.rho, numerics.densityFloor);
prim.p = max(prim.p, numerics.pressureFloor);
prim.E = compute_total_energy(prim.rho, prim.vx, prim.vy, prim.vz, prim.p, prim.Bx, prim.By, prim.Bz, physics);
U = primitive_to_conservative(prim.rho, prim.vx, prim.vy, prim.vz, prim.Bx, prim.By, prim.Bz, prim.E, prim.psi);
end
