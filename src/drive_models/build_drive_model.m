function driveModel = build_drive_model(driveCfg)
%BUILD_DRIVE_MODEL Construct a drive-model struct with evaluation handles.
    driveModel.name = driveCfg.name;
    driveModel.type = driveCfg.type;
    driveModel.parameters = driveCfg;
    driveModel.temporalProfile = driveCfg.temporal_profile;
    driveModel.spatialProfile = driveCfg.spatial_profile;
    driveModel.boundaries = driveCfg.boundaries;

    switch driveCfg.type
        case 'prescribed_velocity'
            driveModel.evaluate = @drive_prescribed_inward_velocity;
        otherwise
            error('Unsupported drive model type: %s', driveCfg.type);
    end
end
