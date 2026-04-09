function bcData = evaluate_drive(driveModel, boundaryName, s, t, interiorPrim)
switch lower(driveModel.type)
    case 'prescribed_velocity'
        bcData = drive_prescribed_inward_velocity(driveModel, boundaryName, s, t, interiorPrim);
    otherwise
        error('Unsupported drive model type: %s', driveModel.type);
end
end
