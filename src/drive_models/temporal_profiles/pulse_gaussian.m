function a = pulse_gaussian(t, t0, sigma)
a = exp(-((t-t0)./sigma).^2);
end
