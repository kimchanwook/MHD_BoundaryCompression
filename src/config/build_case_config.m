function cfg = build_case_config(caseData)
%BUILD_CASE_CONFIG Assemble a single configuration struct from a case definition.
    cfg.caseName = caseData.name;
    cfg.description = caseData.description;
    cfg.grid = caseData.grid;
    cfg.physics = default_physics_params(caseData.physics);
    cfg.initial = caseData.initial;
    cfg.drive = caseData.drive;
    cfg.numerics = default_numerics_params(caseData.numerics);
    cfg.output = default_output_params(caseData.output, caseData.name);
end
