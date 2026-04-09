function U = apply_ghost_cells(U, grid, physics, numerics, driveModel, t)
for sideCell = {'left','right','bottom','top'}, U = fill_boundary_from_drive_model(U, grid, physics, numerics, driveModel, t, sideCell{1}); end
U = handle_boundary_corners(U, grid);
end
