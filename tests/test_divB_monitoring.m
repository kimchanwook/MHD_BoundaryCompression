function test_divB_monitoring()
%TEST_DIVB_MONITORING Uniform magnetic field should have near-zero div B.
    caseData = case_baseline_symmetric();
    cfg = build_case_config(caseData);
    gridData = build_grid(cfg.grid);
    state = initialize_uniform_state(gridData, cfg.physics, cfg.initial);
    divB = compute_divB_metrics(state, gridData);
    assert(divB.maxAbs < 1e-12);
end
