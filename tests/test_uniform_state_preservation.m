function test_uniform_state_preservation()
%TEST_UNIFORM_STATE_PRESERVATION Zero-amplitude drive should preserve uniform interior state.
    caseData = case_baseline_symmetric();
    caseData.drive.amplitude = 0.0;
    cfg = build_case_config(caseData);
    gridData = build_grid(cfg.grid);
    boundaryInfo = build_boundary_index_sets(gridData);
    state0 = initialize_uniform_state(gridData, cfg.physics, cfg.initial);
    driveModel = build_drive_model(cfg.drive);
    [~, snapshots] = advance_mhd_rk2(state0, gridData, boundaryInfo, cfg, driveModel);
    assert(max(abs(snapshots.final.primitive.rho(:) - cfg.initial.rho0)) < 1e-12);
end
