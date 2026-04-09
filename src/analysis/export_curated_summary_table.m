function paths = export_curated_summary_table(ranking, outDir, baseName)
%EXPORT_CURATED_SUMMARY_TABLE Export a compact scientific summary table.
if ~exist(outDir, 'dir')
    mkdir(outDir);
end

n = numel(ranking);
runName = cell(n,1);
studyLabel = cell(n,1);
studyFamily = cell(n,1);
amplitudeFractionFast = nan(n,1);
pulseTStop = nan(n,1);
leftOffset = nan(n,1);
rightOffset = nan(n,1);
bottomOffset = nan(n,1);
topOffset = nan(n,1);
peakObjective = nan(n,1);
finalObjective = nan(n,1);
timeAveragedObjective = nan(n,1);
peakRhoCompression = nan(n,1);
peakPressureCompression = nan(n,1);
peakBCompression = nan(n,1);
bestRhoUniformity = nan(n,1);
bestPressureUniformity = nan(n,1);
bestBUniformity = nan(n,1);
finalSymmetryPenalty = nan(n,1);
bestSymmetryPenalty = nan(n,1);
finalStagnationPenalty = nan(n,1);
bestStagnationPenalty = nan(n,1);
maxDivBRms = nan(n,1);
bestTime = nan(n,1);

for k = 1:n
    r = ranking(k);
    runName{k} = r.runName;
    if isfield(r, 'meta')
        if isfield(r.meta, 'studyLabel'), studyLabel{k} = r.meta.studyLabel; end
        if isfield(r.meta, 'studyFamily'), studyFamily{k} = r.meta.studyFamily; end
        if isfield(r.meta, 'amplitude_fraction_fast'), amplitudeFractionFast(k) = r.meta.amplitude_fraction_fast; end
        if isfield(r.meta, 'pulse_tStop'), pulseTStop(k) = r.meta.pulse_tStop; end
        if isfield(r.meta, 'sideTimeOffsets')
            offsets = r.meta.sideTimeOffsets;
            if isfield(offsets,'left'), leftOffset(k) = offsets.left; end
            if isfield(offsets,'right'), rightOffset(k) = offsets.right; end
            if isfield(offsets,'bottom'), bottomOffset(k) = offsets.bottom; end
            if isfield(offsets,'top'), topOffset(k) = offsets.top; end
        end
    end
    peakObjective(k) = r.peakObjective;
    finalObjective(k) = r.finalObjective;
    timeAveragedObjective(k) = r.timeAveragedObjective;
    peakRhoCompression(k) = r.peakRhoCompressionRatio;
    peakPressureCompression(k) = r.peakPCompressionRatio;
    peakBCompression(k) = r.peakBCompressionRatio;
    bestRhoUniformity(k) = r.bestMetrics.rhoUniformity;
    bestPressureUniformity(k) = r.bestMetrics.pUniformity;
    bestBUniformity(k) = r.bestMetrics.BmagUniformity;
    finalSymmetryPenalty(k) = r.finalSymmetryPenalty;
    bestSymmetryPenalty(k) = r.bestMetrics.symmetryPenalty;
    finalStagnationPenalty(k) = r.finalStagnationPenalty;
    bestStagnationPenalty(k) = r.bestMetrics.stagnationPenalty;
    maxDivBRms(k) = r.maxDivBRms;
    bestTime(k) = r.bestTime;
end

T = table(runName, studyLabel, studyFamily, amplitudeFractionFast, pulseTStop, ...
    leftOffset, rightOffset, bottomOffset, topOffset, peakObjective, finalObjective, ...
    timeAveragedObjective, peakRhoCompression, peakPressureCompression, peakBCompression, ...
    bestRhoUniformity, bestPressureUniformity, bestBUniformity, ...
    finalSymmetryPenalty, bestSymmetryPenalty, finalStagnationPenalty, ...
    bestStagnationPenalty, maxDivBRms, bestTime);

csvPath = fullfile(outDir, [baseName '_curated_summary.csv']);
matPath = fullfile(outDir, [baseName '_curated_summary.mat']);
writetable(T, csvPath);
save(matPath, 'T', 'ranking');

paths = struct('csvPath', csvPath, 'matPath', matPath);
end
