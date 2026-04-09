function metrics = compute_all_diagnostics(U, grid, physics, numerics, diagnostics)
%COMPUTE_ALL_DIAGNOSTICS Gather compression, symmetry, stagnation, divB, and energy metrics.
metrics = compute_compression_metrics(U, grid, physics, numerics, diagnostics);

P = conservative_to_primitive(U, physics, numerics);
core = get_core_region_indices(grid, diagnostics);

rhoCore = P.rho(core.j, core.i);
BmagCore = sqrt(P.Bx(core.j, core.i).^2 + P.By(core.j, core.i).^2 + P.Bz(core.j, core.i).^2);
pCore = P.p(core.j, core.i);

symRho = compute_symmetry_metrics(rhoCore);
symB   = compute_symmetry_metrics(BmagCore);
symP   = compute_symmetry_metrics(pCore);
stag   = compute_stagnation_metrics(U, grid, physics, numerics, diagnostics);
divB   = compute_divB_metrics(U, grid);
energy = compute_energy_components(U, grid, physics, numerics);

metrics.symmetryRho = symRho.meanPenalty;
metrics.symmetryB   = symB.meanPenalty;
metrics.symmetryP   = symP.meanPenalty;
metrics.symmetryPenalty = mean([metrics.symmetryRho, metrics.symmetryB, metrics.symmetryP]);
metrics.symmetryLeftRight = mean([symRho.leftRight, symB.leftRight, symP.leftRight]);
metrics.symmetryTopBottom = mean([symRho.topBottom, symB.topBottom, symP.topBottom]);
metrics.symmetryDiagMain  = mean([symRho.diagMain, symB.diagMain, symP.diagMain]);
metrics.symmetryDiagAnti  = mean([symRho.diagAnti, symB.diagAnti, symP.diagAnti]);

metrics.vCoreMean = stag.vCoreMean;
metrics.vCoreMax = stag.vCoreMax;
metrics.stagnationPenalty = stag.vCoreMeanNormalized;

metrics.divBMax = divB.maxAbsDivB;
metrics.divBRms = divB.rmsDivB;

metrics.massTotal = energy.mass;
metrics.momentumXTotal = energy.momentumX;
metrics.momentumYTotal = energy.momentumY;
metrics.momentumZTotal = energy.momentumZ;
metrics.kineticEnergyTotal = energy.kinetic;
metrics.internalEnergyTotal = energy.internal;
metrics.magneticEnergyTotal = energy.magnetic;
metrics.totalEnergyTotal = energy.total;
end
