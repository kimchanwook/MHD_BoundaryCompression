function ft = pulse_gaussian(params, t)
%PULSE_GAUSSIAN Gaussian temporal pulse.
    if ~isfield(params, 't0'); params.t0 = 0.2; end
    if ~isfield(params, 'sigma'); params.sigma = 0.05; end
    ft = exp(-0.5 * ((t - params.t0) ./ params.sigma).^2);
end
