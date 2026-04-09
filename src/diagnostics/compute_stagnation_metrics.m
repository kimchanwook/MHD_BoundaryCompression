function stag = compute_stagnation_metrics(U, grid, physics, numerics, diagnostics)
%COMPUTE_STAGNATION_METRICS Quantify whether the compressed core has slowed.
P = conservative_to_primitive(U, physics, numerics);
core = get_core_region_indices(grid, diagnostics);

vx = P.vx(core.j, core.i);
vy = P.vy(core.j, core.i);
vz = P.vz(core.j, core.i);
vmag = sqrt(vx.^2 + vy.^2 + vz.^2);

cf0 = compute_fast_speed(physics.rho0, physics.p0, physics.B0, physics.gamma, physics.mu0);

stag = struct();
stag.vCoreMean = mean(vmag(:));
stag.vCoreMax  = max(vmag(:));
stag.vCoreMeanNormalized = stag.vCoreMean / max(cf0, eps);
stag.vCoreMaxNormalized  = stag.vCoreMax / max(cf0, eps);
end
