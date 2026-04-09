function summary = run_case(caseConfig)
validate_config(caseConfig);
ensure_output_dirs(caseConfig);
grid = build_grid(caseConfig.grid);
driveModel = build_drive_model(caseConfig.drive, grid, caseConfig.physics);
U0 = initialize_uniform_state(grid, caseConfig.physics);
result = advance_mhd_rk2(U0, grid, caseConfig.physics, caseConfig.numerics, caseConfig.time, driveModel, caseConfig.output, caseConfig.diagnostics);
summary = summarize_run(result, caseConfig, grid, caseConfig.physics);
summary.history = result.history;
summary.caseConfig = caseConfig;
summary.driveModel = driveModel;
summary.outputPaths = save_run_outputs(summary, result, caseConfig, grid, driveModel);
if caseConfig.output.makePlots
    plot_state_2d(grid, result.U, caseConfig.physics, caseConfig.runName, summary.outputPaths.figuresDir);
    plot_time_history(result.history, caseConfig.runName, summary.outputPaths.figuresDir);
    plot_compression_metrics(result.history, caseConfig.runName, summary.outputPaths.figuresDir);
    plot_boundary_drive_profile(driveModel, caseConfig.time, caseConfig.runName, summary.outputPaths.figuresDir);
    plot_energy_history(result.history, caseConfig.runName, summary.outputPaths.figuresDir);
    plot_symmetry_history(result.history, caseConfig.runName, summary.outputPaths.figuresDir);
end
end
