function caseConfig = case_pulse_train_template()
caseConfig = case_baseline_symmetric();
caseConfig.runName = 'template_pulse_train';
caseConfig.drive.parameters.temporal_profile = 'pulse_train';
caseConfig.drive.parameters.pulse_count = 3;
caseConfig.drive.parameters.pulse_period = 0.08;
caseConfig.drive.parameters.pulse_width  = 0.03;
end
