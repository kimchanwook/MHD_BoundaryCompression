function fs = evaluate_spatial_profile(profileName, params, s)
%EVALUATE_SPATIAL_PROFILE Dispatch spatial profile evaluation.
    switch profileName
        case 'uniform'
            fs = profile_uniform(params, s);
        case 'cosine_taper'
            fs = profile_cosine_taper(params, s);
        case 'edge_weighted'
            fs = profile_edge_weighted(params, s);
        case 'user_defined'
            fs = profile_user_defined(params, s);
        otherwise
            error('Unknown spatial profile: %s', profileName);
    end
end
