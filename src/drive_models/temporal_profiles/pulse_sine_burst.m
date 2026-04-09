function a = pulse_sine_burst(t, tStart, tStop)
if t < tStart || t > tStop, a = 0.0; else, xi = (t - tStart) / max(tStop - tStart, eps); a = sin(pi * xi)^2; end
end
