function outputPaths = save_run_outputs(summary, result, caseConfig, grid, driveModel)
%SAVE_RUN_OUTPUTS Save per-run numeric outputs.
baseDir = caseConfig.output.baseDir;
dataDir = fullfile(baseDir, 'data');
figuresDir = fullfile(baseDir, 'figures');
logsDir = fullfile(baseDir, 'logs');
runMatPath = fullfile(dataDir, [caseConfig.runName '_run.mat']);
runTxtPath = fullfile(logsDir, [caseConfig.runName '_summary.txt']);

outputPaths = struct('runMatPath', runMatPath, 'runTxtPath', runTxtPath, ...
    'dataDir', dataDir, 'figuresDir', figuresDir, 'logsDir', logsDir);

if isfield(caseConfig.output, 'writeData') && caseConfig.output.writeData
    save(runMatPath, 'summary', 'result', 'caseConfig', 'grid', 'driveModel');
end

fid = fopen(runTxtPath, 'w');
if fid ~= -1
    fprintf(fid, 'Run name: %s
', summary.runName);
    fprintf(fid, 'Grid: %s
', summary.grid);
    fprintf(fid, 'Final time: %.6f
', summary.finalTime);
    fprintf(fid, 'Steps: %d
', summary.steps);
    fprintf(fid, 'Peak objective: %.8f
', summary.peakObjective);
    fprintf(fid, 'Final objective: %.8f
', summary.finalObjective);
    fprintf(fid, 'Peak <rho>_core: %.8f
', summary.peakRhoCoreMean);
    fprintf(fid, 'Peak <|B|>_core: %.8f
', summary.peakBmagCoreMean);
    fprintf(fid, 'Min rho uniformity: %.8f
', summary.minRhoUniformity);
    fprintf(fid, 'Min |B| uniformity: %.8f
', summary.minBmagUniformity);
    fprintf(fid, 'Mass drift: %.8e
', summary.massDrift);
    fprintf(fid, 'Total energy drift: %.8e
', summary.totalEnergyDrift);
    fprintf(fid, 'Max symmetry L-R: %.8e
', summary.maxSymmetryLeftRight);
    fprintf(fid, 'Max symmetry T-B: %.8e
', summary.maxSymmetryTopBottom);
    fprintf(fid, 'Max |divB|: %.8e
', summary.maxDivBMax);
    fprintf(fid, 'Max rms(divB): %.8e
', summary.maxDivBRms);
    fclose(fid);
end
end
