function a = pulse_train(t, params)
if t < params.tStart, a = 0.0; return; end
count = params.pulse_count; period = params.pulse_period; width = params.pulse_width; a = 0.0;
for k = 0:(count-1), tk0 = params.tStart + k*period; tk1 = tk0 + width; a = max(a, pulse_sine_burst(t, tk0, tk1)); end
end
