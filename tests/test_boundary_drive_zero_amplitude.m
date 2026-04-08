function test_boundary_drive_zero_amplitude()
%TEST_BOUNDARY_DRIVE_ZERO_AMPLITUDE Drive evaluation should return zero vn for zero amplitude.
    caseData = case_baseline_symmetric();
    caseData.drive.amplitude = 0.0;
    driveModel = build_drive_model(caseData.drive);
    gridData = build_grid(caseData.grid);
    boundaryInfo = build_boundary_index_sets(gridData);
    bcData = evaluate_drive(driveModel, boundaryInfo.left, 0.1, gridData, []);
    assert(all(abs(bcData.vn) < 1e-14));
end
