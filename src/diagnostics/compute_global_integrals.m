function ints = compute_global_integrals(U, grid)
ix = grid.ix; iy = grid.iy; V = grid.dx * grid.dy; ints.mass = sum(sum(U(iy,ix,1))) * V; ints.energy = sum(sum(U(iy,ix,8))) * V;
end
