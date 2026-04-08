function fs = profile_cosine_taper(params, s)
%PROFILE_COSINE_TAPER Cosine taper with stronger center drive.
    if isempty(s)
        fs = [];
        return;
    end
    if ~isfield(params,'power'); params.power = 1; end
    sMin = min(s);
    sMax = max(s);
    xi = 2 * (s - sMin) ./ max(sMax - sMin, eps) - 1;
    fs = cos(0.5 * pi * xi).^params.power;
end
