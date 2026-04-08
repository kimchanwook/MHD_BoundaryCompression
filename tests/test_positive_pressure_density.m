function test_positive_pressure_density()
%TEST_POSITIVE_PRESSURE_DENSITY Floors should eliminate negative rho and p.
    caseData = case_baseline_symmetric();
    cfg = build_case_config(caseData);
    gridData = build_grid(cfg.grid);
    state = initialize_uniform_state(gridData, cfg.physics, cfg.initial);
    state.U.rho(1,1) = -1;
    state.U.E(1,1) = -1;
    state = apply_state_floors(state, cfg.physics, cfg.numerics);
    assert(all(state.primitive.rho(:) > 0));
    assert(all(state.primitive.p(:) > 0));
end
