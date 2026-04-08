function state = fill_boundary_from_drive_model(state, gridData, boundaryInfo, driveModel, t, physics)
%FILL_BOUNDARY_FROM_DRIVE_MODEL Apply one drive model to all active boundaries.
    sides = fieldnames(boundaryInfo);
    for iSide = 1:numel(sides)
        sideName = sides{iSide};
        bcData = evaluate_drive(driveModel, boundaryInfo.(sideName), t, gridData, state);
        if ~bcData.active
            continue;
        end
        state = impose_velocity_boundary(state, sideName, bcData.vn, bcData.vt, physics);
    end
end
