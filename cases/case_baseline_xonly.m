function caseConfig = case_baseline_xonly()
caseConfig = case_baseline_symmetric();
caseConfig.runName = 'baseline_xonly';
caseConfig.drive.parameters.boundaries = {'left','right'};
end
