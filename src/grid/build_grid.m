function grid = build_grid(gridParams)
Nx = gridParams.Nx; Ny = gridParams.Ny; ng = gridParams.ng; Lx = gridParams.Lx; Ly = gridParams.Ly;
dx = Lx / Nx; dy = Ly / Ny;
x = ((1-ng):(Nx+ng) - 0.5) * dx; y = ((1-ng):(Ny+ng) - 0.5) * dy;
[X,Y] = meshgrid(x,y); ix = (ng+1):(ng+Nx); iy = (ng+1):(ng+Ny);
grid = struct();
grid.Nx = Nx; grid.Ny = Ny; grid.ng = ng; grid.Lx = Lx; grid.Ly = Ly; grid.dx = dx; grid.dy = dy;
grid.x = x; grid.y = y; grid.X = X; grid.Y = Y; grid.ix = ix; grid.iy = iy; grid.interior = struct('ix',ix,'iy',iy);
grid.boundary = build_boundary_index_sets(grid);
end
