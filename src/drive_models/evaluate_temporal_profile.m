function a = evaluate_temporal_profile(params, boundaryName, t)
offset = 0.0; if isfield(params, 'sideTimeOffsets') && isfield(params.sideTimeOffsets, boundaryName), offset = params.sideTimeOffsets.(boundaryName); end
tLocal = t - offset;
switch lower(params.temporal_profile)
    case 'smooth_sine_squared', a = pulse_sine_burst(tLocal, params.tStart, params.tStop);
    case 'pulse_train', a = pulse_train(tLocal, params);
    otherwise, error('Unknown temporal profile: %s', params.temporal_profile);
end
end
