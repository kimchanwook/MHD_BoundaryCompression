function ft = evaluate_temporal_profile(profileName, params, t)
%EVALUATE_TEMPORAL_PROFILE Dispatch temporal pulse evaluation.
    switch profileName
        case 'gaussian'
            ft = pulse_gaussian(params, t);
        case 'smooth_top_hat'
            ft = pulse_smooth_top_hat(params, t);
        case 'sine_burst'
            ft = pulse_sine_burst(params, t);
        case 'pulse_train'
            ft = pulse_train(params, t);
        otherwise
            error('Unknown temporal profile: %s', profileName);
    end
end
