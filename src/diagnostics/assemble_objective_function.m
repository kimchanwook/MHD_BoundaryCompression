function metrics = assemble_objective_function(metrics, diagnostics)
%ASSEMBLE_OBJECTIVE_FUNCTION Build a physics-motivated scalar objective.
% Compression terms are reward terms. Uniformity, asymmetry, residual flow,
% and divergence are penalty terms.
if nargin < 2 || ~isfield(diagnostics, 'weights')
    diagnostics = default_diagnostics_params();
end
w = diagnostics.weights;

compressionReward = ...
    w.rhoCompression * (metrics.rhoCompressionRatio - 1.0) + ...
    w.BCompression   * (metrics.BCompressionRatio - 1.0) + ...
    w.pressureCompression * (metrics.pCompressionRatio - 1.0);

uniformityPenalty = ...
    w.rhoUniformity * metrics.rhoUniformity + ...
    w.BUniformity   * metrics.BmagUniformity + ...
    w.pressureUniformity * metrics.pUniformity;

symmetryPenalty = w.symmetry * metrics.symmetryPenalty;
stagnationPenalty = w.stagnation * metrics.stagnationPenalty;
divBPenalty = w.divB * metrics.divBRms;

metrics.compressionReward = compressionReward;
metrics.uniformityPenalty = uniformityPenalty;
metrics.symmetryWeightedPenalty = symmetryPenalty;
metrics.stagnationWeightedPenalty = stagnationPenalty;
metrics.divBWeightedPenalty = divBPenalty;

metrics.objective = compressionReward - uniformityPenalty - symmetryPenalty - stagnationPenalty - divBPenalty;
end
