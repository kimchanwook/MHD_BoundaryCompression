function ft = pulse_smooth_top_hat(params, t)
%PULSE_SMOOTH_TOP_HAT Smooth rise-hold-fall pulse.
    tOn = params.t_on;
    tRise = params.t_rise;
    tHold = params.t_hold;
    tFall = params.t_fall;
    t1 = tOn;
    t2 = t1 + tRise;
    t3 = t2 + tHold;
    t4 = t3 + tFall;

    if t < t1 || t > t4
        ft = 0;
    elseif t <= t2
        xi = (t - t1) / max(tRise, eps);
        ft = 0.5 * (1 - cos(pi * xi));
    elseif t <= t3
        ft = 1;
    else
        xi = (t - t3) / max(tFall, eps);
        ft = 0.5 * (1 + cos(pi * xi));
    end
end
