function f = evaluate_spatial_profile(params, s)
switch lower(params.spatial_profile)
    case 'uniform', f = profile_uniform(s);
    case 'cosine_taper', f = profile_cosine_taper(s);
    otherwise, error('Unknown spatial profile: %s', params.spatial_profile);
end
end
