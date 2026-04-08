function state = apply_boundary_conditions(state, gridData, boundaryInfo, driveModel, t, cfg)
%APPLY_BOUNDARY_CONDITIONS Apply the selected drive model to the boundaries.
    state = apply_ghost_cells(state, gridData, boundaryInfo, driveModel, t, cfg.physics);
    state = handle_boundary_corners(state);
end
