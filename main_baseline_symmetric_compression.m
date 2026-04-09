function summary = main_baseline_symmetric_compression()
clc;
repoRoot = fileparts(mfilename('fullpath'));
addpath(genpath(repoRoot));
caseConfig = case_baseline_symmetric();
summary = run_case(caseConfig);
disp('Run completed. Key summary fields:');
disp(summary);
end
