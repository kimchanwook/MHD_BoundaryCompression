function ch = compute_glm_ch(U, grid, physics, numerics)
prim = conservative_to_primitive(U, physics, numerics);
cfX = compute_fast_speed(prim.rho, prim.p, prim.Bx, prim.By, prim.Bz, 'x', physics);
cfY = compute_fast_speed(prim.rho, prim.p, prim.Bx, prim.By, prim.Bz, 'y', physics);
maxCf = max([cfX(:); cfY(:); numerics.smallNumber]);
chScalar = numerics.glmChFactor * maxCf;
ch = chScalar * ones(size(prim.rho));
if nargin >= 2 %#ok<ISMAT>
    ch = max(ch, numerics.smallNumber * ones(size(prim.rho)));
end
end
