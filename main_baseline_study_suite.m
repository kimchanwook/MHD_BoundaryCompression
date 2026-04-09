function suite = main_baseline_study_suite()
%MAIN_BASELINE_STUDY_SUITE Run a curated, repeatable set of baseline studies.
% This is the first scientifically organized comparison suite for the
% boundary-compression project. The runs are chosen to isolate the effect
% of amplitude, pulse width, and a small symmetry-breaking timing offset.
clc;
repoRoot = fileparts(mfilename('fullpath'));
addpath(genpath(repoRoot));

cases = build_curated_baseline_suite_cases();
results = repmat(struct(), numel(cases), 1);

for k = 1:numel(cases)
    fprintf('\n============================================================\n');
    fprintf('Running curated study %d / %d : %s\n', k, numel(cases), cases{k}.runName);
    fprintf('Study label: %s\n', cases{k}.meta.studyLabel);
    fprintf('Study family: %s\n', cases{k}.meta.studyFamily);
    fprintf('============================================================\n');
    results(k) = run_case(cases{k}); %#ok<AGROW>
end

suite = postprocess_sweep_results(results, fullfile('outputs','baseline_suite_curated'), 'baseline_suite_curated');
exportCurated = export_curated_summary_table(suite.ranking, fullfile('outputs','baseline_suite_curated'), 'baseline_suite_curated');
figCurated = plot_curated_suite_overview(suite.ranking, 'baseline_suite_curated', fullfile('outputs','baseline_suite_curated'));

suite.curatedSummaryPaths = exportCurated;
suite.curatedFigurePaths = figCurated;

fprintf('\nCurated baseline suite complete. Best run: %s\n', suite.bestRunName);
fprintf('Curated summary CSV: %s\n', exportCurated.csvPath);
end
