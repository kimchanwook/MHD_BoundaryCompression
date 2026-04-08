function main_baseline_symmetric_compression()
%MAIN_BASELINE_SYMMETRIC_COMPRESSION Run the first baseline boundary-compression case.
%
% This top-level script mirrors the staged workflow style used in the user's
% earlier MHD project, but here the focus is boundary-driven compression on a
% fixed Eulerian grid. The present version is an architectural skeleton:
% - configuration and case setup are real,
% - the drive-model interface is real,
% - diagnostics and plotting hooks are real,
% - the full conservative MHD update is still a placeholder for the next step.

    projectRoot = fileparts(mfilename('fullpath'));
    addpath(genpath(projectRoot));

    caseData = case_baseline_symmetric();
    cfg = build_case_config(caseData);
    validate_config(cfg);
    ensure_output_dirs(cfg.output);

    gridData = build_grid(cfg.grid);
    boundaryInfo = build_boundary_index_sets(gridData);
    state = initialize_uniform_state(gridData, cfg.physics, cfg.initial);
    driveModel = build_drive_model(cfg.drive);

    [history, snapshots] = advance_mhd_rk2(state, gridData, boundaryInfo, cfg, driveModel);

    summary = summarize_run(history, cfg);
    disp(summary.message);

    plot_boundary_drive_profile(gridData, boundaryInfo, driveModel, cfg);
    plot_time_history(history, cfg);
    plot_state_2d(snapshots.final, gridData, 'rho', cfg);
end
