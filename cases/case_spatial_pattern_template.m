function caseData = case_spatial_pattern_template()
%CASE_SPATIAL_PATTERN_TEMPLATE Template for future nonuniform edge forcing.
    caseData = case_baseline_symmetric();
    caseData.name = 'template_spatial_pattern';
    caseData.drive.spatial_profile = 'cosine_taper';
    caseData.drive.spatial_parameters.power = 1;
end
