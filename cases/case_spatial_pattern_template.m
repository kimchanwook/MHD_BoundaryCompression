function caseConfig = case_spatial_pattern_template()
caseConfig = case_baseline_symmetric();
caseConfig.runName = 'template_spatial_pattern';
caseConfig.drive.parameters.spatial_profile = 'cosine_taper';
end
