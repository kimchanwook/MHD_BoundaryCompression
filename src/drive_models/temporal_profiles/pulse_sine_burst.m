function ft = pulse_sine_burst(params, t)
%PULSE_SINE_BURST Windowed sine-squared pulse.
    if ~isfield(params,'duration'); params.duration = 0.2; end
    if t < 0 || t > params.duration
        ft = 0;
    else
        ft = sin(pi * t / params.duration).^2;
    end
end
