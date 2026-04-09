function diagnostics = default_diagnostics_params()
diagnostics = struct();

% Core-region definition.
% coreFraction = 0.50 means use the central 50%% of the active cells in x
% and the central 50%% of the active cells in y when computing core metrics.
diagnostics.coreFraction = 0.50;

% Objective weights.
% Positive terms reward compression quality.
% Penalty terms suppress nonuniformity, asymmetry, residual flow, and large
% divergence error.
diagnostics.weights = struct();
diagnostics.weights.rhoCompression    = 1.00;
diagnostics.weights.BCompression      = 0.75;
diagnostics.weights.pressureCompression = 0.50;
diagnostics.weights.rhoUniformity     = 1.00;
diagnostics.weights.BUniformity       = 0.75;
diagnostics.weights.pressureUniformity = 0.50;
diagnostics.weights.symmetry          = 0.75;
diagnostics.weights.stagnation        = 0.40;
diagnostics.weights.divB              = 0.10;
end
