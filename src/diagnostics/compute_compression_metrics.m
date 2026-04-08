function metrics = compute_compression_metrics(state, gridData, physics, t)
%COMPUTE_COMPRESSION_METRICS Compute baseline scalar compression diagnostics.
    primitive = conservative_to_primitive(state, physics);
    core = get_core_mask(gridData);
    rhoCore = primitive.rho(core);
    BCore = sqrt(primitive.Bx(core).^2 + primitive.By(core).^2 + primitive.Bz(core).^2);
    vCore = sqrt(primitive.vx(core).^2 + primitive.vy(core).^2);

    metrics.t = t;
    metrics.meanRho = mean(rhoCore);
    metrics.meanB = mean(BCore);
    metrics.uniformityRho = std(rhoCore) / max(mean(rhoCore), eps);
    metrics.uniformityB = std(BCore) / max(mean(BCore), eps);
    metrics.coreSpeed = mean(vCore);
end

function mask = get_core_mask(gridData)
    x = gridData.X;
    y = gridData.Y;
    x1 = 0.25 * gridData.Lx;
    x2 = 0.75 * gridData.Lx;
    y1 = 0.25 * gridData.Ly;
    y2 = 0.75 * gridData.Ly;
    mask = (x >= x1) & (x <= x2) & (y >= y1) & (y <= y2);
end
