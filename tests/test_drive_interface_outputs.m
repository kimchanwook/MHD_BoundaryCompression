function test_drive_interface_outputs()
%TEST_DRIVE_INTERFACE_OUTPUTS Drive interface must return expected fields.
    caseData = case_baseline_symmetric();
    driveModel = build_drive_model(caseData.drive);
    gridData = build_grid(caseData.grid);
    boundaryInfo = build_boundary_index_sets(gridData);
    bcData = evaluate_drive(driveModel, boundaryInfo.left, 0.1, gridData, []);
    required = {'active','mode','vn','vt','p','Bn','Bt'};
    for k = 1:numel(required)
        assert(isfield(bcData, required{k}));
    end
end
