function caseData = case_asymmetric_timing_template()
%CASE_ASYMMETRIC_TIMING_TEMPLATE Template for future asymmetric timing studies.
    caseData = case_baseline_symmetric();
    caseData.name = 'template_asymmetric_timing';
    caseData.drive.side_time_offsets.left = 0.00;
    caseData.drive.side_time_offsets.right = 0.02;
    caseData.drive.side_time_offsets.bottom = 0.00;
    caseData.drive.side_time_offsets.top = 0.03;
end
