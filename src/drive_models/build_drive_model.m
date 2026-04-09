function driveModel = build_drive_model(driveConfig, grid, physics)
driveModel = struct(); driveModel.type = driveConfig.type; driveModel.parameters = driveConfig.parameters; driveModel.grid = grid; driveModel.physics = physics;
a = driveConfig.parameters.amplitude_fraction_fast; cf0 = compute_fast_speed(physics.rho0, physics.p0, physics.B0(1), physics.B0(2), physics.B0(3), 'x', physics); driveModel.parameters.amplitude = a * cf0;
driveModel.evaluate = @(boundaryName, s, t, interiorPrim) evaluate_drive(driveModel, boundaryName, s, t, interiorPrim);
end
