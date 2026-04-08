function caseData = case_pulse_train_template()
%CASE_PULSE_TRAIN_TEMPLATE Template for future repeated-drive studies.
    caseData = case_baseline_symmetric();
    caseData.name = 'template_pulse_train';
    caseData.drive.temporal_profile = 'pulse_train';
    caseData.drive.temporal_parameters.period = 0.20;
    caseData.drive.temporal_parameters.pulse_width = 0.05;
    caseData.drive.temporal_parameters.nPulses = 4;
end
