function caseConfig = build_case_config()
caseConfig = struct();
caseConfig.runName = 'unnamed_case';
caseConfig.grid    = default_grid_params();
caseConfig.physics = default_physics_params();
caseConfig.time    = default_time_params();
caseConfig.numerics = default_numerics_params();
caseConfig.output  = default_output_params();
caseConfig.diagnostics = default_diagnostics_params();
caseConfig.drive   = struct('type','prescribed_velocity','parameters',struct());
end
