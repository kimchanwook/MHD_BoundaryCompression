function metrics = compute_compression_metrics(U, grid, physics, numerics, diagnostics)
%COMPUTE_COMPRESSION_METRICS Compute core-region compression metrics.
P = conservative_to_primitive(U, physics, numerics);
core = get_core_region_indices(grid, diagnostics);

rho  = P.rho(core.j, core.i);
p    = P.p(core.j, core.i);
Bmag = sqrt(P.Bx(core.j, core.i).^2 + P.By(core.j, core.i).^2 + P.Bz(core.j, core.i).^2);
vmag = sqrt(P.vx(core.j, core.i).^2 + P.vy(core.j, core.i).^2 + P.vz(core.j, core.i).^2);

rhoMean = mean(rho(:));
pMean   = mean(p(:));
BmagMean = mean(Bmag(:));
vmagMean = mean(vmag(:));

metrics = struct();
metrics.coreFraction = core.coreFraction;

metrics.rhoCoreMean = rhoMean;
metrics.pCoreMean = pMean;
metrics.BmagCoreMean = BmagMean;
metrics.vCoreMean = vmagMean;

metrics.rhoCompressionRatio = rhoMean / max(physics.rho0, eps);
metrics.pCompressionRatio   = pMean   / max(physics.p0, eps);
metrics.BCompressionRatio   = BmagMean / max(norm(physics.B0), eps);

metrics.rhoUniformity = std(rho(:)) / max(rhoMean, eps);
metrics.pUniformity   = std(p(:))   / max(pMean, eps);
metrics.BmagUniformity = std(Bmag(:)) / max(BmagMean, eps);

% Stagnation quality: smaller residual core speed is better.
metrics.stagnationPenalty = vmagMean / max(compute_fast_speed(physics.rho0, physics.p0, physics.B0, physics.gamma, physics.mu0), eps);
end
