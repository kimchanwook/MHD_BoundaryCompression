function dt = compute_dt_cfl(U, grid, physics, numerics, cfl)
prim = conservative_to_primitive(U, physics, numerics);
cfX = compute_fast_speed(prim.rho, prim.p, prim.Bx, prim.By, prim.Bz, 'x', physics);
cfY = compute_fast_speed(prim.rho, prim.p, prim.Bx, prim.By, prim.Bz, 'y', physics);
lamX = abs(prim.vx) + cfX;
lamY = abs(prim.vy) + cfY;

if strcmpi(numerics.divergenceControl, 'glm')
    ch = compute_glm_ch(U, grid, physics, numerics);
    lamX = max(lamX, ch);
    lamY = max(lamY, ch);
end

maxLam = max([lamX(:); lamY(:); numerics.smallNumber]);
dt = cfl * min(grid.dx, grid.dy) / maxLam;
end
