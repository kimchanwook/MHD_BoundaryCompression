function U = apply_boundary_conditions(U, grid, physics, numerics, driveModel, t)
U = apply_ghost_cells(U, grid, physics, numerics, driveModel, t);
end
