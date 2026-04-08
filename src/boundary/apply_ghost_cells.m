function state = apply_ghost_cells(state, gridData, boundaryInfo, driveModel, t, physics)
%APPLY_GHOST_CELLS Placeholder for ghost-cell fill strategy.
% Current skeleton does not allocate explicit ghost cells yet. Instead, this
% function updates boundary-adjacent primitive values directly so that the
% drive interface and workflow can already be exercised.
    state = fill_boundary_from_drive_model(state, gridData, boundaryInfo, driveModel, t, physics);
end
