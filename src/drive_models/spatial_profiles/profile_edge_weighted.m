function fs = profile_edge_weighted(~, s)
%PROFILE_EDGE_WEIGHTED Stronger drive near boundary-side ends.
    sMin = min(s);
    sMax = max(s);
    xi = 2 * (s - sMin) ./ max(sMax - sMin, eps) - 1;
    fs = abs(xi);
end
