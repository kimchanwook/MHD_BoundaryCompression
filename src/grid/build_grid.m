function gridData = build_grid(gridCfg)
%BUILD_GRID Build a uniform Cartesian grid with ghost cells.
    Nx = gridCfg.Nx;
    Ny = gridCfg.Ny;
    ng = gridCfg.ng;
    Lx = gridCfg.Lx;
    Ly = gridCfg.Ly;

    dx = Lx / (Nx - 1);
    dy = Ly / (Ny - 1);

    x = linspace(0, Lx, Nx);
    y = linspace(0, Ly, Ny);
    [X, Y] = meshgrid(x, y);

    gridData.Nx = Nx;
    gridData.Ny = Ny;
    gridData.ng = ng;
    gridData.Lx = Lx;
    gridData.Ly = Ly;
    gridData.dx = dx;
    gridData.dy = dy;
    gridData.x = x;
    gridData.y = y;
    gridData.X = X;
    gridData.Y = Y;
end
