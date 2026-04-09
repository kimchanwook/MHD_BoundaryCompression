function summary = summarize_run(result, caseConfig, grid, physics)
history = result.history;
summary = struct();
summary.runName = caseConfig.runName;
summary.finalTime = result.t;
summary.steps = result.step;
summary.grid = sprintf('%dx%d', grid.Nx, grid.Ny);
summary.gamma = physics.gamma;
summary.coreFraction = caseConfig.diagnostics.coreFraction;

summary.finalObjective = get_last(history.objective);
summary.peakObjective = max(history.objective);
summary.timeAveragedObjective = mean(history.objective);

summary.finalCompressionReward = get_last(history.compressionReward);
summary.peakCompressionReward = max(history.compressionReward);
summary.timeAveragedCompressionReward = mean(history.compressionReward);

summary.finalRhoCoreMean = get_last(history.rhoCoreMean);
summary.peakRhoCoreMean = max(history.rhoCoreMean);
summary.finalPCoreMean = get_last(history.pCoreMean);
summary.peakPCoreMean = max(history.pCoreMean);
summary.finalBmagCoreMean = get_last(history.BmagCoreMean);
summary.peakBmagCoreMean = max(history.BmagCoreMean);

summary.finalRhoCompressionRatio = get_last(history.rhoCompressionRatio);
summary.peakRhoCompressionRatio = max(history.rhoCompressionRatio);
summary.finalPCompressionRatio = get_last(history.pCompressionRatio);
summary.peakPCompressionRatio = max(history.pCompressionRatio);
summary.finalBCompressionRatio = get_last(history.BCompressionRatio);
summary.peakBCompressionRatio = max(history.BCompressionRatio);

summary.finalRhoUniformity = get_last(history.rhoUniformity);
summary.minRhoUniformity = min(history.rhoUniformity);
summary.finalPUniformity = get_last(history.pUniformity);
summary.minPUniformity = min(history.pUniformity);
summary.finalBmagUniformity = get_last(history.BmagUniformity);
summary.minBmagUniformity = min(history.BmagUniformity);

summary.finalSymmetryPenalty = get_last(history.symmetryPenalty);
summary.minSymmetryPenalty = min(history.symmetryPenalty);
summary.finalSymmetryLeftRight = get_last(history.symmetryLeftRight);
summary.maxSymmetryLeftRight = max(history.symmetryLeftRight);
summary.finalSymmetryTopBottom = get_last(history.symmetryTopBottom);
summary.maxSymmetryTopBottom = max(history.symmetryTopBottom);
summary.finalVCoreMean = get_last(history.vCoreMean);
summary.minVCoreMean = min(history.vCoreMean);
summary.finalVCoreMax = get_last(history.vCoreMax);
summary.minVCoreMax = min(history.vCoreMax);
summary.finalStagnationPenalty = get_last(history.stagnationPenalty);
summary.minStagnationPenalty = min(history.stagnationPenalty);

summary.finalDivBMax = get_last(history.divBMax);
summary.maxDivBMax = max(history.divBMax);
summary.finalDivBRms = get_last(history.divBRms);
summary.maxDivBRms = max(history.divBRms);
summary.finalPsiMax = get_last(history.psiMax);
summary.maxPsiMax = max(history.psiMax);
summary.finalPsiRms = get_last(history.psiRms);
summary.maxPsiRms = max(history.psiRms);

summary.initialMassTotal = get_first(history.massTotal);
summary.finalMassTotal = get_last(history.massTotal);
summary.initialTotalEnergy = get_first(history.totalEnergyTotal);
summary.finalTotalEnergy = get_last(history.totalEnergyTotal);
summary.initialKineticEnergy = get_first(history.kineticEnergyTotal);
summary.finalKineticEnergy = get_last(history.kineticEnergyTotal);
summary.initialInternalEnergy = get_first(history.internalEnergyTotal);
summary.finalInternalEnergy = get_last(history.internalEnergyTotal);
summary.initialMagneticEnergy = get_first(history.magneticEnergyTotal);
summary.finalMagneticEnergy = get_last(history.magneticEnergyTotal);
summary.massDrift = relative_change(summary.initialMassTotal, summary.finalMassTotal);
summary.totalEnergyDrift = relative_change(summary.initialTotalEnergy, summary.finalTotalEnergy);
summary.maxMomentumMagnitude = max(sqrt(history.momentumXTotal.^2 + history.momentumYTotal.^2 + history.momentumZTotal.^2));

summary.bestTimeIndex = find(history.objective == summary.peakObjective, 1, 'first');
summary.bestTime = history.t(summary.bestTimeIndex);
summary.bestMetrics = struct(...
    'rhoCompressionRatio', history.rhoCompressionRatio(summary.bestTimeIndex), ...
    'pCompressionRatio', history.pCompressionRatio(summary.bestTimeIndex), ...
    'BCompressionRatio', history.BCompressionRatio(summary.bestTimeIndex), ...
    'rhoUniformity', history.rhoUniformity(summary.bestTimeIndex), ...
    'pUniformity', history.pUniformity(summary.bestTimeIndex), ...
    'BmagUniformity', history.BmagUniformity(summary.bestTimeIndex), ...
    'symmetryPenalty', history.symmetryPenalty(summary.bestTimeIndex), ...
    'stagnationPenalty', history.stagnationPenalty(summary.bestTimeIndex), ...
    'divBRms', history.divBRms(summary.bestTimeIndex));

if isfield(caseConfig, 'meta')
    summary.meta = caseConfig.meta;
else
    summary.meta = struct();
end
if isfield(caseConfig.drive, 'parameters')
    params = caseConfig.drive.parameters;
    if isfield(params, 'amplitude_fraction_fast')
        summary.meta.amplitude_fraction_fast = params.amplitude_fraction_fast;
    end
    if isfield(params, 'tStop')
        summary.meta.tStop = params.tStop;
    end
    if isfield(params, 'temporal_profile')
        summary.meta.temporal_profile = params.temporal_profile;
    end
    if isfield(params, 'spatial_profile')
        summary.meta.spatial_profile = params.spatial_profile;
    end
end
end

function value = get_last(x)
if isempty(x)
    value = NaN;
else
    value = x(end);
end
end

function value = get_first(x)
if isempty(x)
    value = NaN;
else
    value = x(1);
end
end

function value = relative_change(a, b)
if ~isfinite(a) || abs(a) < eps
    value = NaN;
else
    value = (b - a) / a;
end
end
