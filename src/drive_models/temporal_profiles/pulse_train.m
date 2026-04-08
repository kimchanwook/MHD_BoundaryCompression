function ft = pulse_train(params, t)
%PULSE_TRAIN Repeated square-like pulses.
    if t < 0
        ft = 0;
        return;
    end
    if ~isfield(params,'period'); params.period = 0.2; end
    if ~isfield(params,'pulse_width'); params.pulse_width = 0.05; end
    if ~isfield(params,'nPulses'); params.nPulses = 3; end

    k = floor(t / params.period);
    if k >= params.nPulses
        ft = 0;
        return;
    end

    tau = t - k * params.period;
    ft = double(tau <= params.pulse_width);
end
