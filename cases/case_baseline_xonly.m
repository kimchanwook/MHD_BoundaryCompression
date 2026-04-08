function caseData = case_baseline_xonly()
%CASE_BASELINE_XONLY Template case for left-right compression only.
    caseData = case_baseline_symmetric();
    caseData.name = 'baseline_xonly';
    caseData.description = 'Left-right inward compression only.';
    caseData.drive.boundaries = {'left','right'};
end
