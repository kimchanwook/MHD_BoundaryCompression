function paths = export_run_tables(results, outDir, baseName)
%EXPORT_RUN_TABLES Export sweep summary tables to MAT and CSV.
if ~exist(outDir, 'dir')
    mkdir(outDir);
end

ranking = rank_parameter_sweep(results);
T = struct2table(strip_heavy_fields(ranking));
matPath = fullfile(outDir, [baseName '_summary.mat']);
csvPath = fullfile(outDir, [baseName '_summary.csv']);
save(matPath, 'results', 'ranking');
writetable(T, csvPath);

paths = struct('matPath', matPath, 'csvPath', csvPath);
end

function cleanResults = strip_heavy_fields(results)
cleanResults = results;
for k = 1:numel(cleanResults)
    if isfield(cleanResults(k), 'history')
        cleanResults(k) = rmfield(cleanResults(k), 'history');
    end
    if isfield(cleanResults(k), 'caseConfig')
        cleanResults(k) = rmfield(cleanResults(k), 'caseConfig');
    end
    if isfield(cleanResults(k), 'driveModel')
        cleanResults(k) = rmfield(cleanResults(k), 'driveModel');
    end
    if isfield(cleanResults(k), 'outputPaths')
        cleanResults(k) = rmfield(cleanResults(k), 'outputPaths');
    end
end
end
