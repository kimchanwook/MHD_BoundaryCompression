function rhs = compute_rhs_mhd(U, grid, physics, numerics, ~, ~)
Fx = hll_flux_x(U, physics, numerics); Fy = hll_flux_y(U, physics, numerics); rhs = zeros(size(U)); ix = grid.ix; iy = grid.iy; rhs(iy,ix,:) = rhs(iy,ix,:) - (Fx(iy, ix+1, :) - Fx(iy, ix, :)) / grid.dx - (Fy(iy+1, ix, :) - Fy(iy, ix, :)) / grid.dy;
end
