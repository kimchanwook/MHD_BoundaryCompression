function a = pulse_smooth_top_hat(t, t0, t1, tau)
a = 0.5*(tanh((t-t0)/tau) - tanh((t-t1)/tau)); a = max(a,0);
end
