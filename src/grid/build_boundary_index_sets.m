function boundary = build_boundary_index_sets(grid)
ng = grid.ng; Nx = grid.Nx; Ny = grid.Ny; ix = grid.ix; iy = grid.iy;
boundary.left.ghost_i    = 1:ng;               boundary.left.interior_i = (ng+1):(2*ng);  boundary.left.j = iy;
boundary.right.ghost_i   = (Nx+ng+1):(Nx+2*ng); boundary.right.interior_i = (Nx+1):(Nx+ng); boundary.right.j = iy;
boundary.bottom.ghost_j  = 1:ng;              boundary.bottom.interior_j = (ng+1):(2*ng); boundary.bottom.i = ix;
boundary.top.ghost_j     = (Ny+ng+1):(Ny+2*ng); boundary.top.interior_j = (Ny+1):(Ny+ng); boundary.top.i = ix;
end
