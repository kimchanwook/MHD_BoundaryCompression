function test_symmetric_drive_symmetry_preservation()
%TEST_SYMMETRIC_DRIVE_SYMMETRY_PRESERVATION Boundary velocities should be symmetric.
    caseData = case_baseline_symmetric();
    cfg = build_case_config(caseData);
    gridData = build_grid(cfg.grid);
    boundaryInfo = build_boundary_index_sets(gridData);
    state = initialize_uniform_state(gridData, cfg.physics, cfg.initial);
    driveModel = build_drive_model(cfg.drive);
    state = apply_boundary_conditions(state, gridData, boundaryInfo, driveModel, 0.15, cfg);
    lr = norm(state.primitive.vx(:,1) + state.primitive.vx(:,end));
    tb = norm(state.primitive.vy(1,:) + state.primitive.vy(end,:));
    assert(lr < 1e-12 && tb < 1e-12);
end
