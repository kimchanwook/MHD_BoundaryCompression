function caseConfig = case_asymmetric_timing_template()
caseConfig = case_baseline_symmetric();
caseConfig.runName = 'template_asymmetric_timing';
caseConfig.drive.parameters.sideTimeOffsets = struct('left',0.00,'right',0.02,'bottom',0.00,'top',0.02);
end
