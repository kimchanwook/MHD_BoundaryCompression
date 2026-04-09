function bcData = drive_prescribed_inward_velocity(driveModel, boundaryName, s, t, interiorPrim)
params = driveModel.parameters; active = any(strcmpi(boundaryName, params.boundaries)); amp = 0.0;
if active, amp = params.amplitude * evaluate_temporal_profile(params, boundaryName, t) .* evaluate_spatial_profile(params, s); end
switch lower(boundaryName)
    case 'left', vn = +amp;
    case 'right', vn = -amp;
    case 'bottom', vn = +amp;
    case 'top', vn = -amp;
    otherwise, error('Unknown boundary name: %s', boundaryName);
end
bcData = struct('mode','prescribed_normal_velocity','active',active,'vn',vn,'tangential_rule',params.tangential_rule,'interiorPrim',interiorPrim);
end
